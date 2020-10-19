import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/text_style.dart';
import 'package:rhema_rapha_app/core/models/department.model.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/view_models/department.viewmodel.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';
import 'package:rhema_rapha_app/views/widgets/doctortile.widget.dart';
import 'package:rhema_rapha_app/views/widgets/loader.widget.dart';

class DepartmentDetailsPage extends StatefulWidget {
  final arguments;

  const DepartmentDetailsPage({Key key, this.arguments}) : super(key: key);

  @override
  _DepartmentDetailsPageState createState() => _DepartmentDetailsPageState();
}

class _DepartmentDetailsPageState extends State<DepartmentDetailsPage> {
  Department department = Department.initial();
  List<Doctor> doctors = [];

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DepartmentViewModel>(
      model: DepartmentViewModel(
        departmentService: Provider.of(context),
      ),
      onModelReady: (DepartmentViewModel model) async {
        var id = widget.arguments.id;
        await model.getDepartment(id);
        doctors = model.doctors;
        department = model.department;
      },
      builder: (BuildContext context, DepartmentViewModel model, Widget child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            backgroundColor: AppColors.whiteShade2,
            iconTheme: IconThemeData(
              color: AppColors.primaryColor, //change your color here
            ),
            title: Text(
              department.name,
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
          body: model.busy
              ? loaderWidget()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: SafeArea(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10.0,
                                    ),
                                    child: Text(
                                      department.name,
                                      style: AppTexts.title,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10.0,
                                    ),
                                    child: Text(
                                      department.description,
                                      style: AppTexts.h14,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                child: Text("Doctors Available",
                                    style: AppTexts.title),
                              ),
                              !model.busy && doctors.length != 0
                                  ? Column(
                                      children: doctors.map((doctor) {
                                        return doctor == null
                                            ? SizedBox.shrink()
                                            : DoctorTile(doctor: doctor);
                                      }).toList(),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                        top: 30.0,
                                      ),
                                      child: Align(
                                        child: Text(
                                          'No doctors in this department',
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  // getDoctorWidgetList() {
  //  return
  // }
}
