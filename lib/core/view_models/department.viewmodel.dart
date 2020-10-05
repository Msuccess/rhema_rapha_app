import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/department.model.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/services/department.service.dart';
import 'package:rhema_rapha_app/core/view_models/base.viewmodel.dart';

class DepartmentViewModel extends BaseViewModel {
  DepartmentService _departmentService;

  DepartmentViewModel({@required DepartmentService departmentService})
      : _departmentService = departmentService;

  Department department;
  List<Doctor> doctors;

  Future<Result> getDepartment(String id) async {
    setBusy(true);
    var result = await _departmentService.getDepartmentById(id);
    department = result.data;

    doctors = result.data.doctor;
    setBusy(false);
    return result;
  }
}
