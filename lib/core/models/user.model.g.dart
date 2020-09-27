// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email'] as String,
    password: json['password'] as String,
    phonenumber: json['phonenumber'] as String,
    fullName: json['fullName'] as String,
    role: json['role'] as String,
    dateOfBirth: json['dateOfBirth'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'fullName': instance.fullName,
      'phonenumber': instance.phonenumber,
      'password': instance.password,
      'role': instance.role,
      'dateOfBirth': instance.dateOfBirth,
    };
