import 'package:json_annotation/json_annotation.dart';

part 'edit_profile.g.dart';

@JsonSerializable()
class EditProfile {
  String? gender;
  String? username;
  String? email;

  EditProfile({this.gender, this.username, this.email});

  factory EditProfile.fromJson(Map<String, dynamic> json) {
    return _$EditProfileFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EditProfileToJson(this);
}
