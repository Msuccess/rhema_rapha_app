import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/text_style.dart';
import 'package:rhema_rapha_app/core/constants/regex.constants.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/user.model.dart';
import 'package:rhema_rapha_app/core/routes/routes.dart';
import 'package:rhema_rapha_app/core/services/util.service.dart';
import 'package:rhema_rapha_app/core/view_models/register.viewmodel.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';
import 'package:rhema_rapha_app/views/widgets/button.widget.dart';
import 'package:rhema_rapha_app/views/widgets/datepicker.widget.dart';
import 'package:rhema_rapha_app/views/widgets/input.widget.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String _email;
  String _fullName;
  String _phonenumber;
  String _password;
  String _dateOfBirth;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RegisterViewModel>(
      model: RegisterViewModel(
        authenticationService: Provider.of(context),
      ),
      builder: (BuildContext context, RegisterViewModel model, Widget child) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          _sectionHeader(),
                          SizedBox(height: 32.0),
                          _builFullnameField(model),
                          SizedBox(height: 32.0),
                          _buildEmailField(model),
                          SizedBox(height: 32.0),
                          _buildPhoneNumberField(model),
                          SizedBox(height: 32.0),
                          _builDateBirthField(model),
                          SizedBox(height: 32.0),
                          _buildPasswordField(model),
                          SizedBox(height: 32.0),
                          _buildButton(model),
                          SizedBox(height: 18.0),
                          Center(
                            child: FlatButton(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                RoutePaths.Login,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Already have an account?  ',
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Sign in',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  onSigninSuccess(Result result, BuildContext context) {
    if (result.data['user']) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutePaths.Home,
        (_) => false,
      );
      return;
    }
  }

  Widget _buildEmailField(RegisterViewModel model) {
    return InputWidget(
      text: 'Email',
      iconSize: 15.0,
      inputPrefixIcon: FeatherIcons.mail,
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

  Widget _buildPhoneNumberField(RegisterViewModel model) {
    return InputWidget(
      text: 'Phone Number',
      iconSize: 15.0,
      inputType: TextInputType.phone,
      inputPrefixIcon: FeatherIcons.phone,
      onSaved: (String phonenumber) => _phonenumber = phonenumber,
      validator: (String phonenumber) {
        if (phonenumber.isEmpty) return 'Phone number is required';
        return null;
      },
    );
  }

  Widget _builFullnameField(RegisterViewModel model) {
    return InputWidget(
      text: 'Full Name',
      iconSize: 15.0,
      inputPrefixIcon: FeatherIcons.user,
      onSaved: (String fullName) => _fullName = fullName,
      validator: (String fullName) {
        if (fullName.isEmpty) return 'Full name is required';
        return null;
      },
    );
  }

  Widget _builDateBirthField(RegisterViewModel model) {
    return InputDateTimeField(
      text: 'Date of Birth',
      onSaved: (DateTime dateOfBirth) => _dateOfBirth = dateOfBirth.toString(),
      validator: (DateTime dateOfBirth) {
        if (dateOfBirth == null) return 'Date of Birth is required';
        return null;
      },
    );
  }

  Widget _buildPasswordField(RegisterViewModel model) {
    return InputWidget(
      text: 'Password',
      isPassword: !model.passwordVisibility,
      visibility: model.passwordVisibility,
      iconSize: 25.0,
      inputPrefixIcon: FeatherIcons.lock,
      onSaved: (String password) => _password = password,
      suffixIconOnPressed: () => model.togglePasswordVisibility(),
      validator: (String password) {
        if (password.isEmpty) {
          return 'Password is required';
        }
        if (password.length < 8) {
          return 'Password Lenght must be more than 8';
        }
        return null;
      },
    );
  }

  Widget _buildButton(RegisterViewModel model) {
    return ButtonWidget(
      busy: model.busy,
      text: 'Sign up',
      onPressed: () async {
        if (!_formkey.currentState.validate()) return;
        _formkey.currentState.save();
        final signupDto = User(
          email: _email,
          password: _password,
          dateOfBirth: _dateOfBirth,
          fullName: _fullName,
          phonenumber: _phonenumber,
        );
        print(signupDto.dateOfBirth);
        var result = await model.signup(signupDto);
        if (result.isSuccessful) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutePaths.Tabs,
            (_) => false,
          );
        } else {
          UtilService.showErrorToast(result.message);
        }
      },
    );
  }

  _sectionHeader() {
    return Column(
      children: [
        Image.asset(
          'lib/assets/images/Logo.png',
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'Register',
            style: AppTexts.h1,
          ),
        ),
      ],
    );
  }
}
