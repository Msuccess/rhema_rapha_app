import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/sizes.dart';

class AppTexts {
  static const TextStyle h1 = TextStyle(
    color: AppColors.blackShade2,
    fontSize: AppSizes.TEXT_SIZE_36,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle h6 = TextStyle(
    color: AppColors.primaryText,
    fontSize: AppSizes.TEXT_SIZE_12,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titleText = TextStyle(
    color: AppColors.blackShade2,
    fontSize: AppSizes.TEXT_SIZE_16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle subTitleText = TextStyle(
    color: AppColors.primaryText,
    letterSpacing: .5,
    fontSize: AppSizes.TEXT_SIZE_12,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle titleLight = TextStyle(
    color: AppColors.white,
    fontSize: AppSizes.TEXT_SIZE_16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle subTitleLight = TextStyle(
    color: AppColors.white,
    letterSpacing: .5,
    fontSize: AppSizes.TEXT_SIZE_16,
    fontWeight: FontWeight.w400,
  );
  static TextStyle normalText = TextStyle(
      color: AppColors.primaryText,
      letterSpacing: .5,
      fontSize: AppSizes.TEXT_SIZE_12,
      fontWeight: FontWeight.normal,
      fontFamily: 'OpenSans');

  static TextStyle h20 = TextStyle(
      color: AppColors.primaryText,
      letterSpacing: .5,
      fontSize: AppSizes.TEXT_SIZE_20,
      fontWeight: FontWeight.normal,
      fontFamily: 'OpenSans');

  static TextStyle h14 = TextStyle(
      color: AppColors.primaryText,
      letterSpacing: .5,
      fontSize: AppSizes.TEXT_SIZE_14,
      fontWeight: FontWeight.normal,
      fontFamily: 'OpenSans');

  static const TextStyle buttomText = TextStyle(
      color: AppColors.white,
      fontSize: AppSizes.TEXT_SIZE_12,
      fontWeight: FontWeight.w500,
      fontFamily: 'OpenSans');

  static TextStyle inputText = TextStyle(
      color: AppColors.primaryText,
      fontSize: AppSizes.TEXT_SIZE_12,
      fontWeight: FontWeight.normal,
      fontFamily: 'OpenSans');

  static const TextStyle title = TextStyle(
    color: AppColors.blackShade2,
    fontSize: AppSizes.TEXT_SIZE_20,
    fontWeight: FontWeight.w500,
  );


  static const TextStyle titleNormal = TextStyle(
    color: AppColors.blackShade2,
    fontWeight: FontWeight.w500,
    fontSize: AppSizes.TEXT_SIZE_16,
  );

  static const TextStyle homeButtomText = TextStyle(
    color: AppColors.white,
    fontSize: AppSizes.TEXT_SIZE_16,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );
}
