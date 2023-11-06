import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
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
  String? createdAt;

  User({
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
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
