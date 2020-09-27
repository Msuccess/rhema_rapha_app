  import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';

Color randomColor() {
    var random = Random();
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
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }