import 'dart:convert';

import 'package:rhema_rapha_app/core/constants/endpoints.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/department.model.dart';
import 'package:rhema_rapha_app/core/services/base.service.dart';


class DepartmentService extends BaseService {
  Future<Result<List<Department>>> getDepartments() async {
    var url = EndPoints.getDepartmentUrl();
    var res = await getRequest(url);

    if (res != null && res.statusCode == 200) {
      var data = jsonDecode(res.body);

      var departments = data['data'] as List<dynamic>;
      var parsedDepartment =
          departments.map((e) => Department.fromJson(e)).toList();

      return Result<List<Department>>(
        data: parsedDepartment,
        isSuccessful: true,
        message: data['message'],
      );
    }

    if (res != null && res.statusCode == 400) {
      var data = jsonDecode(res.body);

      return Result(data: [] as List<Department>, message: data['message']);
    }

    return Result(
      isSuccessful: false,
      message: 'Something went wrong',
    );
  }

  Future<Result<Department>> getDepartmentById(String id) async {
    var url = EndPoints.getDepartmentUrl();

    var res = await getRequest('$url/$id');

    if (res != null && res.statusCode == 200) {
      var data = jsonDecode(res.body);

      var parsedDepartment = Department.fromJson(data['data']);
      print(parsedDepartment);
      
      return Result(
          data: parsedDepartment, isSuccessful: true, message: data['message']);
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
