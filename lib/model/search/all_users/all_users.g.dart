// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllUsers _$AllUsersFromJson(Map<String, dynamic> json) => AllUsers(
      success: json['success'] as String?,
      count: json['count'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AllUserData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllUsersToJson(AllUsers instance) => <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
