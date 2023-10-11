// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailRegistration _$EmailRegistrationFromJson(Map<String, dynamic> json) =>
    EmailRegistration(
      email: json['email'] as String?,
      password: json['password'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$EmailRegistrationToJson(EmailRegistration instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth,
      'username': instance.username,
    };
