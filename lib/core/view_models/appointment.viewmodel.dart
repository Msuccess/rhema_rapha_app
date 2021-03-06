import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rhema_rapha_app/core/constants/localkeys.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/appointment.model.dart';
import 'package:rhema_rapha_app/core/models/department.model.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/services/appointment.service.dart';
import 'package:rhema_rapha_app/core/services/department.service.dart';
import 'package:rhema_rapha_app/core/services/doctor.service.dart';
import 'package:rhema_rapha_app/core/services/util.service.dart';
import 'package:rhema_rapha_app/core/view_models/base.viewmodel.dart';

class AppointmentViewModel extends BaseViewModel {
  AppointmentService _appointmentService;
  DoctorService _doctorService;
  DepartmentService _departmentService;

  Department department = Department.initial();
  List<Doctor> doctors = List<Doctor>();
  List<Department> departments = List<Department>();

  Doctor doctor = Doctor.initial();
  DateTime date = DateTime.now();
  String type = 'Visit';
  String time = '8:00AM';

  List<Appointment> appointments = List<Appointment>();
  List<Appointment> origianlAppointments = List<Appointment>();

  List<String> appointmentTimes = [];

  TextEditingController descriptionController = TextEditingController();

  var filterTypee = 'next';

  Doctor paramDoctor;

  AppointmentViewModel(
      {@required AppointmentService appointmentService,
      @required DoctorService doctorService,
      @required DepartmentService departmentService})
      : _appointmentService = appointmentService,
        _departmentService = departmentService,
        _doctorService = doctorService;

  Future<Result> getAppointments() async {
    setBusy(true);
    var result = await _appointmentService.getAll();
    appointments = result.isSuccessful ? result.data : [];
    //filterAppointments(filterTypee);
    setBusy(false);
    return result;
  }

  Future<Result> getDepartments() async {
    setBusy(true);
    Result result = await _departmentService.getDepartments();

    departments = result.data
        .where((Department element) => element.doctor.length != 0)
        .toList();

    // TODO: show pop up if there are no doctors in all departmet and return to home

    if (paramDoctor == null) {
      department =
          department.name == '' ? departments[0] : Department.initial();
    } else {
      department = departments.firstWhere(
          (department) => department.id == paramDoctor.departmentId);
    }

    getDepartmentDoctors(department.doctor);
    setBusy(false);

    return result;
  }

  void filterAppointments(String filterType) {
    filterTypee = filterType;
    if (filterType == 'next') {
      appointments = origianlAppointments
          .where(
            (appointment) => DateTime.parse(appointment.date).isAfter(
              DateTime.now().subtract(
                Duration(days: 1),
              ),
            ),
          )
          .toList();
    }

    if (filterType == 'prev') {
      filterTypee = filterType;
      appointments = origianlAppointments
          .where(
            (appointment) => DateTime.parse(appointment.date).isBefore(
              DateTime.now(),
            ),
          )
          .toList();
    }
  }

  Future<Result> cancelAppointment(String id) async {
    setBusy(true);
    var result = await _appointmentService.cancelAppointment(id);
    appointments = result.isSuccessful ? result.data : [];
    setBusy(false);
    return result;
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    String telScheme = 'tel:$phoneNumber';
    try {
      if (await canLaunch(telScheme)) {
        await launch(telScheme);
      }
    } catch (e) {
      throw 'Could not launch $e';
    }
  }

  Future<Result> getDoctors(Doctor doctor) async {
    setBusy(true);
    Result<List<Doctor>> result = await _doctorService.getDoctors();
    doctors = result.data;

    doctor = doctors[0];

    _setInitialTime(doctor);
    _setInitialDate(doctor);

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
    _setInitialTime(doctor);
    _setInitialDate(newDoctor);
    notifyListeners();
  }

  void onDepartmentSelected(Department newDepartment) {
    department = newDepartment;
    doctors = newDepartment.doctor;

    getDepartmentDoctors(doctors);
    notifyListeners();
  }

  getDepartmentDoctors(List<Doctor> doctors) {
    if (paramDoctor == null) {
      doctor = doctors[0];
    } else {
      doctor = doctors.firstWhere((doctor) => doctor.id == paramDoctor.id);
    }

    appointmentTimes = doctor.timesAvailable.split(',').toList();
    time = appointmentTimes[0];
    _setInitialDate(doctor);
    _setInitialTime(doctor);

    setBusy(false);
  }

  void _setInitialDate(doctor) {
    date = DateTime.now();
    var validDay = doctor.daysAvailable
        .toLowerCase()
        .contains(UtilService.getDay(date).toLowerCase());

    while (!validDay) {
      date = date.add(Duration(days: 1));
      validDay = doctor.daysAvailable
          .toLowerCase()
          .contains(UtilService.getDay(date).toLowerCase());
    }
  }

  void _setInitialTime(doctor) {
    appointmentTimes = doctor.timesAvailable.split(',').toList();
    time = appointmentTimes[0];
  }

  void onAppointmentSubmit(BuildContext context) async {
    setBusy(true);
    var sp = await SharedPreferences.getInstance();
    var userId = sp.getString(USER_ID);
    var appointment = Appointment(
      appointmentDay: UtilService.getDay(date),
      appointmentTime: time,
      date: date.toIso8601String(),
      description: descriptionController.text ?? '',
      type: type == 'Voice call' ? 'voice' : 'visit',
      patientId: userId,
      doctorId: doctor.id,
    );

    print(jsonEncode(appointment));

    var result = await _appointmentService.save(appointment);

    if (result.isSuccessful) {
      var res = await getAppointments();

      if (res.isSuccessful) {
        UtilService.showSuccessToast(result.message);
        Navigator.pop(context);
        setBusy(false);
      }
    } else {
      UtilService.showErrorToast(result.message);
      setBusy(false);
    }
    setBusy(false);
  }

  setDaysAvailable(DateTime date) {
    var day = UtilService.getDay(date).toLowerCase();
    var days = doctor.daysAvailable.toLowerCase();
    var available = days.contains(day);
    return available;
  }

  void setParamDoctor(Doctor doctor) {
    paramDoctor = doctor;
  }
}
