import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'chatroom_response.g.dart';

@JsonSerializable()
class ChatroomResponse {
  String? status;
  Data? data;

  ChatroomResponse({this.status, this.data});

  factory ChatroomResponse.fromJson(Map<String, dynamic> json) {
    log('message');
    return _$ChatroomResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatroomResponseToJson(this);
}
