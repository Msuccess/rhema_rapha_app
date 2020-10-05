import 'package:json_annotation/json_annotation.dart';

part 'appointment.model.g.dart';

@JsonSerializable()
class Appointment {
  String id;
  String description;
  String date;
  String appointmentTime;
  String type;
  String appointmentDay;
  String doctorId;
  String patientId;

  Appointment({
    this.id,
    this.description,
    this.date,
    this.appointmentTime,
    this.type,
    this.appointmentDay,
    this.doctorId,
    this.patientId,
  });

  factory Appointment.fromJson(Map<String, dynamic> data) =>
      _$AppointmentFromJson(data);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
