// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followers_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowersList _$FollowersListFromJson(Map<String, dynamic> json) =>
    FollowersList(
      status: json['status'] as String?,
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => Follower.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FollowersListToJson(FollowersList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'followers': instance.followers,
    };
