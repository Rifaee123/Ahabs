// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendChat _$SendChatFromJson(Map<String, dynamic> json) => SendChat(
      status: json['status'] as String?,
      chatMessage: json['chatMessage'] == null
          ? null
          : ChatMessage.fromJson(json['chatMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SendChatToJson(SendChat instance) => <String, dynamic>{
      'status': instance.status,
      'chatMessage': instance.chatMessage,
    };
