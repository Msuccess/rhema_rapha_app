import 'package:flutter/cupertino.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';

Widget chipWidget(String text){
   return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyShade8,
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 10),
          Text(text),
          SizedBox(width: 4),
        ],
      ),
    );
}