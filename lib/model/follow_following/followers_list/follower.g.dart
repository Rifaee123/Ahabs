// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Follower _$FollowerFromJson(Map<String, dynamic> json) => Follower(
      id: json['_id'] as String?,
      username: json['username'] as String?,
      profilepicture: json['profilepicture'] as String?,
    );

Map<String, dynamic> _$FollowerToJson(Follower instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'profilepicture': instance.profilepicture,
    };
