import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/core/view_models/tabs.viewmodel.dart';
import 'package:rhema_rapha_app/views/pages/home/home.widget.dart';
import 'package:rhema_rapha_app/views/widgets/appbar.widget.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  TabsViewModel tabModel;

  @override
  Widget build(BuildContext context) {
    onLogOut() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(FeatherIcons.logIn),
                  title: new Text('Log Out'),
                  onTap: () => tabModel.logOut(),
                ),
              ],
            ),
          );
        },
      );
    }

    return BaseWidget<TabsViewModel>(
      model: TabsViewModel(
        authService: Provider.of(context),
      ),
      onModelReady: (TabsViewModel model) async {
        model.getUserDetail();
        tabModel = model;
      },
      builder: (BuildContext context, TabsViewModel model, Widget child) {
        if (model.userDetails.isEmpty) return SizedBox.shrink();

        var fullname = model.userDetails['fullName'];
        String titleText = "";
        return Scaffold(
          appBar:
              AppBarWidget.appBarWidget(fullname, titleText, context, onLogOut),
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
