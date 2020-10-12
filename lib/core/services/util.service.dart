import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/sizes.dart';

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
      duration: Duration(seconds: 3),
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

  static void showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {},
    );

    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
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
