// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatroom_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatroomResponse _$ChatroomResponseFromJson(Map<String, dynamic> json) =>
    ChatroomResponse(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatroomResponseToJson(ChatroomResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
