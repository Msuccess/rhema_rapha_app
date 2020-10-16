import 'dart:convert';

import 'package:rhema_rapha_app/core/constants/endpoints.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/appointment.model.dart';
import 'package:rhema_rapha_app/core/services/base.service.dart';

class AppointmentService extends BaseService {
  Future<Result<List<Appointment>>> getAll() async {
    var res = await getRequest(EndPoints.getAppointmentUrl());

    if (res != null && res.statusCode == 200) {
      var data = jsonDecode(res.body);

      var appointments = data['data'] as List<dynamic>;
      var parsedAppointments = appointments
          .map((appointment) => Appointment.fromJson(appointment))
          .toList();

      return Result<List<Appointment>>(
        isSuccessful: true,
        data: parsedAppointments,
        message: 'successfully',
      );
    }

    if (res != null && res.statusCode == 400) {
      var data = jsonDecode(res.body);
      return Result(isSuccessful: false, data: data, message: '');
    }

    return Result(isSuccessful: false, message: 'Please Check Your Connection');
  }

  Future<Result<Appointment>> save(Appointment appointment) async {
    var appointmentJson = appointment.toJson();
    appointmentJson.remove('id');
    var res = await postRequest(EndPoints.getAppointmentUrl(), appointmentJson);

    if (res != null && res.statusCode == 201) {
      var data = jsonDecode(res.body);
      var appointment = data['data'] as dynamic;
      var parsedAppointment = Appointment.fromJson(appointment);

      return Result<Appointment>(
          isSuccessful: true,
          data: parsedAppointment,
          message: 'Appointment saved successfully');
    }

    if (res != null && res.statusCode == 400) {
      var data = jsonDecode(res.body);
      return Result(
          isSuccessful: false,
          data: data,
          message: 'Appointment failed to save');
    }

    return Result(isSuccessful: false, message: 'Something went wrong');
  }

  Future<Result<Appointment>> getById(String appointmentId) async {
    var res =
        await getRequest(EndPoints.getAppointmentUrl() + '/' + appointmentId);

    if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
      var data = jsonDecode(res.body);
      var appointment = data['data'] as dynamic;
      var parsedAppointment = Appointment.fromJson(appointment);

      return Result<Appointment>(
          isSuccessful: true, data: parsedAppointment, message: 'successfully');
    }

    if (res != null && res.statusCode == 400) {
      var data = jsonDecode(res.body);
      return Result(isSuccessful: false, data: data, message: '');
    }

    return Result(isSuccessful: false, message: 'Something went wrong');
  }

  Future<Result<Appointment>> delete(String appointmentId) async {
    var res = await deleteRequest(
        EndPoints.getAppointmentUrl() + '/' + appointmentId);

    if (res != null && res.statusCode == 200) {
      return Result<Appointment>(
          isSuccessful: true, data: null, message: 'successfully');
    }

    if (res != null && res.statusCode == 400) {
      var data = jsonDecode(res.body);
      return Result(isSuccessful: false, data: data, message: '');
    }

    return Result(isSuccessful: false, message: 'Something went wrong');
  }

  Future<Result<Appointment>> update(
      String appointmentId, Appointment appointment) async {
    var res = await putRequest(
        EndPoints.getAppointmentUrl() + '/' + appointmentId, appointment);

    if (res != null && res.statusCode == 200) {
      return Result<Appointment>(
          isSuccessful: true, data: null, message: 'successfully');
    }

    if (res != null && res.statusCode == 400) {
      var data = jsonDecode(res.body);
      return Result(isSuccessful: false, data: data, message: '');
    }

    return Result(isSuccessful: false, message: 'Something went wrong');
  }

  Future<Result<Appointment>> cancelAppointment(String appointmentId) async {
    // var res =
    //     await put(EndPoints.getAppointmentUrl() + '/cancel/' + appointmentId);

    // if (res != null && res.statusCode == 201) {
    //   return Result<Appointment>(
    //       isSuccessful: true, data: null, message: 'successfully');
    // }

    // if (res != null && res.statusCode == 400) {
    //   var data = jsonDecode(res.body);
    //   return Result(isSuccessful: false, data: data, message: '');
    // }

    return Result(isSuccessful: false, message: 'Something went wrong');
  }
}
