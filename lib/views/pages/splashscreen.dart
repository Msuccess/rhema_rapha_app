import 'dart:async';
import 'package:flutter/material.dart';

import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/core/routes/routes.dart';
import 'package:rhema_rapha_app/core/services/authservice.dart';
import 'package:rhema_rapha_app/views/widgets/logowidget.dart';

class SplashScreen extends StatefulWidget {
  static final String id = '/';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int totalSeconds = 5;
  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Center(
              child: LogoWidget(),
            ),
            Positioned(
              bottom: 30.0,
              left: 20.0,
              right: 20.0,
              child: Center(
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          AppColors.primaryColor),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Loading',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _startTimer() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      totalSeconds = totalSeconds - 1;
      if (totalSeconds == 0) {
        _gotoNextScreen();
        timer.cancel();
      }
    });
  }

  _gotoNextScreen() async {
    var isOnboarded = await AuthService.isOnboarded();
    if (!isOnboarded) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutePaths.OnBoarding,
        (_) => false,
      );
      return;
    }

    if (isOnboarded) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutePaths.Login,
        (_) => false,
      );
      return;
    }
  }
}
