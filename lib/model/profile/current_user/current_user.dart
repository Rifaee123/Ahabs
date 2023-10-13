import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'current_user.g.dart';

@JsonSerializable()
class CurrentUser {
  String? status;
  User? user;

  CurrentUser({this.status, this.user});

  factory CurrentUser.fromJson(Map<String, dynamic> json) {
    return _$CurrentUserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);
}
