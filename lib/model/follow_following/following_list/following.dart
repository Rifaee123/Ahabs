import 'package:json_annotation/json_annotation.dart';

part 'following.g.dart';

@JsonSerializable()
class Following {
  @JsonKey(name: '_id')
  String? id;
  String? username;
  String? profilepicture;

  Following({this.id, this.username, this.profilepicture});

  factory Following.fromJson(Map<String, dynamic> json) {
    return _$FollowingFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FollowingToJson(this);
}
