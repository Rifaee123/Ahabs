// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatData _$ChatDataFromJson(Map<String, dynamic> json) => ChatData(
      id: json['_id'] as String?,
      senderId: json['senderId'] as String?,
      message: json['message'] as String?,
      roomId: json['roomId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
      replyId: json['replyId'] == null
          ? null
          : ReplyId.fromJson(json['replyId'] as Map<String, dynamic>),
      deleteduser: (json['deleteduser'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ChatDataToJson(ChatData instance) => <String, dynamic>{
      '_id': instance.id,
      'senderId': instance.senderId,
      'message': instance.message,
      'roomId': instance.roomId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'replyId': instance.replyId,
      'deleteduser': instance.deleteduser,
      '__v': instance.v,
    };
