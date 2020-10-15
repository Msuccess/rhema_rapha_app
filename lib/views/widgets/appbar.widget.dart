import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/views/widgets/random_color.widget.dart';

class AppBarWidget {
  static PreferredSizeWidget appBarWidget(
    String fullName,
    String titleText,
    BuildContext context,
    Function onLogOut,
  ) {
    var initials = getInitials(name: fullName, limitTo: 2);
    return AppBar(
      elevation: 1,
      title: titleText == ""
          ? SizedBox.shrink()
          : Text(
              titleText,
              style: TextStyle(color: AppColors.primaryColor),
            ),
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
            onTap: () => onLogOut,
            child: CircleAvatar(
              backgroundColor: randomColor(),
              child: Text(initials),
            ),
          ),
        )
      ],
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
