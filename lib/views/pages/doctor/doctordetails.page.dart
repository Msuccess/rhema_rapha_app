import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/assets/styles/sizes.dart';
import 'package:rhema_rapha_app/assets/styles/text_style.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/view_models/doctor.viewmode.dart';
import 'package:rhema_rapha_app/views/widgets/appbar.widget.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';
import 'package:rhema_rapha_app/views/widgets/random_color.widget.dart';

class DoctorDetailsPage extends StatefulWidget {
  final arguments;

  const DoctorDetailsPage({Key key, this.arguments}) : super(key: key);

  @override
  _DoctorDetailsPageState createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage> {
  Doctor doctor;

  @override
  Widget build(BuildContext context) {
    var initials = AppBarWidget.getInitials(name: doctor.fullName, limitTo: 2);
    return BaseWidget<DoctorViewModel>(
      model: DoctorViewModel(),
      onModelReady: (DoctorViewModel model) async {
        doctor = widget.arguments;
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
            bottom: false,
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: randomColor(),
                  child: Text(
                    initials,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ), // ignore: missing_required_param
                DraggableScrollableSheet(
                  maxChildSize: .8,
                  initialChildSize: .6,
                  minChildSize: .6,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      height: AppSizes.fullHeight(context) * 5,
                      padding: EdgeInsets.only(left: 19, right: 19, top: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    doctor.fullName,
                                    style: AppTexts.title,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    size: 18,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Spacer(),
                                ],
                              ),
                              subtitle: Text(
                            doctor.phonenumber,
                            style: AppTexts.normalText,
                          ),
                            ),
                             Divider(
                          thickness: .3,
                          color: AppColors.grey,
                        ),
                        Row(
                        
                        ), Divider(
                          thickness: .3,
                          color: AppColors.grey,
                        ),Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("About", style: AppTexts.title),
                        ),
                        Text(
                        doctor.timesAvailable,
                          style: AppTexts.inputText
                        ),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightColor.grey.withAlpha(150)
                              ),
                              child: Icon(Icons.call, color: Colors.white,),
                            ).ripple((){}, borderRadius:BorderRadius.circular(10), ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightColor.grey.withAlpha(150)
                              ),
                              child: Icon(Icons.chat_bubble, color: Colors.white,),
                            ).ripple((){}, borderRadius:BorderRadius.circular(10), ),
                            SizedBox(
                              width: 10,
                            ),
                            FlatButton(
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              onPressed: () {},
                              child: Text("Make an appointment", style: TextStyles.titleNormal.white,).p(10),
                            ),
                          ],
                        )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
