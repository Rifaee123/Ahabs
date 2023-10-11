import 'package:json_annotation/json_annotation.dart';

part 'verify_response.g.dart';

@JsonSerializable()
class VerifyResponse {
  String? status;
  String? message;

  VerifyResponse({this.status, this.message});

  factory VerifyResponse.fromJson(Map<String, dynamic> json) {
    return _$VerifyResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VerifyResponseToJson(this);
}
