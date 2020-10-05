import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MenuItems {
  static const menItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(FeatherIcons.home),
      label: 'Home',
    ),

    BottomNavigationBarItem(
      icon: Icon(FeatherIcons.calendar),
      label: 'Appointment',
    ),

    BottomNavigationBarItem(
      icon: Icon(FeatherIcons.user),
      label: 'Profile',
    ),
    
  ];
}