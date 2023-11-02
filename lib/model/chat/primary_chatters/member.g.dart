// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      id: json['_id'] as String?,
      username: json['username'] as String?,
      profilepicture: json['profilepicture'] as String?,
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'profilepicture': instance.profilepicture,
    };
