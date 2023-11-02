import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'primary_chatters.g.dart';

@JsonSerializable()
class PrimaryChatters {
  String? status;
  List<Datum>? data;

  PrimaryChatters({this.status, this.data});

  factory PrimaryChatters.fromJson(Map<String, dynamic> json) {
    return _$PrimaryChattersFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PrimaryChattersToJson(this);
}
