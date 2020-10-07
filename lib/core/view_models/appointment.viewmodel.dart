import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:rhema_rapha_app/core/constants/localkeys.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/appointment.model.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/services/appointment.service.dart';
import 'package:rhema_rapha_app/core/services/doctor.service.dart';
import 'package:rhema_rapha_app/core/services/util.service.dart';
import 'package:rhema_rapha_app/core/view_models/base.viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentViewModel extends BaseViewModel {
  AppointmentService _appointmentService;
  DoctorService _doctorService;
  Doctor doctor = Doctor.initial();
  DateTime date = DateTime.now();
  String type = 'Voice call';
  String time = '8:00AM';

  List<Appointment> appointments = List<Appointment>();
  List<Doctor> doctors = List<Doctor>();

  List<String> appointmentTimes = [];

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

  Future<void> makePhoneCall(String phoneNumber) async {
    try {
      if (await canLaunch('tel:$phoneNumber')) {
        await launch(phoneNumber);
      }
    } catch (e) {
      throw 'Could not launch $e';
    }
  }

  Future<Result> getDoctors() async {
    setBusy(true);
    Result<List<Doctor>> result = await _doctorService.getDoctors();
    doctors = result.data;
    doctor = doctor.fullName == '' ? doctors[0] : Doctor.initial();
    appointmentTimes = doctor.timesAvailable.split(',').toList();
    setBusy(false);
    return result;
  }

  Future<Result> cancelBookedAppointment(String id) async {
    setBusy(true);
    var result = await _appointmentService.cancelAppointment(id);
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
    appointmentTimes = newDoctor.timesAvailable.split(',').toList();
    notifyListeners();
  }

  void onAppointmentSubmit(BuildContext context) async {
    setBusy(true);
    var sp = await SharedPreferences.getInstance();
    var userId = sp.getString(USER_ID);
    var appointment = Appointment(
      appointmentDay: UtilService.getDay(date),
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
}
