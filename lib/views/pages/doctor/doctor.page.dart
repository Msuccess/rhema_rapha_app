import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';

import 'package:rhema_rapha_app/assets/styles/text_style.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/view_models/doctor.viewmode.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';
import 'package:rhema_rapha_app/views/widgets/doctortile.widget.dart';

class DoctorPage extends StatefulWidget {
  final List<Doctor> arguments;

  const DoctorPage({Key key, this.arguments}) : super(key: key);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  List<Doctor> doctors = List<Doctor>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DoctorViewModel>(
      model: DoctorViewModel(
        departmentService: Provider.of(context),
      ),
      onModelReady: (DoctorViewModel model) async {
        doctors = widget.arguments;
      },
      builder: (BuildContext context, DoctorViewModel model, Widget child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            backgroundColor: AppColors.whiteShade2,
            iconTheme: IconThemeData(
              color: AppColors.primaryColor, //change your color here
            ),
          ),
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[buildDoctorList()],
            ),
          ),
        );
      },
    );
  }

  buildDoctorList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Doctors Available", style: AppTexts.title),
              ],
            ),
          ),
          getdoctorWidgetList()
        ],
      ),
    );
  }

  getdoctorWidgetList() {
    return Column(
      children: doctors.map((x) {
        return DoctorTile(doctor: x);
      }).toList(),
    );
  }
}
