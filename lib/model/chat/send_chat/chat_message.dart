import 'package:json_annotation/json_annotation.dart';

import 'reply_id.dart';

part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  String? senderId;
  String? message;
  String? roomId;
  ReplyId? replyId;
  @JsonKey(name: '_id')
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;
  String? to;

  ChatMessage(
      {this.senderId,
      this.message,
      this.roomId,
      this.replyId,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.to});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return _$ChatMessageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
  addTo(String toId) {
    to = toId;
  }
}
