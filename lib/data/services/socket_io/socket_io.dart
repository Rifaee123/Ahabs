import 'dart:async';
import 'dart:developer';

import 'package:ahbas/controller/getx/follow_controller.dart';
import 'package:ahbas/data/services/jwt_converter/jwt_converter.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/provider/chat/chat_provider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;

class SocketIoService {
  // creating a singleton
  SocketIoService.internal();
  static SocketIoService instance = SocketIoService.internal();
  SocketIoService factory() {
    return instance;
  }

///////////////////////////////////////////
  late socketio.Socket socket;

  socketio.Socket initializeSocket(String authToken) {
    socket = socketio.io(
        'https://ahabs.cyenosure.in',
        socketio.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({'token': authToken})
            .setTimeout(10000)
            .build());
    socket.connect();
    final userId = convertTokenToId(authToken);
    socket.onConnect((data) {
      log('Connection Established');
      socket.emit('new-user-add', userId);
    });

    socket.onConnectError((data) => log('Connection Failed$data,'));

    socket.onDisconnect((data) => log('DisConnected'));

    return socket;
  }

  getOnlineStatus(socketio.Socket socket, BuildContext context) {
    List<String> onlineUserList = [];
    socket.on('get-users', (userList) {
      for (var user in userList) {
        onlineUserList.add(user['userId']);
      }
      Provider.of<ChatProvider>(context, listen: false)
          .getOnlineStatus(userList);
    });
  }

  sendMessage(ChatDTO chat, socketio.Socket socket) async {
    final authToken = await StorageService.instance.readSecureData('AuthToken');
    final userId = convertTokenToId(authToken!);
    socket.emit('chat-message', {
      'to': chat.toUserId,
      'message': chat.message,
      'userId': userId,
      'roomid': chat.roomid,
    });
  }

  listenMessage(
    StreamSocket streamingSocket,
    socketio.Socket socket,
  ) {
    socket.on('chat-message', (message) {
      log('Where is my Message');

      streamingSocket.addResponse(message);
    });
  }
}

const String userName = '';
// late socketio.Socket socket;

//This below code should be in initState.
initstate(
  StreamSocket streamingSocket,
  socketio.Socket socket,
) {
  connectSocket(streamingSocket, socket);
}

connectSocket(
  StreamSocket streamingSocket,
  socketio.Socket socket,
) {
  socket.connect();

  socket.onConnect((data) {
    log(data.toString());
    log('Connection Established');
    try {
      socket.on('chat-message', (message) {
        log('Where is thy Message');
        log(message.toString());
        // Provider.of<ChatProvider>(context,listen: false).addSingleChat(Datum(
        //   message: message['message'],
        //   senderId: message['senderId'],
        // ));
        // streamingSocket.addResponse(message);
      });
      log('Connection Established2');
    } catch (e) {
      log(e.toString());
    }
    log('Connection Established3');
  });

  log('okay');

  socket.onConnectError((data) => log('Connection Failed$data,'));
  log('okay1');
  socket.onDisconnect((data) => log('DisConnected'));
}

sendMessage(ChatDTO chat, socketio.Socket socket) async {
  FolloControlller controlller = Get.put(FolloControlller());
  // Emit the message to the server using the socket
  final authToken = await StorageService.instance.readSecureData('AuthToken');
  final userId = convertTokenToId(authToken!);
  socket.emit('chat-message', {
    'to': chat.toUserId,
    'message': chat.message,
    'userId': userId,
    'roomid': chat.roomid,
  });
}

listenMessage(StreamSocket streamingSocket, socketio.Socket socket,
    StreamController streamController) {
  log('listenMessage');
  socket.on('chat-message', (message) {
    log('Where is my Message');
    log(message.toString());
    streamController.sink.add(message);
    streamingSocket.addResponse(message);
  });

  // socket.on('chat-message', (message) => streamingSocket.addResponse(message));
}

// STEP1:  Stream setup
class StreamSocket {
  final StreamController<dynamic> _socketResponse = StreamController();

  void Function(dynamic) get addResponse => _socketResponse.sink.add;

  Stream<dynamic> get getResponse => _socketResponse.stream;

  void dispose(StreamSocket socket) {
    socket._socketResponse.close();
  }
}

// StreamSocket streamSocket = StreamSocket();

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void connectAndListen(socketio.Socket socket) {
  //When an event recieved from server, data is added to the stream
  // socket.on('event', (data) => );
  socket.onDisconnect((_) => print('disconnect'));
}

//Step3: Build widgets with streambuilder

class ChatDTO {
  final String toUserId;
  final String message;

  final String roomid;

  ChatDTO(
      {required this.toUserId, required this.message, required this.roomid});
}

Stream<dynamic> createChatMessageStream(socketio.Socket socket) {
  // Create a StreamController to handle the 'chat-message' events
  final chatMessageController = StreamController<dynamic>();
  log('Chatsream');
  // Set up the Socket.IO listener
  socket.on('chat-message', (message) {
    chatMessageController.sink
        .add(message); // Send the received message to the stream
  });

  // Return the stream from the StreamController
  return chatMessageController.stream;
}
