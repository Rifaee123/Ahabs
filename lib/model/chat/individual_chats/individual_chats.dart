import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'individual_chats.g.dart';

@JsonSerializable()
class IndividualChats {
  String? status;
  List<ChatData>? data;

  IndividualChats({this.status, this.data});

  factory IndividualChats.fromJson(Map<String, dynamic> json) {
    return _$IndividualChatsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$IndividualChatsToJson(this);
}
