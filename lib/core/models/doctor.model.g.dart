// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) {
  return Doctor(
    id: json['id'] as String,
    email: json['email'] as String,
    fullName: json['fullName'] as String,
    phonenumber: json['phonenumber'] as String,
    password: json['password'] as String,
    role: json['role'] as String,
    dateOfBirth: json['dateOfBirth'] as String,
    departmentId: json['departmentId'] as String,
    daysAvailable: json['daysAvailable'] as String,
    address: json['address'] as String,
    timesAvailable: json['timesAvailable'] as String,
    avatar: json['avatar'] as String,
    department: json['department'] == null
        ? null
        : Department.fromJson(json['department'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'phonenumber': instance.phonenumber,
      'password': instance.password,
      'role': instance.role,
      'dateOfBirth': instance.dateOfBirth,
      'departmentId': instance.departmentId,
      'daysAvailable': instance.daysAvailable,
      'address': instance.address,
      'timesAvailable': instance.timesAvailable,
      'avatar': instance.avatar,
      'department': instance.department?.toJson(),
    };
