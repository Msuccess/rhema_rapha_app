import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/text_style.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/routes/routes.dart';
import 'package:rhema_rapha_app/core/view_models/home.viewmodel.dart';
import 'package:rhema_rapha_app/views/pages/home/home.widget.dart';
import 'package:rhema_rapha_app/views/widgets/appbar.widget.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';
import 'package:rhema_rapha_app/views/widgets/doctortile.widget.dart';
import 'package:rhema_rapha_app/views/widgets/random_color.widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Doctor> doctors = List<Doctor>();
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      model: HomeViewModel(
        authService: Provider.of(context),
        departmentService: Provider.of(context),
        doctorService: Provider.of(context),
      ),
      onModelReady: (HomeViewModel model) async {
        model.init();
      },
      builder: (BuildContext context, HomeViewModel model, Widget child) {
        var fullname = model.userDetails['fullName'];
        doctors = model.doctors;
        return SafeArea(
          child: Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      HeaderWidget(name: fullname),
                      SearchWidgets(),
                      Departments(),
                    ],
                  ),
                ),
                buildDoctorList()
              ],
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
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Top Doctors", style: AppTexts.title),
                IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.Doctor,
                      arguments: doctors,
                    );
                  },
                ),
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
      children: doctors.take(5).map((x) {
        return DoctorTile(doctor: x);
      }).toList(),
    );
  }
}