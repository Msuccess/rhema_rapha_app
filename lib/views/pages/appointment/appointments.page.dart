import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/core/routes/routes.dart';
import 'package:rhema_rapha_app/views/widgets/button.widget.dart';

class AppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, RoutePaths.NewAppointment),
        child: Icon(FeatherIcons.plus),
      ),
      backgroundColor: Color(0xFFE5E5E5),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 20.0, 5.0, 0),
                    child: ButtonWidget(
                      text: 'Upcoming',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 20.0, 10.0, 0),
                    child: ButtonWidget(
                      text: 'Past',
                      invert: true,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView(
                children: [
                  AppointmentTile(),
                  AppointmentTile(),
                  AppointmentTile(),
                  AppointmentTile(),
                  AppointmentTile(),
                  AppointmentTile(),
                  AppointmentTile(),
                  AppointmentTile(),
                  AppointmentTile(),
                  AppointmentTile(),
                  AppointmentTile(),
                  AppointmentTile(),
                  AppointmentTile(),
                  AppointmentTile(),
                  AppointmentTile(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppointmentTile extends StatelessWidget {
  const AppointmentTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: ListTile(
          title: Text(
            'Dr. Peter Donkor 17',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              Text(
                'Medical Doctor',
                style: TextStyle(fontSize: 12.0),
              ),
              Text(
                '9:00am - 10:00pm',
                style: TextStyle(fontSize: 15.0),
              ),
            ],
          ),
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 30.0,
                child: Text(
                  'RT',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: AppointmentTypeIcon(isCall: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentTypeIcon extends StatelessWidget {
  final bool isCall;
  const AppointmentTypeIcon({
    Key key,
    this.isCall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: isCall ? Color(0xFFA079EC) : Color(0xFFFFA873),
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      child: Icon(
        isCall ? FeatherIcons.phone : FeatherIcons.user,
        size: 15,
        color: AppColors.white,
      ),
    );
  }
}
