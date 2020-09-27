import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SignIn {
  String email;
  String password;

  SignIn({
    this.email,
    this.password,
  });

 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
