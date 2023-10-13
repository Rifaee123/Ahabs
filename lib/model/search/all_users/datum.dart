import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class AllUserData {
  @JsonKey(name: '_id')
  String? id;
  String? email;
  String? password;
  String? username;
  String? gender;
  DateTime? dateOfBirth;
  List<dynamic>? followers;
  List<dynamic>? following;
  bool? verified;
  bool? isblocked;
  String? profilepicture;

  String? phone;

  AllUserData({
    this.id,
    this.email,
    this.password,
    this.username,
    this.gender,
    this.dateOfBirth,
    this.followers,
    this.following,
    this.verified,
    this.isblocked,
    this.profilepicture,
    this.phone,
  });

  factory AllUserData.fromJson(Map<String, dynamic> json) =>
      _$AllUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$AllUserDataToJson(this);
}
