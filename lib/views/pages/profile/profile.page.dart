import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/assets/styles/text_style.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("Profile Page",style: AppTexts.h20,),
    );
  }
}