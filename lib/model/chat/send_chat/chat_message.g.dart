// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      senderId: json['senderId'] as String?,
      message: json['message'] as String?,
      roomId: json['roomId'] as String?,
      replyId: json['replyId'] == null
          ? null
          : ReplyId.fromJson(json['replyId'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
      to: json['to'] as String?,
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'message': instance.message,
      'roomId': instance.roomId,
      'replyId': instance.replyId,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
      'to': instance.to,
    };
