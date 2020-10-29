import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/text_style.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/routes/routes.dart';
import 'package:rhema_rapha_app/views/widgets/appbar.widget.dart';
import 'package:rhema_rapha_app/views/widgets/random_color.widget.dart';

class DoctorTile extends StatefulWidget {
  final Doctor doctor;

  const DoctorTile({
    Key key,
    @required this.doctor,
  }) : super(key: key);

  @override
  _DoctorTileState createState() => _DoctorTileState();
}

class _DoctorTileState extends State<DoctorTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            child: InkWell(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutePaths.DoctorDetails,
                  arguments: widget.doctor,
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            Icons.account_circle_outlined,
                            color: AppColors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.doctor.fullName,
                                style: AppTexts.title,
                              ),
                              SizedBox(height: 5),
                              Text(
                                widget.doctor.phonenumber,
                                style: AppTexts.h6,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_right_outlined)
                  ],
                ),
              ),
            ),
          ),
        ) ??
        SizedBox.shrink();
  }

  static String getInitials({String name, int limitTo}) {
    if (name == null || name == '') return '';
    var buffer = StringBuffer();
    var split = name.split(' ');
    for (var i = 0; i < (limitTo ?? split.length); i++) {
      if (split[i][0] != null || split[i].isNotEmpty) buffer.write(split[i][0]);
    }

    return buffer.toString();
  }
}
