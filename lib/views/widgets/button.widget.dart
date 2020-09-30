import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';

class ButtonWidget extends StatelessWidget {
  final Function onPressed;
  final busy;
  final text;
  final bool invert;
  final String imageName;
  final Color disabledColor;

  ButtonWidget({
    Key key,
    this.busy = false,
    this.onPressed,
    this.text,
    this.imageName,
    this.disabledColor,
    this.invert = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        child: FlatButton(
          onPressed: busy ? null : () => onPressed(),
          color: invert ? AppColors.white : AppColors.primaryColor,
          disabledColor: AppColors.primaryDisableColor,
          child: Center(
            child: busy
                ? CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      AppColors.white,
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: invert ? AppColors.primaryColor : AppColors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
