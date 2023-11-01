import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class ChatData {
  @JsonKey(name: '_id')
  String? id;
  String? senderId;
  String? message;
  String? roomId;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;

  ChatData({
    this.id,
    this.senderId,
    this.message,
    this.roomId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) => _$ChatDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDataToJson(this);
}
