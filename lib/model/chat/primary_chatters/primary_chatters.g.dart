// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primary_chatters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrimaryChatters _$PrimaryChattersFromJson(Map<String, dynamic> json) =>
    PrimaryChatters(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PrimaryChattersToJson(PrimaryChatters instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
