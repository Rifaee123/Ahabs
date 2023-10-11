import 'package:json_annotation/json_annotation.dart';

part 'email_registration.g.dart';

@JsonSerializable()
class EmailRegistration {
  String? email;
  String? password;
  String? gender;
  String? dateOfBirth;
  String? username;

  EmailRegistration({
    this.email,
    this.password,
    this.gender,
    this.dateOfBirth,
    this.username,
  });

  factory EmailRegistration.fromJson(Map<String, dynamic> json) {
    return _$EmailRegistrationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmailRegistrationToJson(this);
}
