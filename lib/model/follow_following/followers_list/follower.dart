import 'package:json_annotation/json_annotation.dart';

part 'follower.g.dart';

@JsonSerializable()
class Follower {
  @JsonKey(name: '_id')
  String? id;
  String? username;
  String? profilepicture;

  Follower({this.id, this.username, this.profilepicture});

  factory Follower.fromJson(Map<String, dynamic> json) {
    return _$FollowerFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FollowerToJson(this);
}
