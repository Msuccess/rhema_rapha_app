// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return Appointment(
    id: json['id'] as String,
    description: json['description'] as String,
    date: json['date'] as String,
    appointmentTime: json['appointmentTime'] as String,
    type: json['type'] as String,
    appointmentDay: json['appointmentDay'] as String,
    doctorId: json['doctorId'] as String,
    patientId: json['patientId'] as String,
    patient: json['patient'] == null
        ? null
        : Patient.fromJson(json['patient'] as Map<String, dynamic>),
    doctor: json['doctor'] == null
        ? null
        : Doctor.fromJson(json['doctor'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'date': instance.date,
      'appointmentTime': instance.appointmentTime,
      'type': instance.type,
      'appointmentDay': instance.appointmentDay,
      'doctorId': instance.doctorId,
      'patientId': instance.patientId,
      'patient': instance.patient?.toJson(),
      'doctor': instance.doctor?.toJson(),
    };
