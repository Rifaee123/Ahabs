// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      roomId: json['roomId'] as String?,
      sendeduser: json['sendeduser'] == null
          ? null
          : Sendeduser.fromJson(json['sendeduser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'roomId': instance.roomId,
      'sendeduser': instance.sendeduser,
    };
