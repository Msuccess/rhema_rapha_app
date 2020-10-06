import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/core/models/appointment.model.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/models/patient.model.dart';
import 'package:rhema_rapha_app/core/view_models/appointment.viewmodel.dart';
import 'package:rhema_rapha_app/views/widgets/appbar.widget.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';

class ViewAppointmentPage extends StatelessWidget {
  final arguments;
  const ViewAppointmentPage({Key key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Appointment appointment;
    Doctor doctor;
    Patient patient;

    return BaseWidget<AppointmentViewModel>(
      model: AppointmentViewModel(
        appointmentService: Provider.of(context),
        doctorService: Provider.of(context),
      ),
      onModelReady: (AppointmentViewModel model) async {
        appointment = arguments['appointment'];
        doctor = appointment.doctor;
        patient = appointment.patient;
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
          body: model.busy
              ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                )
              : SingleChildScrollView(
                              child: Container(
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
                                    name: doctor?.fullName, limitTo: 2),
                              ),
                            ),
                            title: Text(doctor?.fullName),
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
                                  color: getAppointmentType(appointment?.type) ==
                                          'call'
                                      ? AppColors.primaryColor
                                      : AppColors.primaryDisableColor,
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
                                  color: getAppointmentType(appointment.type) ==
                                          'walk'
                                      ? AppColors.primaryColor
                                      : AppColors.primaryDisableColor,
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
                        buildVisitingTimeSection(appointment),
                        buildPatientInfoTimeSection(patient),
                        buildDescriptionSection(context, appointment),
                      ],
                    ),
                  ),
              ),
        );
      },
    );
  }

  buildDescriptionSection(context, Appointment appointment) {
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
                      'Discription',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      child: Flexible(
                        child: Text(appointment.description),
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

  buildPatientInfoTimeSection(Patient patient) {
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
                    Text('Name: ' + patient.fullName),
                    SizedBox(height: 10),
                    Text('Date of Birth: ' + patient.dateOfBirth),
                    SizedBox(height: 10),
                    Text('Phone: ' + patient.phonenumber),
                    SizedBox(height: 10),
                    Text('Email: ' + patient.email),
                    SizedBox(height: 10),
                    Text('Gender: ' + patient.gender),
                    SizedBox(height: 10),
                    Text('Address: ' + patient.address),
                    Divider(
                      color: AppColors.red,
                    ),
                    Text(
                      'Medical Details',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    Text('Phone: ' + patient.height),
                    SizedBox(height: 10),
                    Text('Phone: ' + patient.bloodType),
                    SizedBox(height: 10),
                    Text('Phone: ' + patient.bloodPressure),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildVisitingTimeSection(Appointment appointment) {
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
                      'Appointment Time',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    // SizedBox(height: 20),
                    // Text(
                    //   'Morning',
                    //   style: TextStyle(
                    //     color: Colors.black45,
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    Text(appointment.date),
                    SizedBox(height: 10),
                    Text(
                      appointment.appointmentTime,
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

  String getAppointmentType(String type) {
    if (type.toLowerCase() == 'voice call') {
      return 'call';
    } else {
      return 'walk';
    }
  }

 
}
