import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/core/models/appointment.model.dart';
import 'package:rhema_rapha_app/core/routes/routes.dart';
import 'package:rhema_rapha_app/core/view_models/appointment.viewmodel.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';
import 'package:rhema_rapha_app/views/widgets/button.widget.dart';

class AppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<AppointmentViewModel>(
      model: AppointmentViewModel(
        appointmentService: Provider.of(context),
        doctorService: Provider.of(context),
      ),
      onModelReady: (AppointmentViewModel model) async {
        await model.getAppointments();
      },
      builder: (
        BuildContext context,
        AppointmentViewModel model,
        Widget child,
      ) =>
          Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, RoutePaths.NewAppointment);
            await model.getAppointments();
          },
          child: Icon(FeatherIcons.plus),
        ),
        backgroundColor: Color(0xFFE5E5E5),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              model.appointments.length != 0
                  ? Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 20.0, 5.0, 0),
                            child: ButtonWidget(
                              text: 'Upcoming',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 20.0, 10.0, 0),
                            child: ButtonWidget(
                              text: 'Past',
                              invert: true,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(height: 20.0),
              model.busy && model.appointments.length == 0
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: AppColors.primaryColor,
                        ),
                      ),
                    )
                  : Container(),
              !model.busy && model.appointments.length == 0
                  ? Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FeatherIcons.calendar,
                              color: Colors.black12,
                              size: 100,
                            ),
                            SizedBox(height: 20.0),
                            Text('You don\'t have any appointments yet'),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              model.appointments.length != 0
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: model.appointments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AppointmentTile(
                              appointment: model.appointments[index],
                              model: model,
                            );
                          }),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;
  final AppointmentViewModel model;
  const AppointmentTile({
    Key key,
    this.appointment,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: () async {
          var arguments = {'appointment': appointment};
          await Navigator.pushNamed(context, RoutePaths.ViewAppointment,
              arguments: arguments);
          await model.getAppointments();
        },
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
              appointment.id,
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
                  appointment.appointmentTime,
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
                  child: AppointmentTypeIcon(
                    isCall: appointment.type != 'Visit',
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
