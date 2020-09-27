import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:intl/intl.dart';

class InputDateTimeField extends StatelessWidget {
  final TextEditingController controller;
  final Function suffixIconOnPressed;
  final bool isTextArea;
  final bool visibility;
  final Function validator;
  final Function onSaved;
  final Function onTap;
  final double iconSize;
  final bool isPassword;
  final bool showKeyboard;
  final String text;
  final String newValue;
  final TextInputType inputType;
  final bool disabled;
  final IconData inputPrefixIcon;

  InputDateTimeField({
    Key key,
    @required this.text,
    this.onSaved,
    this.onTap,
    this.showKeyboard,
    this.controller,
    this.iconSize = 0,
    this.validator,
    this.isPassword,
    this.visibility,
    this.suffixIconOnPressed,
    this.inputPrefixIcon,
    this.inputType,
    this.newValue,
    this.disabled = false,
    this.isTextArea = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");

    return DateTimeField(
      format: format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
          context: context,
          firstDate: DateTime(1800),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2200),
        );
      },
      controller: controller,
      cursorColor: AppColors.primaryText,
      enabled: !disabled,
      maxLines: isTextArea ? 3 : 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: text,
        labelStyle: TextStyle(
          color: AppColors.primaryText,
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
        fillColor: AppColors.whiteShade2,
        errorBorder: OutlineInputBorder(
          gapPadding: 3,
          borderSide: BorderSide(color: AppColors.dangerColor, width: 2),
        ),
        prefixIcon: Icon(
          FeatherIcons.calendar,
          size: 20.0,
        ),
      ),
      style: TextStyle(
        color: disabled ? AppColors.primaryText : AppColors.primaryText,
        fontWeight: FontWeight.w400,
      ),
      obscureText: isPassword == null ? false : isPassword,
      autocorrect: false,
      keyboardType: inputType,
      validator: (value) => validator(value),
      onSaved: (value) => onSaved(value),
    );
  }
}
