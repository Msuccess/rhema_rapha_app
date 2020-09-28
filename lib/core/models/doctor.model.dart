import 'package:json_annotation/json_annotation.dart';
import 'package:rhema_rapha_app/core/models/department.model.dart';

part 'doctor.model.g.dart';

@JsonSerializable(explicitToJson: true)
class Doctor {
  String id;
  String email;
  String fullName;
  String phonenumber;
  String password;
  String role;
  String dateOfBirth;
  String departmentId;
  String daysAvailable;
  String address;
  String timesAvailable;
  String avatar;
  Department department;

  Doctor(
      {this.id,
      this.email,
      this.fullName,
      this.phonenumber,
      this.password,
      this.role,
      this.dateOfBirth,
      this.departmentId,
      this.daysAvailable,
      this.address,
      this.timesAvailable,
      this.avatar,
      this.department});

  Doctor.initial()
      : id = "",
        email = "",
        fullName = "",
        phonenumber = "",
        password = "",
        role = "",
        dateOfBirth = "",
        departmentId = "",
        daysAvailable = "",
        address = "",
        timesAvailable = "",
        avatar = "";
        
  factory Doctor.fromJson(Map<String, dynamic> data) => _$DoctorFromJson(data);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
