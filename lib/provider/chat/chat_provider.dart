import 'dart:developer';

import 'package:ahbas/data/api_urls/api_urls.dart';
import 'package:ahbas/data/chat/chat_service.dart';

import 'package:ahbas/data/services/hive/chat_length/chat_length_service.dart';
import 'package:ahbas/data/services/jwt_converter/jwt_converter.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/data/services/socket_io/socket_io.dart';

import 'package:ahbas/model/chat/individual_chats/datum.dart';
import 'package:ahbas/model/chat/primary_chatters/datum.dart';


import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;

class ChatProvider extends ChangeNotifier {
  int numOfUnreadChats = 0;
  bool isCreatedChatRoom = false;
  bool isEmojiShowing = false;
  dynamic currentChatDay = 0;
  CreateChatResponse chatRoomResponse =
      CreateChatResponse(isError: false, isLoading: true, roomId: '');
  IndividualChatResponse chatResponse =
      IndividualChatResponse(chatList: [], isLoading: true, isError: false);
  PrimaryChattersResponse primrychatResponse =
      PrimaryChattersResponse(chatList: [], isLoading: true, isError: false);
  List<ChatDataDTO> chatList = [];
  late socketio.Socket initializedSocket;

  // List<String> chatUserIdList = [];
//  void getSocketIO(socketio.Socket socket) {
//     initializedSocket = socket;
//     notifyListeners();
//   }

  List<String> onlineUserList = [];
  bool isReplying = false;
  String replyId = '';
  Map<String, String> replyMessage = {};

  showEmoji(bool isShow) {
    isEmojiShowing = isShow;
    notifyListeners();
  }

  changeTheCurrentChatDay(dynamic day) {
    currentChatDay = day;
    notifyListeners();
  }

  clearAllMessages() {
    chatList.clear();
    notifyListeners();
  }

  getReplyId(String id) {
    replyId = id;
    notifyListeners();
  }

  replyToMessage(String message, String userName) {
    replyMessage = {'message': message, 'userName': userName};
    notifyListeners();
  }

  nothing() {
    notifyListeners();
  }

  isReply(bool reply) {
    isReplying = reply;
    notifyListeners();
  }

  Future createChatRoom({required String visitingUserId}) async {
    final result = await ChatService().createChatRoom(visitingUserId);
    chatRoomResponse = result.fold(
        (l) => CreateChatResponse(isError: true, isLoading: false, roomId: ''),
        (r) => CreateChatResponse(
            isError: false, isLoading: false, roomId: r!.id ?? ''));

    notifyListeners();
  }

  initializeChatList() {
    chatList = [];
    notifyListeners();
  }

  void connectSocketIO() async {
    final authToken = await StorageService.instance.readSecureData('AuthToken');
    socketio.Socket socket = socketio.io(
        kBaseUrl,
        socketio.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({'token': authToken})
            .setTimeout(10000)
            .build());
    socket.onConnect((data) => log('Connection Established'));
    socket.onConnectError((data) => log('Connection Failed$data,'));
    socket.onDisconnect((data) => log('DisConnected'));
    notifyListeners();
  }

  Future getIndividualChats({required String roomId}) async {
    final result = await ChatService().getIndividualChats(roomId);

    final authToken = await StorageService.instance.readSecureData('AuthToken');
    final currentUserId = convertTokenToId(authToken!);
    chatResponse = result.fold(
        (l) => IndividualChatResponse(
            chatList: [], isError: true, isLoading: false), (r) {
      final dtoList =
          convertChatDataToDTO(r.data ??= [], currentUserId, roomId);
      chatList = dtoList;

      return IndividualChatResponse(
          chatList: dtoList, isError: false, isLoading: false);
    });

    notifyListeners();
  }

  getPrimaryChats() async {
    final result = await ChatService().getPrimaryChats();
    final authToken = await StorageService.instance.readSecureData('AuthToken');
    final currentUserId = convertTokenToId(authToken!);
    primrychatResponse = result.fold(
        (l) => PrimaryChattersResponse(
            chatList: [], isError: true, isLoading: false), (r) {
      final dto = convertPrimaryChatDataToDTO(r.data ??= [], currentUserId);

      return PrimaryChattersResponse(
          chatList: dto['chatDTO'], isError: false, isLoading: false);
    });

    notifyListeners();
  }

  Future<void> sendMessage(ChatDTO chat, socketio.Socket socket) async {
    final result = await ChatService().sendMessage(
        message: chat.message, roomId: chat.roomid, replyId: chat.replyId);
    final sendedChat = result.fold((l) => null, (r) {
      return r;
    });
    if (sendedChat != null) {
      log('Afsin');
      log(sendedChat.replyId.toString());
      sendedChat.addTo(chat.toUserId);
      final sendingChat = sendedChat.toJson();
      addSingleChat(
          ChatDataDTO(
            id: sendedChat.id,
            replyId: sendedChat.replyId != null
                ? ReplyId(
                    message: sendedChat.replyId!.message ??= '',
                    replyId: sendedChat.replyId!.id ??= '')
                : null,
            isReply: sendedChat.replyId != null ? true : false,
            message: sendedChat.message ??= '',
            senderId: sendedChat.senderId ??= '',
            createdAt: sendedChat.createdAt!,
          ),
          sendedChat.roomId ??= '');

      SocketIoService.instance
          .sendMessage(sendingChat, socket, chat.replyMessage);
    } else {}
    notifyListeners();
  }

  getOnlineStatus(List<dynamic> allOnlineUsers) {
    List<String> usersList = [];
    for (var element in allOnlineUsers) {
      usersList.add(element['userId'].toString());
    }
    onlineUserList.clear();
    onlineUserList.addAll(usersList);

    notifyListeners();
  }

  Future deleteForMe(String messageId, String roomId) async {
    final result = await ChatService().deleteForMe(messageId: messageId);
    result.fold((l) => null, (r) {
      chatList.removeWhere((element) => element.id == messageId);
      // final getlength = ChatLengthService.instance.getChatListLength(roomId);
      // ChatLengthService.instance.addChatListLength(
      //     getlength != null ? getlength - 1 : 0,
      //     roomId,
      //     chatList.last.message,
      //     chatList.last.createdAt);
    });
    notifyListeners();
  }

  Future deleteForEveryone(String messageId, String roomId, socketio.Socket socket,String visitingUserId) async {
    final result = await ChatService().deleteForEveryOne(messageId: messageId);
  
    result.fold((l) => null, (r) {
      chatList.removeWhere((element) => element.id == messageId);
        SocketIoService.instance.deleteForEveryOneNotify(
            socket,
              messageId,
            roomId,
             visitingUserId,
            );

       
      // final getlength = ChatLengthService.instance.getChatListLength(roomId);
      // ChatLengthService.instance.addChatListLength(
      //     getlength != null ? getlength - 1 : 0,
      //     roomId,
      //     chatList.last.message,
      //     chatList.last.createdAt);
    });
    notifyListeners();
  }

  listenToDelete(String deleteMessageId, String roomId) {
    chatList.removeWhere((element) => element.id == deleteMessageId);
    final getlength = ChatLengthService.instance.getChatListLength(roomId);
    ChatLengthService.instance.addChatListLength(
        getlength != null ? getlength - 1 : 0,
        roomId,
        chatList.last.message,
        chatList.last.createdAt);

    notifyListeners();
  }

  Future clearChat(String roomId) async {
    final result = await ChatService().clearChat(roomId: roomId);
    result.fold((l) => null, (r) {
      chatList.clear();
    });
    final getlength = ChatLengthService.instance.getChatListLength(roomId);
    ChatLengthService.instance.addChatListLength(
        getlength != null ? getlength - chatList.length : 0,
        roomId,
        null,
        null);
    notifyListeners();
  }

  void addToPrimarylatest(String message, String roomId, DateTime createdAt) {
    final index = primrychatResponse.chatList
        .indexWhere((element) => element.roomId == roomId);
    if (primrychatResponse.chatList.isNotEmpty && index != -1) {
      primrychatResponse.chatList[index].latestMessage = message;
      primrychatResponse.chatList[index].latestMsgTime = createdAt;
      final msgCount = primrychatResponse.chatList[index].messageCount;
      primrychatResponse.chatList[index].messageCount = msgCount + 1;
    }
  }

  void addSingleChat(ChatDataDTO chat, String roomId) {
    chatList.add(chat);
    final getlength = ChatLengthService.instance.getChatListLength(roomId);
    addToPrimarylatest(chat.message, roomId, chat.createdAt);
    ChatLengthService.instance.addChatListLength(
        getlength != null ? getlength + 1 : 1,
        roomId,
        chat.message,
        chat.createdAt);
    notifyListeners();
  }

  void addListofChats(List<ChatDataDTO> chatlist) {
    chatList.addAll(chatlist);
    // notifyListeners();
  }
}

class PrimaryChattersResponse {
  final List<PrimaryChattersDTO> chatList;
  final bool isLoading;
  final bool isError;

  PrimaryChattersResponse(
      {required this.chatList, required this.isLoading, required this.isError});
}

class PrimaryChattersDTO {
  final String id;
  final String username;
  final String profilepicture;
  final String roomId;
  String latestMessage;
  DateTime latestMsgTime;
  final bool isDeletedLatestMsg;
  int messageCount;

  PrimaryChattersDTO({
    required this.messageCount,
    required this.id,
    required this.username,
    required this.profilepicture,
    required this.roomId,
    required this.latestMessage,
    required this.latestMsgTime,
    required this.isDeletedLatestMsg,
  });
}

class IndividualChatResponse {
  final List<ChatDataDTO> chatList;
  final bool isLoading;
  final bool isError;

  IndividualChatResponse(
      {required this.chatList, required this.isLoading, required this.isError});
}

class CreateChatResponse {
  final String roomId;
  final bool isLoading;
  final bool isError;
  CreateChatResponse(
      {required this.roomId, required this.isLoading, required this.isError});
}

class ChatDataDTO {
  final String? id;
  final String senderId;
  final String message;
  final String? roomId;
  final DateTime createdAt;
  final bool isReply;

  final ReplyId? replyId;

  ChatDataDTO(
      {this.replyId,
      this.id,
      this.isReply = false,
      required this.senderId,
      required this.message,
      this.roomId,
      required this.createdAt});
}

List<ChatDataDTO> convertChatDataToDTO(
    List<ChatData> chatDataList, String currentUserId, String roomId) {
  List<ChatDataDTO> chatDTOList = [];

  ChatLengthService.instance.addChatListLength(
      chatDataList.length,
      roomId,
      chatDataList.isEmpty ? null : chatDataList.last.message,
      chatDataList.isEmpty ? null : chatDataList.last.createdAt);

  for (var chat in chatDataList) {
    if (chat.deleteduser != null && chat.deleteduser!.contains(currentUserId)) {
      log('Time to Break');
      continue;
    }
    bool isReply = false;
    if (chat.replyId != null) {
      isReply = true;
    }
    chatDTOList.add(ChatDataDTO(
        isReply: isReply,
        replyId: chat.replyId != null
            ? ReplyId(
                message: chat.replyId!.message ??= '',
                replyId: chat.replyId!.id ??= '')
            : null,
        id: chat.id ??= '',
        senderId: chat.senderId ??= '',
        message: chat.message ??= '',
        roomId: chat.roomId ??= '',
        createdAt: chat.createdAt ??= DateTime.now()));
  }

  return chatDTOList;
}

Map<String, dynamic> convertPrimaryChatDataToDTO(
    List<Datum> chatDataList, String currentUserId) {
  List<PrimaryChattersDTO> chatDTOList = [];

  for (var chat in chatDataList) {
    bool isDeleted = false;

    if (chat.latestmessage!.deleteduser!.contains(currentUserId)) {
      isDeleted = true;
    }
    chatDTOList.add(PrimaryChattersDTO(
        messageCount: chat.messageCount ??= -1,
        latestMessage: chat.latestmessage!.message ??= '',
        latestMsgTime: chat.latestmessage!.createdAt!,
        isDeletedLatestMsg: isDeleted,
        id: chat.members![0].id ??= '',
        username: chat.members![0].username ??= '',
        profilepicture: chat.members![0].profilepicture ??= '',
        roomId: chat.latestmessage!.roomId ??= ''));
  }
  return {'chatDTO': chatDTOList};
}

class ReplyId {
  final String message;
  final String replyId;

  ReplyId({required this.message, required this.replyId});
}
