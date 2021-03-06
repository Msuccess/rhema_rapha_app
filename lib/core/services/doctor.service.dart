import 'dart:convert';

import 'package:rhema_rapha_app/core/constants/endpoints.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/services/base.service.dart';

class DoctorService extends BaseService {
  Future<Result<List<Doctor>>> getDoctors() async {
    var url = EndPoints.getDoctorUrl();

    var res = await getRequest(url);

    if (res != null && res.statusCode == 200) {
      var data = jsonDecode(res.body);

      var doctors = data['data'] as List<dynamic>;
      var parsedDoctor = doctors.map((e) => Doctor.fromJson(e)).toList();

      return Result<List<Doctor>>(
        data: parsedDoctor,
        isSuccessful: true,
        message: data['message'],
      );
    }

    if (res != null && res.statusCode == 400) {
      var data = jsonDecode(res.body);
      return Result(data: [], message: data['message']);
    }

    return Result(
      isSuccessful: false,
      message: 'Please Check Your Connection',
    );
  }
}
