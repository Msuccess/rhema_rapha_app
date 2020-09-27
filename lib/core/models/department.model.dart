import 'package:json_annotation/json_annotation.dart';

part 'department.model.g.dart';

@JsonSerializable()
class Department {
  String id;
  String name;
  String description;

  Department({
    this.id,
    this.name,
    this.description,
  });

  factory Department.fromJson(Map<String, dynamic> data) =>
      _$DepartmentFromJson(data);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}
