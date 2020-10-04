import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:rhema_rapha_app/assets/styles/sizes.dart';

import 'package:rhema_rapha_app/assets/styles/text_style.dart';
import 'package:rhema_rapha_app/core/constants/regex.constants.dart';
import 'package:rhema_rapha_app/core/view_models/profile.viewmodel.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';
import 'package:rhema_rapha_app/views/widgets/button.widget.dart';
import 'package:rhema_rapha_app/views/widgets/datepicker.widget.dart';
import 'package:rhema_rapha_app/views/widgets/input.widget.dart';
import 'package:rhema_rapha_app/views/widgets/selectInput.widget.dart';

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
      onModelReady: (ProfileViewModel model) async {
        model.getPatient();
      },
      builder: (BuildContext context, ProfileViewModel model, Widget child) {
        if (model.patient == null) return SizedBox.shrink();

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
                      SizedBox(height: 30.0),
                      _builFullnameField(model),
                      SizedBox(height: 20.0),
                      _buildEmailField(model),
                      SizedBox(height: 20.0),
                      _buildPhoneNumberField(model),
                      SizedBox(height: 20.0),
                      _buildAddressField(model),
                      SizedBox(height: 20.0),
                      _builGenderField(model),
                      SizedBox(height: 20.0),
                      _builBloodTypeField(model),
                      SizedBox(height: 20.0),
                      _builDateBirthField(model),
                      SizedBox(height: 20.0),
                      _builHeightField(model),
                      SizedBox(height: 20.0),
                      _builBloodPressureField(model),
                      SizedBox(height: 30.0),
                      _buildCallToAction(model),
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
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'Update profile',
            style: AppTexts.h20,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(ProfileViewModel model) {
    print(model.email.text);
    return InputWidget(
      text: 'Email',
      iconSize: 15.0,
      inputPrefixIcon: FeatherIcons.mail,
      inputType: TextInputType.emailAddress,
      controller: model.email,
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
      controller: model.phonenumber,
      inputPrefixIcon: FeatherIcons.phone,
      onSaved: (String phonenumber) {
        return model.phonenumber.text = phonenumber;
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
      controller: model.fullName,
      inputPrefixIcon: FeatherIcons.user,
      onSaved: (String fullName) {
        return model.fullName.text = fullName;
      },
      validator: (String fullName) {
        if (fullName.isEmpty) return 'Full name is required';
        return null;
      },
    );
  }

  Widget _builHeightField(ProfileViewModel model) {
    return InputWidget(
      text: 'Height',
      iconSize: 15.0,
      controller: model.height,
      inputPrefixIcon: FeatherIcons.maximize2,
      onSaved: (String height) {
        return model.height.text = height;
      },
    );
  }

  Widget _builBloodTypeField(ProfileViewModel model) {
    return InputWidget(
      text: 'Blood Type',
      iconSize: 15.0,
      controller: model.bloodType,
      inputPrefixIcon: FeatherIcons.droplet,
      onSaved: (String bloodType) {
        return model.bloodType.text = bloodType;
      },
    );
  }

  Widget _buildAddressField(ProfileViewModel model) {
    return InputWidget(
      text: 'Address',
      iconSize: 15.0,
      controller: model.address,
      inputPrefixIcon: FeatherIcons.mapPin,
      onSaved: (String address) {
        return model.address.text = address;
      },
    );
  }

  Widget _builBloodPressureField(ProfileViewModel model) {
    return InputWidget(
      text: 'Blood Pressure',
      iconSize: 15.0,
      controller: model.bloodPressure,
      inputPrefixIcon: FeatherIcons.droplet,
      onSaved: (String bloodPressure) {
        return model.bloodPressure.text = bloodPressure;
      },
    );
  }

  Widget _builDateBirthField(ProfileViewModel model) {
    return InputDateTimeField(
      text: 'Date of Birth',
      onSaved: (DateTime dateOfBirth) {
        model.dateOfBirth.text = dateOfBirth.toString();
      },
      currentDate: DateTime.parse(model.dateOfBirth.text),
      validator: (DateTime dateOfBirth) {
        if (dateOfBirth == null) return 'Date of Birth is required';
        return null;
      },
    );
  }

  Widget _builGenderField(ProfileViewModel model) {
    return SelectInputField(
      text: "Gender",
      onSaved: (String gender) {
        print(gender);
        return model.gender.text = gender;
      },
    );
  }

  Widget _buildCallToAction(ProfileViewModel model) {
    return ButtonWidget(
      text: 'Save changes',
      busy: model.busy,
      onPressed: () => model.updatePatientDetails(context),
    );
  }
}
