import 'package:json_annotation/json_annotation.dart';

part 'latestmessage.g.dart';

@JsonSerializable()
class Latestmessage {
  @JsonKey(name: '_id')
  String? id;
  String? senderId;
  String? message;
  String? roomId;
  dynamic replyId;
  List<String>? deleteduser;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;

  Latestmessage({
    this.id,
    this.senderId,
    this.message,
    this.roomId,
    this.replyId,
    this.deleteduser,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Latestmessage.fromJson(Map<String, dynamic> json) {
    return _$LatestmessageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LatestmessageToJson(this);
}
