import 'package:json_annotation/json_annotation.dart';

import 'following.dart';

part 'following_list.g.dart';

@JsonSerializable()
class FollowingList {
  String? status;
  List<Following>? following;

  FollowingList({this.status, this.following});

  factory FollowingList.fromJson(Map<String, dynamic> json) {
    return _$FollowingListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FollowingListToJson(this);
}
