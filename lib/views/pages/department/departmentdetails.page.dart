import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/core/models/department.model.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/view_models/department.viewmodel.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';
import 'package:rhema_rapha_app/views/widgets/doctortile.widget.dart';

class DepartmentDetailsPage extends StatefulWidget {
  final arguments;

  const DepartmentDetailsPage({Key key, this.arguments}) : super(key: key);

  @override
  _DepartmentDetailsPageState createState() => _DepartmentDetailsPageState();
}

class _DepartmentDetailsPageState extends State<DepartmentDetailsPage> {
  Department department = Department.initial();
  List<Doctor> doctor;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DepartmentViewModel>(
      model: DepartmentViewModel(
        departmentService: Provider.of(context),
      ),
      onModelReady: (DepartmentViewModel model) async {
        department = widget.arguments;

        var id = widget.arguments.departmentId;
        await model.getDepartment(id);
        doctor = department.doctor;
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
          body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              department.name,
                            ),
                            Text(
                              department.description,
                            ),
                          ],
                        ),
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(8),
                          itemCount: department.doctor.length,
                          itemBuilder: (BuildContext context, int index) {
                            return DoctorTile(
                              doctor: department.doctor[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
