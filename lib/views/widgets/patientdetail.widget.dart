import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/assets/styles/text_style.dart';

class PatientDetailsWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const PatientDetailsWidget({
    Key key,
    @required this.title,
    @required this.subTitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: AppTexts.h5,
          ),
          TextSpan(
            text: subTitle,
            style: AppTexts.titleNormal,
          ),
        ],
      ),
    );
  }
}
