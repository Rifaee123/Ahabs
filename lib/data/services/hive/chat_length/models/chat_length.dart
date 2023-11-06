import 'package:hive/hive.dart';
part 'chat_length.g.dart';

@HiveType(typeId: 0)
class ChatLengthModel {
  @HiveField(0)
  String? roomId;

  @HiveField(1)
  final int? chatLength;

  @HiveField(2)
  final String? latestMsg;

  @HiveField(3)
  final DateTime? latestTime;

  @HiveField(4)
  final int? latestCount;

  ChatLengthModel({
    required this.latestMsg,
    required this.latestTime,
    required this.latestCount,
    required this.roomId,
    required this.chatLength,
  });
}

class ChatLengthBox {
  static Box<ChatLengthModel>? _getbox;
  static Box<ChatLengthModel> getInstance() {
    return _getbox ??= Hive.box('ChatLengthBox');
  }
}
