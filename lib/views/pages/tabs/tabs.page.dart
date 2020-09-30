import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/view_models/tabs.viewmodel.dart';
import 'package:rhema_rapha_app/views/pages/home/home.widget.dart';
import 'package:rhema_rapha_app/views/widgets/appbar.widget.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  List<Doctor> doctors = List<Doctor>();
  @override
  Widget build(BuildContext context) {
    return BaseWidget<TabsViewModel>(
      model: TabsViewModel(
        authService: Provider.of(context),
      ),
      onModelReady: (TabsViewModel model) async {
        model.init();
      },
      builder: (BuildContext context, TabsViewModel model, Widget child) {
        var fullName = model.userDetails['fullName'];
        var avatar = model.userDetails['avatar'];
        return Scaffold(
          appBar: AppBarWidget.appBarWidget(fullName, avatar, context),
          body: model.buildPage(model.selectedIndex),
          backgroundColor: AppColors.whiteShade2,
          bottomNavigationBar: BottomTabBar(
            index: model.selectedIndex,
            onItemTap: (value) {
              model.onItemTap(value);
            },
          ),
        );
      },
    );
  }
}
