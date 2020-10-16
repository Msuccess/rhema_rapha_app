import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/sizes.dart';
import 'package:rhema_rapha_app/core/view_models/appointment.viewmodel.dart';

class UtilService {
  Future<Map<String, dynamic>> decodeJwtToken(String token) async {
    var tokenBase64Url = token.split('.')[1];
    var tokenBase64 = tokenBase64Url.replaceAll('-', '+').replaceAll('_', '/');
    var jsonToDecode = utf8.decode(base64Url.decode(tokenBase64));
    final jsonMap = jsonDecode(jsonToDecode);
    if (jsonMap is! Map<String, dynamic>) throw Exception('invalid payload');
    return jsonMap;
  }

  static void showSuccessToast(String message) {
    showToast(
      message,
      duration: Duration(seconds: 5),
      position: ToastPosition(
        align: Alignment.bottomCenter,
      ),
      backgroundColor: AppColors.green,
      radius: 3.0,
      textPadding: EdgeInsets.all(10.0),
      textStyle: TextStyle(
        fontSize: AppSizes.SIZE_16,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  static void showAlertDialog(
      BuildContext context, AppointmentViewModel model, String id) {
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(
          color: AppColors.dangerColor,
        ),
      ),
      onPressed: () => Navigator.pop(context, false),
    );

    Widget continueButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(
          color: AppColors.primaryColor,
        ),
      ),
      onPressed: () async {
        var result = await model.cancelAppointment(
          context,
          id,
        );

        if (result.isSuccessful == true) {
          UtilService.showSuccessToast(
            "Appointment  Cancelled Successfully",
          );
          Navigator.pop(context);
        } else {
          UtilService.showSuccessToast("Error Cancelling Appointment");
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Cancel Appointment"),
      content: Text("Would you like to cancel this appointment?"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showErrorToast(String message) {
    showToast(
      message,
      duration: Duration(seconds: 3),
      position: ToastPosition(
        align: Alignment.bottomCenter,
      ),
      backgroundColor: AppColors.googleRed,
      radius: 3.0,
      textPadding: EdgeInsets.all(10.0),
      textStyle: TextStyle(
        fontSize: AppSizes.SIZE_16,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  static String formatDate(DateTime date) {
    if (date == null) date = DateTime.now();
    final formatter = new DateFormat('EEEE, MMMM dd, yyyy');
    return formatter.format(date);
  }

  static String getDay(DateTime date) {
    if (date == null) date = DateTime.now();
    final formatter = new DateFormat('EEEE');
    return formatter.format(date);
  }

  static String formatShortDate(DateTime date) {
    if (date == null) date = DateTime.now();
    final formatter = new DateFormat('MMMM dd, yyyy');
    return formatter.format(date);
  }
}
