import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/user.model.dart';
import 'package:rhema_rapha_app/core/services/authservice.dart';
import 'package:rhema_rapha_app/core/view_models/base.viewmodel.dart';

class RegisterViewModel extends BaseViewModel{

  AuthService _authenticationService;
  bool passwordVisibility = false;
  bool confirmPasswordVisibility = false;

  get dobTextController => TextEditingController();


  RegisterViewModel({
    @required AuthService authenticationService,
  }) : _authenticationService = authenticationService;

  Future<Result> signup(User user) async {
    setBusy(true);
    Result result = await _authenticationService.signup(user);
    
    setBusy(false);
    return result;
  }

  void togglePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  toggleConfirmPasswordVisibility() {
    confirmPasswordVisibility = !confirmPasswordVisibility;
    notifyListeners();
  }

  void setDOB(DateTime dob) {
    if (dob != null) {
      dobTextController.text = dob.toString();
      notifyListeners();
    }
  }
}