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
import 'package:rhema_rapha_app/views/widgets/descriptionsection.widget.dart';
import 'package:rhema_rapha_app/views/widgets/patientinfo.widget.dart';
import 'package:rhema_rapha_app/views/widgets/visitingtime.widget.dart';

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
        departmentService: Provider.of(context),
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
            elevation: 2.0,
            backgroundColor: AppColors.whiteShade2,
            iconTheme: IconThemeData(
              color: AppColors.primaryColor, //change your color here
            ),
            title: Text(
              "View Appointment",
              style: TextStyle(color: AppColors.primaryColor),
            ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text('Voice call appointment',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
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
                            GestureDetector(
                              onTap: () {
                                print(doctor?.phonenumber);
                                model.makePhoneCall(doctor?.phonenumber);
                              },
                              child: Container(
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
                      VisitingTimeWidget(
                        appointment: appointment,
                        model: model,
                      ),
                      PatientInfomationWidget(patient: patient),
                      DescriptionSectionWidget(appointment: appointment),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
