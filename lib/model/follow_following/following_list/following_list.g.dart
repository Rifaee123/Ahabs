// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'following_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowingList _$FollowingListFromJson(Map<String, dynamic> json) =>
    FollowingList(
      status: json['status'] as String?,
      following: (json['following'] as List<dynamic>?)
          ?.map((e) => Following.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FollowingListToJson(FollowingList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'following': instance.following,
    };
