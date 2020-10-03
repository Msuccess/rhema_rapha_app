import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';

class SelectInputField extends StatelessWidget {
  final bool visibility;
  final Function onSaved;
  final Function onTap;
  final bool showKeyboard;
  final String text;
  final String newValue;
  final TextInputType inputType;
  final bool disabled;
  final IconData inputPrefixIcon;

  SelectInputField({
    Key key,
    @required this.text,
    this.onSaved,
    this.onTap,
    this.showKeyboard,
    this.visibility,
    this.inputPrefixIcon,
    this.inputType,
    this.newValue,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      attribute: "gender",
      // initialValue: 'Male',
      hint: Text('Select Gender'),
      validators: [FormBuilderValidators.required()],
      items: ['Male', 'Female']
          .map((gender) =>
              DropdownMenuItem(value: gender, child: Text("$gender")))
          .toList(),
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
          FeatherIcons.users,
          size: 20.0,
        ),
      ),
      style: TextStyle(
        color: disabled ? AppColors.primaryText : AppColors.primaryText,
        fontWeight: FontWeight.w400,
      ),
      onSaved: (value) => onSaved(value),
    );
  }
}
