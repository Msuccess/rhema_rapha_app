import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MenuItems {
  static const menItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(FeatherIcons.home),
      title: Text('Home'),
    ),

    BottomNavigationBarItem(
      icon: Icon(FeatherIcons.calendar),
      title: Text('Appointment'),
    ),

    BottomNavigationBarItem(
      icon: Icon(FeatherIcons.user),
      title: Text('Profile'),
    ),
    
  ];
}