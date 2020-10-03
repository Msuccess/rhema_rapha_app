import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/text_style.dart';
import 'package:rhema_rapha_app/core/models/department.model.dart';
import 'package:rhema_rapha_app/core/routes/routes.dart';
import 'package:rhema_rapha_app/core/view_models/department.viewmodel.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';

class DepartmentPage extends StatefulWidget {
  final List<Department> arguments;

  const DepartmentPage({Key key, this.arguments}) : super(key: key);

  @override
  _DepartmentPageState createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  List<Department> departments = List<Department>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DepartmentViewModel>(
      model: DepartmentViewModel(
        departmentService: Provider.of(context),
      ),
      onModelReady: (DepartmentViewModel model) async {
        departments = widget.arguments;
      },
      builder: (BuildContext context, DepartmentViewModel model, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Services",
              style: TextStyle(
                color: AppColors.primaryColor,
              ),
            ),
            elevation: 2.0,
            backgroundColor: AppColors.whiteShade2,
            iconTheme: IconThemeData(
              color: AppColors.primaryColor, //change your color here
            ),
          ),
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [getDepartmentWidgetList()],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getDepartmentWidgetList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: departments.map((department) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(4, 4),
                  blurRadius: 10,
                  color: AppColors.grey.withOpacity(.2),
                ),
                BoxShadow(
                  offset: Offset(-3, 0),
                  blurRadius: 15,
                  color: AppColors.grey.withOpacity(.1),
                )
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(department.name, style: AppTexts.title),
                ),
                subtitle: Text(department.description),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  size: 30,
                  color: AppColors.primaryColor,
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutePaths.DepartmentDetails,
                    arguments: department,
                  );
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
