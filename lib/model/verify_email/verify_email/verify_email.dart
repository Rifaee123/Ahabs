import 'package:json_annotation/json_annotation.dart';

part 'verify_email.g.dart';

@JsonSerializable()
class VerifyEmail {
  String? email;
  String? code;

  VerifyEmail({this.email, this.code});

  factory VerifyEmail.fromJson(Map<String, dynamic> json) {
    return _$VerifyEmailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VerifyEmailToJson(this);
}
