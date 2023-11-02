import 'dart:developer';

import 'package:ahbas/data/services/hive/models/chat_length.dart';
import 'package:hive/hive.dart';

class ChatLengthService {
  // creating a singleton
  ChatLengthService.internal();
  static ChatLengthService instance = ChatLengthService.internal();
  ChatLengthService factory() {
    return instance;
  }

///////////////////////////////////////////
  late Box<ChatLengthModel> chatLengthBox;
  openChatLengthBox() async {
    chatLengthBox = await Hive.openBox("chatLengthBox");
  }

  addChatListLength(int chatLength, String roomId) {
    
    List<ChatLengthModel> chatsLengthList = [];
    chatsLengthList = chatLengthBox.values.toList();
    if (chatsLengthList.where((element) => element.roomId == roomId).isEmpty) {
      chatLengthBox
          .add(ChatLengthModel(roomId: roomId, chatLength: chatLength));
    } else {
      int index =
          chatsLengthList.indexWhere((element) => element.roomId == roomId);
      chatLengthBox.putAt(
          index, ChatLengthModel(roomId: roomId, chatLength: chatLength));
    }
  }

  int? getChatListLength(String roomId) {
    List<ChatLengthModel> chatsLengthList = [];
    chatsLengthList = chatLengthBox.values.toList();
    if (chatsLengthList
        .where((element) => element.roomId == roomId)
        .isNotEmpty) {
      int index =
          chatsLengthList.indexWhere((element) => element.roomId == roomId);
      return chatsLengthList[index].chatLength;
    } else {
      return -1;
    }
  }
}
