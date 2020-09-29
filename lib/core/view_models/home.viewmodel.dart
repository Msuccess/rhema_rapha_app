import 'dart:collection';
import 'package:flutter/cupertino.dart';

import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/department.model.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/services/authservice.dart';
import 'package:rhema_rapha_app/core/services/department.service.dart';
import 'package:rhema_rapha_app/core/services/doctor.service.dart';
import 'package:rhema_rapha_app/core/view_models/base.viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  DoctorService _doctorService;
  DepartmentService _departmentService;
  AuthService _authService;

  List<Doctor> doctors = List<Doctor>();
  List<Department> departments = List<Department>();
  Map<String, dynamic> userDetails = HashMap();

  HomeViewModel(
      {@required DoctorService doctorService,
      @required AuthService authService,
      @required DepartmentService departmentService})
      : _authService = authService,
        _doctorService = doctorService,
        _departmentService = departmentService;

  Future<Result> getDoctors() async {
    setBusy(true);
    Result<List<Doctor>> result = await _doctorService.getDoctors();
    doctors = result.isSuccessful ? result.data : new Doctor();
    setBusy(false);
    return result;
  }

  Future<Result> getDepartments() async {
    setBusy(true);
    Result result = await _departmentService.getDepartments();
    departments = result.data;
    setBusy(false);
    return result;
  }

  Future<Result> getDepartmentById(String id) async {
    setBusy(true);
    Result result = await _departmentService.getDepartmentById(id);
    departments = result.data;
    setBusy(false);
    return result;
  }

  void getUserDetails() async {
    userDetails = await _authService.getUserDetails();
    notifyListeners();
  }

  void init() {
    getDepartments();
    getUserDetails();
    getDoctors();
  }

}
