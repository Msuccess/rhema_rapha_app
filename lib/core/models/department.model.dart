import 'package:json_annotation/json_annotation.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';

part 'department.model.g.dart';

@JsonSerializable(explicitToJson: true)
class Department {
  String id;
  String name;
  String description;
  List<Doctor> doctor;

  Department({
    this.id,
    this.name,
    this.description,
    this.doctor
  });
  Department.initial()
      : name = "",
        description = "";

  factory Department.fromJson(Map<String, dynamic> data) =>
      _$DepartmentFromJson(data);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}
