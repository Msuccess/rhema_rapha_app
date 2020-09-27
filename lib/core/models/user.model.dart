import 'package:json_annotation/json_annotation.dart';
part 'user.model.g.dart';

@JsonSerializable()
class User {
  String email;
  String fullName;
  String phonenumber;
  String password;
  String role;
  String dateOfBirth;

  User(
      {this.email,
      this.password,
      this.phonenumber,
      this.fullName,
      this.role = "patient",
      this.dateOfBirth});

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
