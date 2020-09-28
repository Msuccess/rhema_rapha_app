
import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';

Color randomColor() {
    final colorList = [
      AppColors.primaryColor,
      AppColors.orange,
      AppColors.green,
      AppColors.grey,
      AppColors.orangeShade4,
      AppColors.seaBlue2,
      AppColors.primaryText,
      Colors.red,
      Colors.brown,
      AppColors.purple,
      AppColors.blueShade2,
      Colors.redAccent
    ];
    colorList.shuffle();
    return colorList[0];
  }