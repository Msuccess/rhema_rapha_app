import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/text_style.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/routes/routes.dart';
import 'package:rhema_rapha_app/core/view_models/home.viewmodel.dart';
import 'package:rhema_rapha_app/views/pages/home/home.widget.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';
import 'package:rhema_rapha_app/views/widgets/doctortile.widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        if (model.userDetails.isEmpty) return SizedBox.shrink();
        if (model.doctors.isEmpty) return SizedBox.shrink();
        var fullname = model.userDetails['fullName'];
        return SafeArea(
          child: model.busy
              ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                )
              : Scaffold(
                  body: CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            HeaderWidget(name: fullname),
                            HomeBottomWidgets(),
                            DepartmentsWidget(departments: model.departments),
                          ],
                        ),
                      ),
                      buildDoctorList(model)
                    ],
                  ),
                ),
        );
      },
    );
  }

  buildDoctorList(HomeViewModel model) {
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
                      arguments: model.doctors,
                    );
                  },
                ),
              ],
            ),
          ),
          getdoctorWidgetList(model)
        ],
      ),
    );
  }

  getdoctorWidgetList(HomeViewModel model) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        ...model.doctors.take(5).toList().asMap().entries.map((e) {
          return DoctorTile(
            doctor: e.value,
          );
        }).toList(),
      ],
    );
  }
}
