import 'package:json_annotation/json_annotation.dart';

part 'reply_id.g.dart';

@JsonSerializable()
class ReplyId {
  String? message;
  @JsonKey(name: '_id')
  String? id;

  ReplyId({this.message, this.id});

  factory ReplyId.fromJson(Map<String, dynamic> json) {
    return _$ReplyIdFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReplyIdToJson(this);
}
