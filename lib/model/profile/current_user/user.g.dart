// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      username: json['username'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      followers: json['followers'] as List<dynamic>?,
      following: json['following'] as List<dynamic>?,
      verified: json['verified'] as bool?,
      isblocked: json['isblocked'] as bool?,
      profilepicture: json['profilepicture'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'followers': instance.followers,
      'following': instance.following,
      'verified': instance.verified,
      'isblocked': instance.isblocked,
      'profilepicture': instance.profilepicture,
    };
