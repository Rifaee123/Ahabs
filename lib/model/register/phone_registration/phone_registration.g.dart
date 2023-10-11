// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneRegistration _$PhoneRegistrationFromJson(Map<String, dynamic> json) =>
    PhoneRegistration(
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$PhoneRegistrationToJson(PhoneRegistration instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'password': instance.password,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth,
      'username': instance.username,
    };
