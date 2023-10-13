// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'following.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Following _$FollowingFromJson(Map<String, dynamic> json) => Following(
      id: json['_id'] as String?,
      username: json['username'] as String?,
      profilepicture: json['profilepicture'] as String?,
    );

Map<String, dynamic> _$FollowingToJson(Following instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'profilepicture': instance.profilepicture,
    };
