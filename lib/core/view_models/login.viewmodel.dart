import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/signin.model.dart';
import 'package:rhema_rapha_app/core/services/authservice.dart';
import 'package:rhema_rapha_app/core/view_models/base.viewmodel.dart';

class LoginViewModel extends BaseViewModel{
  bool obs = false;
  bool authenticated = false;
  bool isAuthenticating = false;
  AuthService _authenticationService;

  bool isAuthenticated = false;

  TextEditingController emailController = TextEditingController();

  LoginViewModel({
    @required AuthService authenticationService,
  }) : _authenticationService = authenticationService;

  Future<void> isUserAuthenticated() async {
    isAuthenticated = await AuthService.isAuthenticated();
  }


  Future<Result> signin(SignIn user) async {
    setBusy(true);
    Result result = await _authenticationService.signin(user);
    setBusy(false);
    return result;
  }

  void togglePasswordVisibility() {
    obs = !obs;
    notifyListeners();
  }

  void getUserEmail() async {
    var email = await AuthService.getUserLoggedEmail();
    emailController.text = email;
    notifyListeners();
  }

  
}