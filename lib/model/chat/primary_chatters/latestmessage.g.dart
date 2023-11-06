// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latestmessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Latestmessage _$LatestmessageFromJson(Map<String, dynamic> json) =>
    Latestmessage(
      id: json['_id'] as String?,
      senderId: json['senderId'] as String?,
      message: json['message'] as String?,
      roomId: json['roomId'] as String?,
      replyId: json['replyId'],
      deleteduser: (json['deleteduser'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$LatestmessageToJson(Latestmessage instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'senderId': instance.senderId,
      'message': instance.message,
      'roomId': instance.roomId,
      'replyId': instance.replyId,
      'deleteduser': instance.deleteduser,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
