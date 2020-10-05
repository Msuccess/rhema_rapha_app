class PatientDto {
  String email;
  String fullName;
  String phonenumber;
  String dateOfBirth;
  String bloodType;
  String height;
  String address;
  String bloodPressure;
  String gender;

  PatientDto(
      {
      this.email,
      this.fullName,
      this.phonenumber,
      this.dateOfBirth,
      this.address,
      this.bloodPressure,
      this.height,
      this.bloodType,
      this.gender});

  PatientDto patientDtoFromJson(Map<String, dynamic> json) {
    return PatientDto(
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      phonenumber: json['phonenumber'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      address: json['address'] as String,
      bloodPressure: json['bloodPressure'] as String,
      height: json['height'] as String,
      bloodType: json['bloodType'] as String,
      gender: json['gender'] as String,
    );
  }

  Map<String, dynamic> patientDtoToJson(PatientDto instance) =>
      <String, dynamic>{
        'email': instance.email,
        'fullName': instance.fullName,
        'phonenumber': instance.phonenumber,
        'dateOfBirth': instance.dateOfBirth,
        'bloodType': instance.bloodType,
        'height': instance.height,
        'address': instance.address,
        'bloodPressure': instance.bloodPressure,
        'gender': instance.gender,
      };
}
