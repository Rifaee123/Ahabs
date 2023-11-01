// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individual_chats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndividualChats _$IndividualChatsFromJson(Map<String, dynamic> json) =>
    IndividualChats(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ChatData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IndividualChatsToJson(IndividualChats instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
