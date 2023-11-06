import 'package:ahbas/data/services/hive/chat_length/models/chat_length.dart';
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

  addChatListLength(
      int chatLength, String roomId, String? latestMsg, DateTime? latestTime) {
    List<ChatLengthModel> chatsLengthList = [];
    chatsLengthList = chatLengthBox.values.toList();
    if (chatsLengthList.where((element) => element.roomId == roomId).isEmpty) {
      chatLengthBox.add(ChatLengthModel(
        roomId: roomId,
        chatLength: chatLength,
        latestCount: chatLength,
        latestMsg: latestMsg,
        latestTime: latestTime,
      ));
    } else {
      int index =
          chatsLengthList.indexWhere((element) => element.roomId == roomId);
      chatLengthBox.putAt(
          index,
          ChatLengthModel(
            roomId: roomId,
            chatLength: chatLength,
            latestCount: chatLength,
            latestMsg: latestMsg,
            latestTime: latestTime,
          ));
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

  int? getLatestCount(String roomId) {
    List<ChatLengthModel> chatsLengthList = [];
    chatsLengthList = chatLengthBox.values.toList();
    if (chatsLengthList
        .where((element) => element.roomId == roomId)
        .isNotEmpty) {
      int index =
          chatsLengthList.indexWhere((element) => element.roomId == roomId);
      return chatsLengthList[index].latestCount;
    } else {
      return -1;
    }
  }

  LatestMessageDTO getLatestMessage(String roomId) {
    List<ChatLengthModel> chatsLengthList = [];
    chatsLengthList = chatLengthBox.values.toList();
    if (chatsLengthList
        .where((element) => element.roomId == roomId)
        .isNotEmpty) {
      int index =
          chatsLengthList.indexWhere((element) => element.roomId == roomId);
      return LatestMessageDTO(
          latestMsg: chatsLengthList[index].latestMsg,
          latestTime: chatsLengthList[index].latestTime);
    } else {
      return LatestMessageDTO(latestMsg: null, latestTime: null);
    }
  }

  updateLatestMessage(LatestMessageDTO latestMsg, String roomId) {
    List<ChatLengthModel> chatsLengthList = [];
    chatsLengthList = chatLengthBox.values.toList();
    if (chatsLengthList
        .where((element) => element.roomId == roomId)
        .isNotEmpty) {
      int index =
          chatsLengthList.indexWhere((element) => element.roomId == roomId);
      chatLengthBox.putAt(
          index,
          ChatLengthModel(
              latestMsg: latestMsg.latestMsg,
              latestTime: latestMsg.latestTime,
              latestCount: chatsLengthList[index].latestCount,
              roomId: chatsLengthList[index].roomId,
              chatLength: chatsLengthList[index].chatLength));
    } 
  }
  updateLatestCount(int count, String roomId) {
    List<ChatLengthModel> chatsLengthList = [];
    chatsLengthList = chatLengthBox.values.toList();
    if (chatsLengthList
        .where((element) => element.roomId == roomId)
        .isNotEmpty) {
      int index =
          chatsLengthList.indexWhere((element) => element.roomId == roomId);
      chatLengthBox.putAt(
          index,
          ChatLengthModel(
              latestMsg: chatsLengthList[index].latestMsg,
              latestTime: chatsLengthList[index].latestTime,
              latestCount: count,
              roomId: chatsLengthList[index].roomId,
              chatLength: chatsLengthList[index].chatLength));
    } 
  }
}

class LatestMessageDTO {
  final DateTime? latestTime;
  final String? latestMsg;

  LatestMessageDTO({required this.latestTime, required this.latestMsg});
}
