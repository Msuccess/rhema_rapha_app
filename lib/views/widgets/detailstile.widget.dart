import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/text_style.dart';

class DetailsTilleWidget extends StatelessWidget {
  final String data;
  final IconData iconData;
  final String title;

  const DetailsTilleWidget({
    Key key,
    @required this.data,
    this.iconData,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (title == null || data == null) return Container();

    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 0),
                color: Colors.black12),
          ],
        ),
        child: Icon(
          iconData,
          color: AppColors.primaryColor,
        ),
      ),
      title: Text(
        title,
        style: AppTexts.normalText,
      ),
      subtitle: Text(data, style: AppTexts.titleNormal),
    );
  }
}

class DetailsTilleWidget2 extends StatelessWidget {
  final String data;
  final IconData iconData;
  final String title;
 


  const DetailsTilleWidget2({
    Key key,
    @required this.data,
    this.iconData,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (title == null || data == null) return Container();

    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 0),
              color: Colors.black12,
            ),
          ],
        ),
        child: Icon(
          iconData,
          color: AppColors.primaryColor,
        ),
      ),
      title: Text(
        title,
        style: AppTexts.normalText,
      ),
     subtitle: Text(data, style: AppTexts.titleNormal),
    );
  }
}
