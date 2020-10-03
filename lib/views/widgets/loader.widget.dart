import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';

Widget loaderWidget() {
  return Align(
    alignment: Alignment.center,
      child: CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(
        AppColors.primaryColor,
      ),
    ),
  );
}
