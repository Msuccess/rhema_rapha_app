import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rhema_rapha_app/views/pages/appointment/new_appoitment.page.dart';
import 'package:rhema_rapha_app/views/pages/auth/login.dart';
import 'package:rhema_rapha_app/views/pages/auth/register.dart';
import 'package:rhema_rapha_app/views/pages/department/department.page.dart';
import 'package:rhema_rapha_app/views/pages/department/departmentdetails.page.dart';
import 'package:rhema_rapha_app/views/pages/doctor/doctor.page.dart';
import 'package:rhema_rapha_app/views/pages/doctor/doctordetails.page.dart';
import 'package:rhema_rapha_app/views/pages/home/home.page.dart';
import 'package:rhema_rapha_app/views/pages/onboarding.dart';
import 'package:rhema_rapha_app/views/pages/splashscreen.dart';
import 'package:rhema_rapha_app/views/pages/tabs/tabs.page.dart';

class RoutePaths {
  static const String Splash = 'splash';
  static const String Home = '/';
  static const String Login = 'login';
  static const Register = 'register';
  static const OnBoarding = 'OnBoarding';
  static const Forgotten = 'Forgotten';
  static const Department = "Department";
  static const Doctor = "Doctor";
  static const Tabs = "Tabs";
  static const DoctorDetails = "DoctorDetails";
  static const NewAppointment = "NewAppointment";
  static const DepartmentDetails = "DepartmentDetails";
}

class RouterPath {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.NewAppointment:
        return PageTransition(
          child: NewAppointmentPage(),
          type: PageTransitionType.leftToRightWithFade,
        );
        break;

      case RoutePaths.Splash:
        return PageTransition(
          child: SplashScreen(),
          type: PageTransitionType.leftToRightWithFade,
        );
        break;

      case RoutePaths.OnBoarding:
        return PageTransition(
          child: OnBoardingPage(),
          type: PageTransitionType.leftToRightWithFade,
        );
        break;

      case RoutePaths.Forgotten:
        return PageTransition(
          child: SplashScreen(),
          type: PageTransitionType.leftToRightWithFade,
        );
        break;

      case RoutePaths.Login:
        return PageTransition(
          child: LoginPage(),
          type: PageTransitionType.leftToRightWithFade,
        );
        break;

      case RoutePaths.Register:
        return PageTransition(
          child: RegistrationPage(),
          type: PageTransitionType.leftToRightWithFade,
        );
        break;

      case RoutePaths.Tabs:
        return PageTransition(
          child: TabsPage(),
          type: PageTransitionType.leftToRightWithFade,
        );
        break;

      case RoutePaths.Home:
        return PageTransition(
          child: HomePage(),
          type: PageTransitionType.leftToRightWithFade,
        );
        break;

      case RoutePaths.Doctor:
        return PageTransition(
          child: DoctorPage(arguments: settings.arguments),
          type: PageTransitionType.leftToRightWithFade,
        );
        break;

        case RoutePaths.Doctor:
        return PageTransition(
          child: DepartmentDetailsPage(arguments: settings.arguments),
          type: PageTransitionType.leftToRightWithFade,
        );
        break;

      case RoutePaths.DoctorDetails:
        return PageTransition(
          child: DoctorDetailsPage(arguments: settings.arguments),
          type: PageTransitionType.leftToRightWithFade,
        );
        break;

      case RoutePaths.Department:
        return PageTransition(
          child: DepartmentPage(arguments: settings.arguments),
          type: PageTransitionType.leftToRightWithFade,
        );
        break;

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route define for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
