import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/core/models/appointment.model.dart';
import 'package:rhema_rapha_app/core/view_models/appointment.viewmodel.dart';
import 'package:rhema_rapha_app/views/widgets/appbar.widget.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';

class ViewAppointmentPage extends StatelessWidget {
  final arguments;
  const ViewAppointmentPage({Key key, this.arguments}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Appointment appointment;
    return BaseWidget<AppointmentViewModel>(
      model: AppointmentViewModel(
        appointmentService: Provider.of(context),
        doctorService: Provider.of(context),
      ),
      onModelReady: (AppointmentViewModel model) async {
        appointment = arguments['appointment'];
      },
      builder:
          (BuildContext context, AppointmentViewModel model, Widget child) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                color: AppColors.primaryColor,
              ),
            ),
            title: Text(
              'View Appointment',
              style: TextStyle(color: AppColors.primaryColor),
            ),
            elevation: 0,
            backgroundColor: AppColors.white,
          ),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text('Voice call appointment'),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 1),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        AppBarWidget.getInitials(
                            name: 'Doctor FullName', limitTo: 2),
                      ),
                    ),
                    title: Text('Doctor FullName'),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.primaryDisableColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Icon(
                          FeatherIcons.phone,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.primaryDisableColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Icon(
                          FeatherIcons.user,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                        topRight: Radius.circular(70),
                      ),
                    ),
                    child: SizedBox(height: 30),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      buildVisitingTimeSection(),
                      buildPatientInfoTimeSection(),
                      buildDescriptionSection(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  buildDescriptionSection(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(FeatherIcons.user, color: Colors.transparent),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Note',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      child: Flexible(
                        child: Text(
                            'Ullam consectetur ducimus maxime. Sit aliquam veniam libero. Sit aliquam veniam libero.Sit aliquam veniam libero.'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildPatientInfoTimeSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(FeatherIcons.user, color: AppColors.green),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Patient Information',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text('Name: Peter Akoto Aasre'),
                    SizedBox(height: 10),
                    Text('Age: 100'),
                    SizedBox(height: 10),
                    Text('Phone: 0200000000'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildVisitingTimeSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(FeatherIcons.clock, color: AppColors.green),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visit Time',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Morning',
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Monday 10 June, 2020'),
                    SizedBox(height: 10),
                    Text(
                      '10:00AM - 10:00PM',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          FlatButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: AppColors.redShade5,
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.white),
            ),
          )
        ],
      ),
    );
  }
}
