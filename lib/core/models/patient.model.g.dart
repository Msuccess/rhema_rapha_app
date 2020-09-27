// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient(
    id: json['id'] as String,
    email: json['email'] as String,
    fullName: json['fullName'] as String,
    phonenumber: json['phonenumber'] as String,
    dateOfBirth: json['dateOfBirth'] as String,
    address: json['address'] as String,
    avatar: json['avatar'] as String,
    appointment: json['appointment'] == null
        ? null
        : Appointment.fromJson(json['appointment'] as Map<String, dynamic>),
    bloodPressure: json['bloodPressure'] as String,
    height: json['height'] as String,
    bloodType: json['bloodType'] as String,
  );
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'phonenumber': instance.phonenumber,
      'dateOfBirth': instance.dateOfBirth,
      'bloodType': instance.bloodType,
      'height': instance.height,
      'address': instance.address,
      'bloodPressure': instance.bloodPressure,
      'avatar': instance.avatar,
      'appointment': instance.appointment?.toJson(),
    };
