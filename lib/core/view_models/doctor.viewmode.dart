import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/view_models/base.viewmodel.dart';

import '../models/department.model.dart';
import '../services/department.service.dart';

class DoctorViewModel extends BaseViewModel {
  DepartmentService _departmentService;

  DoctorViewModel({@required DepartmentService departmentService})
      : _departmentService = departmentService;
  Department department;
  
  Future<Result> getDepartment(String id) async {
    setBusy(true);
    var result = await _departmentService.getDepartmentById(id);
    department = result.data;
    setBusy(false);
    return result;
  }
}
