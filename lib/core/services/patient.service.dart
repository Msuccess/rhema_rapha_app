import 'dart:convert';

import 'package:rhema_rapha_app/core/constants/endpoints.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/patient.model.dart';
import 'package:rhema_rapha_app/core/services/base.service.dart';


class PatientService extends BaseService {
  Future<Result> getPatientsById(String id) async {
    var url = EndPoints.getPatientUrl();

    var res = await getRequest('$url/$id');
    
        if (res != null && res.statusCode == 200) {
          var data = jsonDecode(res.body);
    
          var parsedPatient = Patient.fromJson(data);
          return Result(
              data: parsedPatient, isSuccessful: true, message: data['message']);
        }
    
        if (res != null && res.statusCode == 400) {
          var data = jsonDecode(res.body);
          return Result(isSuccessful: false, message: data['message']);
        }
    
        return Result(
          isSuccessful: false,
          message: 'Something went wrong',
        );
      }

}
