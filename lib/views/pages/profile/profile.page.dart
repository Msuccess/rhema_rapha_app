import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/text_style.dart';
import 'package:rhema_rapha_app/core/constants/regex.constants.dart';
import 'package:rhema_rapha_app/core/routes/routes.dart';
import 'package:rhema_rapha_app/core/services/util.service.dart';
import 'package:rhema_rapha_app/core/view_models/profile.viewmodel.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';
import 'package:rhema_rapha_app/views/widgets/button.widget.dart';
import 'package:rhema_rapha_app/views/widgets/datepicker.widget.dart';
import 'package:rhema_rapha_app/views/widgets/input.widget.dart';
import 'package:rhema_rapha_app/views/widgets/random_color.widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ProfileViewModel>(
      model: ProfileViewModel(
        patientService: Provider.of(context),
        authService: Provider.of(context),
      ),
      onModelReady: (model) => model.getPatient(),
      builder: (BuildContext context, ProfileViewModel model, Widget child) {
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
                      _sectionHeader(),
                      SizedBox(height: 10.0),
                      _builFullnameField(model),
                      SizedBox(height: 5.0),
                      _buildEmailField(model),
                      SizedBox(height: 10.0),
                      _buildPhoneNumberField(model),
                      SizedBox(height: 10.0),
                      _buildEmailField(model),
                      SizedBox(height: 10.0),
                      _builDateBirthField(model),
                        SizedBox(height: 10.0),
                      _builHeightField(model),
                      SizedBox(height: 10.0),
                      _builBloodPressureField(model),
                      SizedBox(height: 30.0),
                      model.busy
                          ? SizedBox.shrink()
                          : _buildCallToAction(model),
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

  _sectionHeader() {
    return Column(
      children: [
        CircleAvatar(
          maxRadius: 40.0,
          backgroundColor: randomColor(),
          child: Text(
            "",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
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

  Widget _buildEmailField(ProfileViewModel model) {
    return InputWidget(
      text: 'Email',
      iconSize: 15.0,
      inputPrefixIcon: FeatherIcons.mail,
      inputType: TextInputType.emailAddress,
      onSaved: (String email) {
        return model.email.text = email;
      },
      validator: (String email) {
        if (email.isEmpty) return 'Email is required';
        if (!RegExp(emailRegex).hasMatch(email))
          return 'Please enter a valid email';
        return null;
      },
    );
  }

  Widget _buildPhoneNumberField(ProfileViewModel model) {
    return InputWidget(
      text: 'Phone Number',
      iconSize: 15.0,
      inputType: TextInputType.phone,
      inputPrefixIcon: FeatherIcons.phone,
      onSaved: (String phonenumber) {
      return  model.phonenumber.text = phonenumber;
      },
      validator: (String phonenumber) {
        if (phonenumber.isEmpty) return 'Phone number is required';
        return null;
      },
    );
  }

  Widget _builFullnameField(ProfileViewModel model) {
    return InputWidget(
      text: 'Full Name',
      iconSize: 15.0,
      inputPrefixIcon: FeatherIcons.user,
      onSaved: (String fullName){
      return  model.fullName.text = fullName;
      } ,
      validator: (String fullName) {
        if (fullName.isEmpty) return 'Full name is required';
        return null;
      },
    );
  }

   Widget _builHeightField(ProfileViewModel model) {
    return InputWidget(
      text: 'Full Name',
      iconSize: 15.0,
      inputPrefixIcon: FeatherIcons.user,
      onSaved: (String height){
      return  model.height.text = height;
      } ,
    );
  }

Widget _builBloodPressureField(ProfileViewModel model) {
    return InputWidget(
      text: 'Full Name',
      iconSize: 15.0,
      inputPrefixIcon: FeatherIcons.user,
      onSaved: (String bloodPressure){
      return  model.bloodPressure.text = bloodPressure;
      } ,
    
    );
  }

  Widget _builDateBirthField(ProfileViewModel model) {
    return InputDateTimeField(
      text: 'Date of Birth',
      onSaved: (DateTime dateOfBirth) {model.dateOfBirth.text = dateOfBirth.toString();},
      validator: (DateTime dateOfBirth) {
        if (dateOfBirth == null) return 'Date of Birth is required';
        return null;
      },
    );
  }



  Widget _buildCallToAction(ProfileViewModel model) {
    return ButtonWidget(
      text: 'Save changes',
      busy: model.isBusy,
      onPressed: () => model.updatePatient(context),
    );
  }
}
