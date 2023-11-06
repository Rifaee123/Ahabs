import 'package:json_annotation/json_annotation.dart';

import 'chat_message.dart';

part 'send_chat.g.dart';

@JsonSerializable()
class SendChat {
  String? status;
  ChatMessage? chatMessage;

  SendChat({this.status, this.chatMessage});

  factory SendChat.fromJson(Map<String, dynamic> json) {
    return _$SendChatFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SendChatToJson(this);
}
