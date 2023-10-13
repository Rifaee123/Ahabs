import 'package:json_annotation/json_annotation.dart';

import 'follower.dart';

part 'followers_list.g.dart';

@JsonSerializable()
class FollowersList {
  String? status;
  List<Follower>? followers;

  FollowersList({this.status, this.followers});

  factory FollowersList.fromJson(Map<String, dynamic> json) {
    return _$FollowersListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FollowersListToJson(this);
}
