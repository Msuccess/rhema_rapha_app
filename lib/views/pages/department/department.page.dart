import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/core/models/department.model.dart';
import 'package:rhema_rapha_app/core/view_models/department.viewmodel.dart';
import 'package:rhema_rapha_app/views/pages/home/home.widget.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';

class DepartmentPage extends StatefulWidget {
  final List<Department> arguments;

  const DepartmentPage({Key key, this.arguments}) : super(key: key);

  @override
  _DepartmentPageState createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  List<Department> department = List<Department>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DepartmentViewModel>(
      model: DepartmentViewModel(
        departmentService: Provider.of(context),
      ),
      onModelReady: (DepartmentViewModel model) async {
        department = widget.arguments;
      },
      builder: (BuildContext context, DepartmentViewModel model, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Services"),
            elevation: 2.0,
            backgroundColor: AppColors.whiteShade2,
            iconTheme: IconThemeData(
              color: AppColors.primaryColor, //change your color here
            ),
          ),
          body: SafeArea(
            child: DepartmentsWidget(
              departments: department,
            ),
          ),
        );
      },
    );
  }
}
