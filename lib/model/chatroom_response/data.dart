import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  String? createdBy;
  List<String>? members;
  String? name;
  @JsonKey(name: '_id')
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;

  Data({
    this.createdBy,
    this.members,
    this.name,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  get data => null;

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
