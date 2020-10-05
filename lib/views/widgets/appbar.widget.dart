import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/views/widgets/random_color.widget.dart';

class AppBarWidget {
  static PreferredSizeWidget appBarWidget(
    String fullName,
    String avatar,
    BuildContext context,
  ) {
    var initials = getInitials(name: fullName, limitTo: 2);
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.whiteShade2,
      actions: <Widget>[
        Icon(
          FeatherIcons.bell,
          size: 20,
          color: AppColors.primaryColor,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(13),
            ),
            child: avatar != null
                ? Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Image.asset(avatar, fit: BoxFit.fill),
                  )
                : CircleAvatar(
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
      buffer.write(split[i][0]);
    }

    return buffer.toString();
  }
}
