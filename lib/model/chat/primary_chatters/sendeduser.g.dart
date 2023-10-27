// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sendeduser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sendeduser _$SendeduserFromJson(Map<String, dynamic> json) => Sendeduser(
      id: json['_id'] as String?,
      username: json['username'] as String?,
      profilepicture: json['profilepicture'] as String?,
    );

Map<String, dynamic> _$SendeduserToJson(Sendeduser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'profilepicture': instance.profilepicture,
    };
