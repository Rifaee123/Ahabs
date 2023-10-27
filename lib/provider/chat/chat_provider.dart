import 'dart:developer';

import 'package:ahbas/data/api_urls/api_urls.dart';
import 'package:ahbas/data/chat/chat_service.dart';
import 'package:ahbas/model/chat/individual_chats/datum.dart';
import 'package:ahbas/model/chat/primary_chatters/datum.dart';
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
    chatResponse = result.fold(
        (l) => IndividualChatResponse(
            chatList: [], isError: true, isLoading: false), (r) {
      final dtoList = convertChatDataToDTO(r.data ??= []);
      chatList = dtoList;
      return IndividualChatResponse(
          chatList: dtoList, isError: false, isLoading: false);
    });

    notifyListeners();
  }

  getPrimaryChats() async {
    final result = await ChatService().getPrimaryChats();
    primrychatResponse = result.fold(
        (l) => PrimaryChattersResponse(
            chatList: [], isError: true, isLoading: false), (r) {
      final dto = convertPrimaryChatDataToDTO(r.data ??= []);
      chatUserIdList = dto['userList'];
      return PrimaryChattersResponse(
          chatList: dto['chatDTO'], isError: false, isLoading: false);
    });

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

  void addSingleChat(ChatDataDTO chat) {
    chatList.add(chat);
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

  PrimaryChattersDTO(
      {required this.id,
      required this.username,
      required this.profilepicture,
      required this.roomId});
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

  ChatDataDTO(
      {this.id,
      required this.senderId,
      required this.message,
      this.roomId,
      required this.createdAt});
}

List<ChatDataDTO> convertChatDataToDTO(List<ChatData> chatDataList) {
  List<ChatDataDTO> chatDTOList = [];

  for (var chat in chatDataList) {
    chatDTOList.add(ChatDataDTO(
        id: chat.id ??= '',
        senderId: chat.senderId ??= '',
        message: chat.message ??= '',
        roomId: chat.roomId ??= '',
        createdAt: chat.createdAt ??= DateTime.now()));
  }
  return chatDTOList;
}

Map<String, dynamic> convertPrimaryChatDataToDTO(List<Datum> chatDataList) {
  List<PrimaryChattersDTO> chatDTOList = [];
  List<String> chattersUserIdList = [];

  for (var chat in chatDataList) {
    chattersUserIdList.add(chat.sendeduser!.id ??= '');
    chatDTOList.add(PrimaryChattersDTO(
        id: chat.sendeduser!.id ??= '',
        username: chat.sendeduser!.username ??= '',
        profilepicture: chat.sendeduser!.profilepicture ??= '',
        roomId: chat.roomId ??= ''));
  }
  return {'chatDTO': chatDTOList, 'userList': chattersUserIdList};
}
