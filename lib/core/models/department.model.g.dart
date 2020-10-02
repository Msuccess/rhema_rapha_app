// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Department _$DepartmentFromJson(Map<String, dynamic> json) {
  return Department(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    doctor: (json['doctor'] as List)
        ?.map((e) =>
            e == null ? null : Doctor.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'doctor': instance.doctor?.map((e) => e?.toJson())?.toList(),
    };
