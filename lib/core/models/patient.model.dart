import 'package:flutter/src/widgets/editable_text.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rhema_rapha_app/core/models/appointment.model.dart';

part 'patient.model.g.dart';

@JsonSerializable(explicitToJson: true)
class Patient {
  String id;
  String email;
  String fullName;
  String phonenumber;
  String dateOfBirth;
  String bloodType;
  String height;
  String address;
  String bloodPressure;
   String gender;
  List<Appointment> appointment;



  Patient(
      {this.id,
      this.email,
      this.fullName,
      this.phonenumber,
      this.dateOfBirth,
      this.address,
      this.appointment,
      this.bloodPressure,
      this.height,
      this.bloodType,
      this.gender
      });

  Patient.initial()
      : id = "",
        email = "",
        fullName = "",
        phonenumber = "",
        dateOfBirth = "",
        address = "",
        appointment = [],
        bloodPressure = "",
        height = "",
        bloodType = "",
        gender="";

  factory Patient.fromJson(Map<String, dynamic> data) =>
      _$PatientFromJson(data);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
