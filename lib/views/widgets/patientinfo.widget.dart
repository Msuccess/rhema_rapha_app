import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/core/models/patient.model.dart';
import 'package:rhema_rapha_app/core/services/util.service.dart';
import 'package:rhema_rapha_app/views/widgets/patientdetail.widget.dart';

class PatientInfomationWidget extends StatelessWidget {
  final Patient patient;

  const PatientInfomationWidget({
    Key key,
    @required this.patient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    PatientDetailsWidget(
                      title: 'Name :  ',
                      subTitle: patient.fullName,
                    ),
                    SizedBox(height: 10),
                    PatientDetailsWidget(
                      title: 'Date of Birth :  ',
                      subTitle: UtilService.formatShortDate(
                        DateTime.parse(patient.dateOfBirth),
                      ),
                    ),
                    SizedBox(height: 10),
                    PatientDetailsWidget(
                      title: 'Phone :  ',
                      subTitle: patient.phonenumber,
                    ),
                    SizedBox(height: 10),
                    PatientDetailsWidget(
                      title: 'Email :  ',
                      subTitle: patient.email,
                    ),
                    SizedBox(height: 10),
                    PatientDetailsWidget(
                      title: 'Gender:  ',
                      subTitle: patient.gender,
                    ),
                    SizedBox(height: 10),
                    PatientDetailsWidget(
                      title: 'Address :  ',
                      subTitle: patient.address,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Medical Details',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    PatientDetailsWidget(
                      title: 'Height :  ',
                      subTitle: patient.height,
                    ),
                    PatientDetailsWidget(
                      title: 'BloodType :  ',
                      subTitle: patient.bloodType,
                    ),
                    SizedBox(height: 10),
                    PatientDetailsWidget(
                      title: 'BloodPressure :  ',
                      subTitle: patient.bloodPressure,
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
}
