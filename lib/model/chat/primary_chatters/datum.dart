import 'package:json_annotation/json_annotation.dart';

import 'sendeduser.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datum {
  String? roomId;
  Sendeduser? sendeduser;

  Datum({this.roomId, this.sendeduser});

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
