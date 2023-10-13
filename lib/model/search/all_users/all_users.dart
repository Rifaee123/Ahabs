import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'all_users.g.dart';

@JsonSerializable()
class AllUsers {
  String? success;
  int? count;
  List<AllUserData>? data;

  AllUsers({this.success, this.count, this.data});

  factory AllUsers.fromJson(Map<String, dynamic> json) {
    return _$AllUsersFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllUsersToJson(this);
}
