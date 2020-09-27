import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/text_style.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/routes/routes.dart';
import 'package:rhema_rapha_app/views/widgets/appbar.widget.dart';
import 'package:rhema_rapha_app/views/widgets/random_color.widget.dart';

class DoctorTile extends StatelessWidget {
  final Doctor doctor;

  const DoctorTile({Key key, @required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = doctor;
    var initials = AppBarWidget.getInitials(name: model.fullName, limitTo: 2);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
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
            contentPadding: EdgeInsets.all(0),
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(13)),
              child: model.avatar != null
                  ? Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: randomColor(),
                      ),
                      child: Image.asset(
                        model.avatar,
                        height: 50,
                        width: 50,
                        fit: BoxFit.contain,
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: randomColor(),
                      child: Text(
                        initials,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
            ),
            title: Text(
              model.fullName,
              style: AppTexts.title,
            ),
            subtitle: Text(
              model.phonenumber,
              style: AppTexts.h6,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              size: 30,
              color: AppColors.primaryColor,
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutePaths.DoctorDetails,
                arguments: model,
              );
            }),
      ),
    );
  }
}
