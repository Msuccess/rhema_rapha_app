import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/sizes.dart';
import 'package:rhema_rapha_app/assets/styles/text_style.dart';
import 'package:rhema_rapha_app/core/constants/menu_items.dart';
import 'package:rhema_rapha_app/core/models/department.model.dart';
import 'package:rhema_rapha_app/core/routes/routes.dart';

class HeaderWidget extends StatelessWidget {
  final String name;
  const HeaderWidget({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Hello,",
            style: AppTexts.h20,
          ),
          Text(
            name,
            style: AppTexts.h1,
          ),
        ],
      ),
    );
  }
}

class HomeBottomWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 16),
      child: FlatButton(
        height: AppSizes.fullHeight(context) * .06,
        onPressed: () => Navigator.pushNamed(
          context,
          RoutePaths.NewAppointment,
        ),
        child: Text(
          "Book Appointment",
          style: AppTexts.homeButtomText,
        ),
        color: AppColors.primaryColor,
      ),
    );
  }
}

class DepartmentsWidget extends StatelessWidget {
  final List<Department> departments;

  const DepartmentsWidget({Key key, @required this.departments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Services", style: AppTexts.title),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: FlatButton(
                  child: Text(
                    "See All",
                    style: AppTexts.titleNormal
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () => Navigator.pushNamed(
                      context, RoutePaths.Department,
                      arguments: departments),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: AppSizes.fullHeight(context) * .2,
          width: AppSizes.fullWidth(context),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            itemCount: departments.length,
            itemBuilder: (BuildContext context, int index) {
              return departmentCard(
                context,
                departments[index].name,
                departments[index],
                color: AppColors.green,
                lightColor: AppColors.greenShade1,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget departmentCard(
      BuildContext context, String name, Department department,
      {Color color, Color lightColor}) {
    TextStyle titleStyle = AppTexts.titleLight;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RoutePaths.DepartmentDetails,
        arguments: department,
      ),
      child: Container(
        width: AppSizes.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundColor: lightColor,
                    radius: 60,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(name, style: titleStyle),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomTabBar extends StatelessWidget {
  final int index;
  final Function onItemTap;
  BottomTabBar({this.index, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.shifting,
      unselectedIconTheme: IconThemeData(
        color: AppColors.primaryDisableColor,
      ),
      items: MenuItems.menItems,
      currentIndex: index,
      selectedItemColor: AppColors.primaryColor,
      elevation: 30.0,
      onTap: onItemTap,
    );
  }
}
