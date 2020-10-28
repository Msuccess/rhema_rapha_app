import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/core/constants/localkeys.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/patient.dto.dart';
import 'package:rhema_rapha_app/core/models/patient.model.dart';
import 'package:rhema_rapha_app/core/services/authservice.dart';
import 'package:rhema_rapha_app/core/services/patient.service.dart';
import 'package:rhema_rapha_app/core/services/util.service.dart';
import 'package:rhema_rapha_app/core/view_models/base.viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SingingCharacter { Male, Female }

class ProfileViewModel extends BaseViewModel {
  bool isBusy = false;
  PatientService _patientService;
  Patient patient;
  String genderValue;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _bloodPressureController = TextEditingController();
  TextEditingController _bloodTypeController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  TextEditingController get fullName => _fullNameController;
  TextEditingController get dateOfBirth => _dateOfBirthController;
  TextEditingController get email => _emailController;
  TextEditingController get phonenumber => _phonenumberController;
  TextEditingController get address => _addressController;
  TextEditingController get bloodPressure => _bloodPressureController;
  TextEditingController get bloodType => _bloodTypeController;
  TextEditingController get height => _heightController;
  TextEditingController get gender => _genderController;

  ProfileViewModel(
      {@required PatientService patientService, AuthService authService})
      : _patientService = patientService;

  Future<Result> getPatient() async {
    setBusy(true);
    Result result = await _patientService.getPatientsById();
    patient = result.data;

    _fullNameController.text = patient.fullName;
    _dateOfBirthController.text = patient.dateOfBirth;
    _phonenumberController.text = patient.phonenumber;
    _emailController.text = patient.email;
    _addressController.text = patient.address;
    _bloodPressureController.text = patient.bloodPressure;
    _bloodTypeController.text = patient.bloodType;
    _heightController.text = patient.height;
    _genderController.text = patient.gender == null ? '' : patient.gender;

    setBusy(false);
    return result;
  }

  Future updatePatientDetails(BuildContext context) async {
    setBusy(true);
    notifyListeners();

    final newPatient = PatientDto(
      fullName: _fullNameController.value.text,
      dateOfBirth: _dateOfBirthController.value.text,
      phonenumber: _phonenumberController.value.text,
      email: _emailController.value.text,
      address: _addressController.value.text,
      bloodPressure: _bloodPressureController.value.text,
      bloodType: _bloodTypeController.value.text,
      height: _heightController.value.text,
      gender: _genderController.text,
    );

    Result result = await _patientService.updatePatient(newPatient);

    if (result.isSuccessful == true) {
      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool(PROFILE_UPDATE, true);

      UtilService.showSuccessToast('Profile Update Successfull');
    } else {
      setBusy(false);
      UtilService.showErrorToast('Error Updating profile');
    }
    setBusy(false);
  }

  onGenderSelect(String newGender) {
    gender.text = newGender;
    notifyListeners();
  }

  onDateOfBirthSelect(String newDateOfBirth) {
    dateOfBirth.text = newDateOfBirth;
    notifyListeners();
  }

  void init() {
    print("Heollll");
    getPatient();
  }
}
