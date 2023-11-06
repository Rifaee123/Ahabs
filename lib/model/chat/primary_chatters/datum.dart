import 'package:json_annotation/json_annotation.dart';

import 'latestmessage.dart';
import 'member.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datum {
  @JsonKey(name: '_id')
  String? id;
  String? createdBy;
  List<Member>? members;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;
  Latestmessage? latestmessage;
  int? messageCount;

  Datum({
    this.id,
    this.createdBy,
    this.members,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.latestmessage,
    this.messageCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
