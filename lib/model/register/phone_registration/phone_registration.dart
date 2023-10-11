import 'package:json_annotation/json_annotation.dart';

part 'phone_registration.g.dart';

@JsonSerializable()
class PhoneRegistration {
  String? phone;
  String? password;
  String? gender;
  String? dateOfBirth;
  String? username;

  PhoneRegistration({
    this.phone,
    this.password,
    this.gender,
    this.dateOfBirth,
    this.username,
  });

  factory PhoneRegistration.fromJson(Map<String, dynamic> json) {
    return _$PhoneRegistrationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PhoneRegistrationToJson(this);
}
