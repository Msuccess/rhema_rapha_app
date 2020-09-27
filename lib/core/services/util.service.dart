import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/sizes.dart';
import 'package:rhema_rapha_app/main.dart';

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
}
