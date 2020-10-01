import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/sizes.dart';
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
            title: Text("Doctors Available"),
            elevation: 2.0,
            backgroundColor: AppColors.whiteShade2,
            iconTheme: IconThemeData(
              color: AppColors.primaryColor, //change your color here
            ),
          ),
          body: SafeArea(
              child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Sections", style: AppTexts.title),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: FlatButton(
                        child: Text(
                          "See All",
                          style: AppTexts.titleNormal
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          RoutePaths.Department,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSizes.fullHeight(context) * .35,
                width: AppSizes.fullWidth(context),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8),
                    itemCount: department.length,
                    itemBuilder: (BuildContext context, int index) {
                      return departmentCard(
                        context,
                        department[index].name,
                        department[index].description,
                        color: AppColors.green,
                        lightColor: AppColors.greenShade1,
                      );
                    }),
              ),
            ],
          )),
        );
      },
    );
  }




    Widget departmentCard(BuildContext context, String title, String subtitle,
      {Color color, Color lightColor}) {
    TextStyle titleStyle = AppTexts.titleLight;
    TextStyle subtitleStyle = AppTexts.subTitleLight;

    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppSizes.fullWidth(context) * .5,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundColor: lightColor,
                    radius: 60,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(title, style: titleStyle),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(subtitle, style: subtitleStyle),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
