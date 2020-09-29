import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/view_models/doctordetails.viewmodel.dart';
import 'package:rhema_rapha_app/views/widgets/appbar.widget.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';
import 'package:rhema_rapha_app/views/widgets/detailstile.widget.dart';
import 'package:rhema_rapha_app/views/widgets/random_color.widget.dart';

class DoctorDetailsPage extends StatefulWidget {
  final arguments;

  const DoctorDetailsPage({Key key, this.arguments}) : super(key: key);

  @override
  _DoctorDetailsPageState createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage> {
  Doctor doctor = Doctor.initial();
  String initials;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DoctorDetailsViewModel>(
      model: DoctorDetailsViewModel(
        departmentService: Provider.of(context),
      ),
      onModelReady: (DoctorDetailsViewModel model) async {
        doctor = widget.arguments;

        var id = widget.arguments.departmentId;

        initials = AppBarWidget.getInitials(name: doctor.fullName, limitTo: 2);
        await model.getDepartment(id);
      },
      builder:
          (BuildContext context, DoctorDetailsViewModel model, Widget child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            backgroundColor: AppColors.whiteShade2,
            iconTheme: IconThemeData(
              color: AppColors.primaryColor, //change your color here
            ),
            title: Text(
              doctor.fullName,
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            child: Stack(
              children: [
                Positioned(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          maxRadius: 60.0,
                          backgroundColor: randomColor(),
                          child: Text(
                            initials,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        DetailsTilleWidget(
                          data: doctor.fullName,
                          iconData: FeatherIcons.user,
                          title: "Full Name",
                        ),
                        DetailsTilleWidget(
                          data: doctor.email,
                          iconData: FeatherIcons.mail,
                          title: "Email Address",
                        ),
                        DetailsTilleWidget(
                          data: doctor.address,
                          iconData: FeatherIcons.map,
                          title: "Email Address",
                        ),
                        DetailsTilleWidget2(
                          data: doctor.daysAvailable,
                          iconData: FeatherIcons.calendar,
                          title: "Day Available",
                        ),
                        DetailsTilleWidget2(
                          data: doctor.timesAvailable,
                          iconData: FeatherIcons.clock,
                          title: "Day Time",
                        ),
                        DetailsTilleWidget(
                          data: doctor.phonenumber,
                          iconData: FeatherIcons.phone,
                          title: "Phone Number",
                        ),
                        DetailsTilleWidget(
                          data: model.department == null
                              ? ""
                              : model.department.name,
                          iconData: FeatherIcons.box,
                          title: "Department",
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      child: FlatButton(
                        onPressed: () => {},
                        child: Text(
                          "Make Appointment",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
