import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width / 2;

    return Image(
      image: AssetImage('lib/assets/images/Logo.png'),
      width: widthScreen,
      height: widthScreen,
    );
  }
}
