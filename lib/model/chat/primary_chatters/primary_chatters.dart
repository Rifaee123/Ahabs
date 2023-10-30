import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'primary_chatters.g.dart';

@JsonSerializable()
class PrimaryChatters {
  bool? success;
  List<Datum>? data;

  PrimaryChatters({this.success, this.data});

  factory PrimaryChatters.fromJson(Map<String, dynamic> json) {
    return _$PrimaryChattersFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PrimaryChattersToJson(this);
}
