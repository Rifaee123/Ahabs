import 'package:hive/hive.dart';
part 'chat_length.g.dart';

@HiveType(typeId: 4)
class ChatLengthModel {
  @HiveField(0)
  String? roomId;

  @HiveField(1)
  final int? chatLength;
  ChatLengthModel({required this.roomId, required this.chatLength});
}

class ChatLengthBox {
  static Box<ChatLengthModel>? _getbox;
  static Box<ChatLengthModel> getInstance() {
    return _getbox ??= Hive.box('ChatLengthBox');
  }
}
