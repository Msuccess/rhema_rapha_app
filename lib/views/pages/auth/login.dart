import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/text_style.dart';
import 'package:rhema_rapha_app/core/constants/regex.constants.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/signin.model.dart';
import 'package:rhema_rapha_app/core/models/user.model.dart';
import 'package:rhema_rapha_app/core/routes/routes.dart';
import 'package:rhema_rapha_app/core/services/util.service.dart';
import 'package:rhema_rapha_app/core/view_models/login.viewmodel.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';
import 'package:rhema_rapha_app/views/widgets/button.widget.dart';
import 'package:rhema_rapha_app/views/widgets/input.widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(
        authenticationService: Provider.of(context),
      ),
      onModelReady: (LoginViewModel model) async {
        await model.isUserAuthenticated();
      },
      builder: (BuildContext context, LoginViewModel model, Widget child) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: PageView(
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height,
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      _sectionHeader(),
                                      SizedBox(height: 50.0),
                                      _buildEmailField(model),
                                      SizedBox(height: 32.0),
                                      _buildPasswordField(model),
                                      SizedBox(height: 20.0),
                                      FlatButton(
                                        onPressed: () => Navigator.pushNamed(
                                            context, RoutePaths.Splash),
                                        child: Text(
                                          'Forgot Password',
                                          style: TextStyle(
                                              color: AppColors.primaryText),
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          ButtonWidget(
                                            busy: model.busy,
                                            text: 'Sign in',
                                            onPressed: () async {
                                              if (!_formkey.currentState
                                                  .validate()) return;
                                              _formkey.currentState.save();
                                              final signinDto = SignIn(
                                                email: _email.trim(),
                                                password: _password,
                                              );
                                              var result =
                                                  await model.signin(signinDto);
                                              if (result.isSuccessful) {
                                                onSigninSuccess(
                                                    result, context);
                                              } else {
                                                UtilService.showErrorToast(
                                                    result.message);
                                              }
                                            },
                                          ),
                                          SizedBox(
                                            height: 18.0,
                                          ),
                                          FlatButton(
                                            onPressed: () =>
                                                Navigator.pushNamed(
                                              context,
                                              RoutePaths.Register,
                                            ),
                                            child: RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        'Dont have account ?  ',
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.primaryText,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'Create account',
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  onSigninSuccess(Result result, BuildContext context) {
    if (result.data['dbUser'] != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutePaths.Tabs,
        (_) => false,
      );
      return;
    }
  }

  Widget _buildEmailField(LoginViewModel model) {
    return InputWidget(
      text: 'Email',
      iconSize: 15.0,
      inputPrefixIcon: FeatherIcons.mail,
      controller: model.emailController,
      inputType: TextInputType.emailAddress,
      onSaved: (String email) => _email = email,
      validator: (String email) {
        if (email.isEmpty) return 'Email is required';
        if (!RegExp(emailRegex).hasMatch(email))
          return 'Please enter a valid email';
        return null;
      },
    );
  }

  Widget _buildPasswordField(LoginViewModel model) {
    return InputWidget(
      text: 'Password',
      isPassword: !model.obs,
      visibility: model.obs,
      iconSize: 25.0,
      inputPrefixIcon: FeatherIcons.lock,
      onSaved: (String password) => _password = password,
      suffixIconOnPressed: () => model.togglePasswordVisibility(),
      validator: (String password) {
        if (password.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
    );
  }

  Widget _sectionHeader() {
    return Column(
      children: [
        Image.asset(
          'lib/assets/images/Logo.png',
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'Login',
            style: AppTexts.h1,
          ),
        ),
      ],
    );
  }
}
