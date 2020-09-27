import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/sizes.dart';
import 'package:rhema_rapha_app/core/routes/routes.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

Widget _buildImage(String assetName) {
  return Align(
    child: Image.asset(assetName, width: 350.00),
    alignment: Alignment.bottomCenter,
  );
}

void _onIntroEnd(context) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    RoutePaths.Login,
    (route) => false,
  );
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: AppSizes.TEXT_SIZE_20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      bodyTextStyle: TextStyle(
        color: AppColors.primaryText,
        letterSpacing: .5,
        fontSize: AppSizes.TEXT_SIZE_16,
        fontWeight: FontWeight.normal,
        fontFamily: 'OpenSans',
      ),
      descriptionPadding: EdgeInsets.fromLTRB(
        20.0,
        0.0,
        20.0,
        20.0,
      ),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(bottom: AppSizes.SIZE_24),
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Live talk with doctor",
          body:
              "Easily connect with doctors and talk to them for better treatment & prescription",
          image: _buildImage('lib/assets/images/book-appointment.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Book appointments",
          body:
              "Book an appointment with a doctor chat with doctor via appointment letter. Get consultent.",
          image: _buildImage('lib/assets/images/live-talk.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Get specialized doctors",
          body:
              "Access specialized doctors for all your needsvYou can easily contact any doctor for your needs.",
          image: _buildImage('lib/assets/images/specialized.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text(
        'Done',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
