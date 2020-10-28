import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/core/view_models/tabs.viewmodel.dart';
import 'package:rhema_rapha_app/views/pages/home/home.widget.dart';
import 'package:rhema_rapha_app/views/widgets/random_color.widget.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';
import 'package:rhema_rapha_app/core/routes/routes.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<TabsViewModel>(
      model: TabsViewModel(
        authService: Provider.of(context),
      ),
      onModelReady: (TabsViewModel model) async {
        model.getUserDetail();
      },
      builder: (BuildContext context, TabsViewModel model, Widget child) {
        if (model.userDetails.isEmpty) return SizedBox.shrink();

        var fullname = model.userDetails['fullName'];
        var initials = getInitials(name: fullname, limitTo: 2);

        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: AppColors.whiteShade2,
            actions: <Widget>[
              Icon(
                FeatherIcons.bell,
                size: 20,
                color: AppColors.primaryColor,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: () => {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext bc) {
                        return Container(
                          child: new Wrap(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(FeatherIcons.logIn),
                                title: new Text('Log Out'),
                                onTap: () async {
                                  var result = await model.logout();
                                  if (result) {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RoutePaths.Login,
                                      (_) => false,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  },
                  child: CircleAvatar(
                    backgroundColor: randomColor(),
                    child: Text(initials),
                  ),
                ),
              )
            ],
          ),
          // AppBarWidget.appBarWidget(fullname, titleText, context, onLogOut),
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

  static String getInitials({String name, int limitTo}) {
    if (name == null || name == '') return '';
    var buffer = StringBuffer();
    var split = name.split(' ');
    for (var i = 0; i < (limitTo ?? split.length); i++) {
      if (split[i][0] != null || split[i].isNotEmpty) buffer.write(split[i][0]);
    }

    return buffer.toString();
  }
}
