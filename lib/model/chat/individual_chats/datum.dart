import 'package:json_annotation/json_annotation.dart';

import 'reply_id.dart';

part 'datum.g.dart';

@JsonSerializable()
class ChatData {
  @JsonKey(name: '_id')
  String? id;
  String? senderId;
  String? message;
  String? roomId;
  DateTime? createdAt;
  DateTime? updatedAt;
  ReplyId? replyId;
  List<String>? deleteduser;
  @JsonKey(name: '__v')
  int? v;

  ChatData(
      {this.id,
      this.senderId,
      this.message,
      this.roomId,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.replyId,
      this.deleteduser});

  factory ChatData.fromJson(Map<String, dynamic> json) =>
      _$ChatDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDataToJson(this);
}
