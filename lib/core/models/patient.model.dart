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
  String avatar;
  Appointment appointment;

  Patient(
      {this.id,
      this.email,
      this.fullName,
      this.phonenumber,
      this.dateOfBirth,
      this.address,
      this.avatar,
      this.appointment,
      this.bloodPressure,
      this.height,
      this.bloodType});

  Patient.initial()
      : id = "",
        email = "",
        fullName = "",
        phonenumber = "",
        dateOfBirth = "",
        address = "",
        avatar = "",
        appointment = new Appointment(),
        bloodPressure = "",
        height = "",
        bloodType = "";

  factory Patient.fromJson(Map<String, dynamic> data) =>
      _$PatientFromJson(data);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
