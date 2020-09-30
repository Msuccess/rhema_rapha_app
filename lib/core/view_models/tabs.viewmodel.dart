import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/core/services/authservice.dart';
import 'package:rhema_rapha_app/core/view_models/base.viewmodel.dart';
import 'package:rhema_rapha_app/views/pages/appointment/appointments.page.dart';
import 'package:rhema_rapha_app/views/pages/home/home.page.dart';
import 'package:rhema_rapha_app/views/pages/profile/profile.page.dart';
import 'package:rhema_rapha_app/views/widgets/animatedindex_widget_state.dart';

class TabsViewModel extends BaseViewModel {
  AuthService _authService;

  Map<String, dynamic> userDetails = HashMap();

  TabsViewModel({
    @required AuthService authService,
  }) : _authService = authService;

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void onItemTap(index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Widget buildPage(_selectedIndex) {
    return AnimatedIndexedStack(
      index: _selectedIndex,
      children: <Widget>[
        HomePage(),
        AppointmentPage(),
        ProfilePage(),
      ],
    );
  }

  void getUserDetails() async {
    userDetails = await _authService.getUserDetails();
    notifyListeners();
  }

  void init() {
    getUserDetails();
  }
}
