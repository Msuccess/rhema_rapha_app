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
    appointment: (json['appointment'] as List)
        ?.map((e) =>
            e == null ? null : Appointment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    bloodPressure: json['bloodPressure'] as String,
    height: json['height'] as String,
    bloodType: json['bloodType'] as String,
    gender: json['gender'] as String,
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
      'gender': instance.gender,
      'appointment': instance.appointment?.map((e) => e?.toJson())?.toList(),
    };
