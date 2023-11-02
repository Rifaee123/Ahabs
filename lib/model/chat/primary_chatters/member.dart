import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  @JsonKey(name: '_id')
  String? id;
  String? username;
  String? profilepicture;

  Member({this.id, this.username, this.profilepicture});

  factory Member.fromJson(Map<String, dynamic> json) {
    return _$MemberFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
