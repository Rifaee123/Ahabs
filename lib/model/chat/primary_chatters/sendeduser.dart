import 'package:json_annotation/json_annotation.dart';

part 'sendeduser.g.dart';

@JsonSerializable()
class Sendeduser {
  @JsonKey(name: '_id')
  String? id;
  String? username;
  String? profilepicture;

  Sendeduser({this.id, this.username, this.profilepicture});

  factory Sendeduser.fromJson(Map<String, dynamic> json) {
    return _$SendeduserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SendeduserToJson(this);
}
