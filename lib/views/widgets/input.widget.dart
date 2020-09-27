import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';

class InputWidget extends StatelessWidget {
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

  InputWidget({
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
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.primaryText,
      enabled: !disabled,
      maxLines: isTextArea ? 3 : 1,
      onTap: onTap == null ? () {} : () => onTap(),
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
          inputPrefixIcon,
          size: 20.0,
        ),
        suffixIcon: suffixIconOnPressed == null
            ? null
            : IconButton(
                onPressed: () => suffixIconOnPressed(),
                icon: Icon(
                  visibility ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primaryText,
                  size: 20.0,
                ),
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

class InputOnchangedWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final Function onSaved;
  final String text;
  final ValueChanged<String> onChanged;
  final TextInputType inputType;
  final bool isAmount;

  InputOnchangedWidget(
      {Key key,
      @required this.text,
      this.onSaved,
      this.controller,
      this.validator,
      this.onChanged,
      this.isAmount = false,
      this.inputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.white,
      decoration: InputDecoration(
        filled: true,
        labelText: text,
        labelStyle: TextStyle(
          color: AppColors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        fillColor: AppColors.whiteShade1,
        hintText: text,
        focusColor: AppColors.white,
        errorStyle: TextStyle(
          color: AppColors.dangerColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextStyle(color: AppColors.lightBlue),
        focusedErrorBorder: OutlineInputBorder(
          gapPadding: 3,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: AppColors.dangerColor, width: 2),
        ),
        border: OutlineInputBorder(
          gapPadding: 3,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.transparent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          gapPadding: 3,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: AppColors.dangerColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 3,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: AppColors.green, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          gapPadding: 3,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.transparent, width: 2),
        ),
        prefixText: isAmount ? '\$ ' : '',
        prefixStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      autocorrect: false,
      keyboardType:
          isAmount ? TextInputType.numberWithOptions(decimal: true) : inputType,
      validator: (value) => validator(value),
      onSaved: (value) => onSaved(value),
      onChanged: (value) => onChanged(value),
    );
  }
}