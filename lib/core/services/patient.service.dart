import 'dart:convert';

import 'package:rhema_rapha_app/core/constants/endpoints.dart';
import 'package:rhema_rapha_app/core/constants/localkeys.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/patient.dto.dart';
import 'package:rhema_rapha_app/core/models/patient.model.dart';
import 'package:rhema_rapha_app/core/services/base.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientService extends BaseService {
  Future<Result> getPatientsById() async {
    var url = EndPoints.getPatientUrl();

    var res = await getRequest('$url');

    if (res != null && res.statusCode == 200) {
      var decodedData = jsonDecode(res.body);
      var data = decodedData['data'];

      var parsedPatient = Patient.fromJson(data);

      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(USER_ID, parsedPatient.id);

      return Result(
          data: parsedPatient, isSuccessful: true, message: data['message']);
    }

    if (res != null && res.statusCode == 400) {
      var data = jsonDecode(res.body);
      return Result(isSuccessful: false, message: data['message']);
    }

    return Result(
      isSuccessful: false,
      message: 'Please Check Your Connection',
    );
  }

  Future<Result> updatePatient(PatientDto newPatient) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString(USER_ID);
    var url = EndPoints.getPatientUrl();

    var res = await putRequest(
        "$url/$userId", newPatient.patientDtoToJson(newPatient));

    if (res != null && res.statusCode == 201) {
      getPatientsById();

      return Result(
        isSuccessful: true,
      );
    }

    if (res != null && res.statusCode == 400) {
      var data = jsonDecode(res.body);
      return Result(
        isSuccessful: false,
        message: data['message'],
      );
    }

    return Result(isSuccessful: false, message: 'Please Check Your Connection');
  }
}
