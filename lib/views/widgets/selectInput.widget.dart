import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';

class SelectInputField extends StatelessWidget {
  final Function onSaved;
  final String text;
  final String selectedValue;

  SelectInputField({
    Key key,
    @required this.text,
    this.onSaved,
    this.selectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _gender = [
      "Male",
      "Female",
      "Others",
    ];

    return InputDecorator(
      decoration: InputDecoration(
        prefixIcon: Icon(
          FeatherIcons.users,
          size: 20.0,
        ),
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
          borderSide: BorderSide(
            color: AppColors.dangerColor,
            width: 2,
          ),
        ),
      ),
      isEmpty: selectedValue == '',
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isDense: true,
          onChanged: (selectedValue) => onSaved(selectedValue),
          items: _gender.map(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
