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
    List<String> appointmentTimes = data.split(',').toList();

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
      title: Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Text(
          title,
          style: AppTexts.normalText,
        ),
      ),
      subtitle: Row(
        children: <Widget>[
          getDaysList(appointmentTimes),
        ],
      ),
    );
  }

  getDaysList(List<String> appointmentDays) {
    return Expanded(
      child: Wrap(
        children: appointmentDays.map((x) {
          return DayContainerWidget(appointmentTime: x);
        }).toList(),
      ),
    );
  }
}

class DayContainerWidget extends StatelessWidget {
  final String appointmentTime;
  const DayContainerWidget({
    Key key,
    this.appointmentTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, bottom: 10),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.blackShade9,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Text(
        appointmentTime,
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
    );
  }
}
