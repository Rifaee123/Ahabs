import 'dart:developer';

import 'package:ahbas/data/api_urls/api_urls.dart';
import 'package:ahbas/data/chat/chat_service.dart';
import 'package:ahbas/data/services/hive/chat_length_service.dart';
import 'package:ahbas/data/services/jwt_converter/jwt_converter.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/data/services/socket_io/socket_io.dart';
import 'package:ahbas/model/chat/individual_chats/datum.dart';
import 'package:ahbas/model/chat/primary_chatters/datum.dart';
import 'package:ahbas/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;

class ChatProvider extends ChangeNotifier {
  bool isCreatedChatRoom = false;
  IndividualChatResponse chatResponse =
      IndividualChatResponse(chatList: [], isLoading: true, isError: false);
  PrimaryChattersResponse primrychatResponse =
      PrimaryChattersResponse(chatList: [], isLoading: true, isError: false);
  List<ChatDataDTO> chatList = [];

  List<String> chatUserIdList = [];
  List<String> onlineUserList = [];
  bool isReplying = false;
  String replyId = '';
  Map<String, String> replyMessage = {};
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
    isCreatedChatRoom = result.fold((l) => false, (r) => true);

    notifyListeners();
  }

  void connectSocketIO() {
    socketio.Socket socket = socketio.io(
        kBaseUrl,
        socketio.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({
              'token':
                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTFmYWU3M2M0ODA5ZDQ1ZDI1ODA3OGYiLCJpYXQiOjE2OTc1MzgxMjQsImV4cCI6MTY5NzU0MTcyNH0.h_HOivrjiBSXjUd6ijrg6DP1mQQCqqhALJpzxS-WNy4'
            })
            .setTimeout(10000)
            .build());
    socket.onConnect((data) => log('Connection Established'));
    socket.onConnectError((data) => log('Connection Failed$data,'));
    socket.onDisconnect((data) => log('DisConnected'));
    notifyListeners();
  }

  Future getIndividualChats({required String roomId}) async {
    final result = await ChatService().getIndividualChats(roomId);

    final authToken = await StorageService.instance.readSecureData('authToken');
    final currentUserId = convertTokenToId(sampleToken);
    chatResponse = result.fold(
        (l) => IndividualChatResponse(
            chatList: [], isError: true, isLoading: false), (r) {
      final dtoList = convertChatDataToDTO(r.data ??= [], currentUserId);
      chatList = dtoList;
      ChatLengthService.instance.addChatListLength(chatList.length, roomId);
      return IndividualChatResponse(
          chatList: dtoList, isError: false, isLoading: false);
    });

    notifyListeners();
  }

  getPrimaryChats() async {
    final result = await ChatService().getPrimaryChats();
    final authToken = await StorageService.instance.readSecureData('authToken');
    final currentUserId = convertTokenToId(sampleToken);
    primrychatResponse = result.fold(
        (l) => PrimaryChattersResponse(
            chatList: [], isError: true, isLoading: false), (r) {
      final dto = convertPrimaryChatDataToDTO(r.data ??= [], currentUserId);
      chatUserIdList = dto['userList'];
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
      addSingleChat(ChatDataDTO(
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
      ),sendedChat.roomId??='');

      SocketIoService.instance
          .sendMessage(sendingChat, socket, chat.replyMessage);
    } else {}
    notifyListeners();
  }

  getOnlineStatus(List<String> allOnlineUsers) {
    for (var user in chatUserIdList) {
      if (allOnlineUsers.any((element) => element == user)) {
        onlineUserList.add(user);
      }
    }
    notifyListeners();
  }

  Future deleteForMe(String messageId, String roomId) async {
    final result = await ChatService().deleteForMe(messageId: messageId);
    result.fold((l) => null, (r) {
      chatList.removeWhere((element) => element.id == messageId);
      ChatLengthService.instance.addChatListLength(chatList.length, roomId);
    });
    notifyListeners();
  }

  Future deleteForEveryone(String messageId, String roomId) async {
    final result = await ChatService().deleteForEveryOne(messageId: messageId);
    result.fold((l) => null, (r) {
      chatList.removeWhere((element) => element.id == messageId);
      ChatLengthService.instance.addChatListLength(chatList.length, roomId);
    });
    notifyListeners();
  }

  Future clearChat(String roomId) async {
    final result = await ChatService().clearChat(roomId: roomId);
    result.fold((l) => null, (r) {
      chatList.clear();
    });
    notifyListeners();
  }

  void addSingleChat(ChatDataDTO chat, String roomId) {
    chatList.add(chat);
    ChatLengthService.instance.addChatListLength(chatList.length, roomId);
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
  final String latestMessage;
  final DateTime latestMsgTime;
  final bool isDeletedLatestMsg;

  PrimaryChattersDTO({
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
    List<ChatData> chatDataList, String currentUserId) {
  List<ChatDataDTO> chatDTOList = [];

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
  List<String> chattersUserIdList = [];

  for (var chat in chatDataList) {
    chattersUserIdList.add(chat.members![0].id ??= '');
    bool isDeleted = false;
    if (chat.latestmessage!.deleteduser!.contains(currentUserId)) {
      isDeleted = true;
    }
    chatDTOList.add(PrimaryChattersDTO(
        latestMessage: chat.latestmessage!.message ??= '',
        latestMsgTime: chat.latestmessage!.createdAt!,
        isDeletedLatestMsg: isDeleted,
        id: chat.members![0].id ??= '',
        username: chat.members![0].username ??= '',
        profilepicture: chat.members![0].profilepicture ??= '',
        roomId: chat.latestmessage!.roomId ??= ''));
  }
  return {'chatDTO': chatDTOList, 'userList': chattersUserIdList};
}

class ReplyId {
  final String message;
  final String replyId;

  ReplyId({required this.message, required this.replyId});
}
