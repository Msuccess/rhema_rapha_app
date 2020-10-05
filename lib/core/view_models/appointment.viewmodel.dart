import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rhema_rapha_app/core/constants/localkeys.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/appointment.model.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/services/appointment.service.dart';
import 'package:rhema_rapha_app/core/services/doctor.service.dart';
import 'package:rhema_rapha_app/core/services/util.service.dart';
import 'package:rhema_rapha_app/core/view_models/base.viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentViewModel extends BaseViewModel {
  AppointmentService _appointmentService;
  DoctorService _doctorService;
  Doctor doctor = Doctor.initial();
  DateTime date = DateTime.now();
  String type = 'Voice call';
  String time = '8:00AM';

  List<Appointment> appointments = List<Appointment>();
  List<Doctor> doctors = List<Doctor>();

  List<String> appointmentTimes = [
    '8:00AM',
    '10:00AM',
    '12:00PM',
    '2:00PM',
    '4:00PM',
    '6:00PM',
    '8:00PM',
    '10:00PM',
    '12:00AM',
    '2:00AM',
    '4:00AM',
    '6:00AM',
  ];

  AppointmentViewModel({
    @required AppointmentService appointmentService,
    @required DoctorService doctorService,
  })  : _appointmentService = appointmentService,
        _doctorService = doctorService;

  Future<Result> getAppointments() async {
    setBusy(true);
    var result = await _appointmentService.getAll();
    appointments = result.isSuccessful ? result.data : [];
    setBusy(false);
    return result;
  }

  Future<Result> getDoctors() async {
    setBusy(true);
    Result<List<Doctor>> result = await _doctorService.getDoctors();
    doctors = result.data;
    doctor = doctor.fullName == '' ? doctors[0] : Doctor.initial();
    setBusy(false);
    return result;
  }

  onTimeSelect(String newTime) {
    time = newTime;
    notifyListeners();
  }

  onTypeSelect(String newType) {
    type = newType;
    notifyListeners();
  }

  void onDateSelected(DateTime newDate) {
    if (date != null) {
      date = newDate;
      notifyListeners();
    }
  }

  void onDoctorSelected(Doctor newDoctor) {
    doctor = newDoctor;
    notifyListeners();
  }

  void onAppointmentSubmit(BuildContext context) async {
    setBusy(true);
    var sp = await SharedPreferences.getInstance();
    var userId = sp.getString(USER_ID);
    var appointment = Appointment(
      appointmentDay: getDay(date),
      appointmentTime: time,
      date: date.toIso8601String(),
      description: '',
      type: type,
      patientId: userId,
      doctorId: doctor.id,
    );

    print(jsonEncode(appointment));
    var result = await _appointmentService.save(appointment);
    if (result.isSuccessful) {
      UtilService.showSuccessToast(result.message);
      Navigator.pop(context);
    } else {
      UtilService.showErrorToast(result.message);
    }
    setBusy(false);
  }

  String formatDate(DateTime date) {
    if (date == null) date = DateTime.now();
    final formatter = new DateFormat('EEEE, MMMM dd, yyyy');
    return formatter.format(date);
  }

  String getDay(DateTime date) {
    if (date == null) date = DateTime.now();
    final formatter = new DateFormat('EEEE');
    return formatter.format(date);
  }
}
