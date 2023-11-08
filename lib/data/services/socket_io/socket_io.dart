import 'dart:async';
import 'dart:developer';

import 'package:ahbas/data/services/jwt_converter/jwt_converter.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/provider/chat/chat_provider.dart';
import 'package:flutter/material.dart';
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

    socket.onDisconnect((data) => log('DisConnected ${data.toString()}'));
    socket.on('error', (error) {
      // Handle socket error
      print('Socket error: $error');
    });

    return socket;
  }

  getOnlineStatus(socketio.Socket socket, BuildContext context) {
    List<String> onlineUserList = [];
    socket.on('get-users', (userList) {
      log('userList:${userList.toString()}');
      for (var user in userList) {
        onlineUserList.add(user['userId']);
      }
      Provider.of<ChatProvider>(context, listen: false)
          .getOnlineStatus(userList);
    });
  }

  sendMessage(
      Map chat, socketio.Socket socket, String? replyMsg, String authToken) {
    final userId = convertTokenToId(authToken);
    log('Hurray');
    socket.emit('chat-message', {
      'to': chat['to'],
      'message': chat['message'],
      'userId': userId,
      'roomid': chat['roomId'],
      'chatId': chat['_id'],
      'createdAt': chat['createdAt'],
      'replyId': chat['replyId'],
      'replyMessage': replyMsg,
    });
  }

  sendFollowNotification(socketio.Socket socket, String? receverid,
      String? senderid, String? userName, String? profilePicture) async {
    // final authToken = await StorageService.instance.readSecureData('AuthToken');
    // final newsocket = socketio.io(
    //     'https://ahabs.cyenosure.in',
    //     socketio.OptionBuilder()
    //         .setTransports(['websocket'])
    //         .setQuery({'token': authToken})
    //         .setTimeout(10000)
    //         .build());
    log('Happened1');
    try {
      socket.emit('send-notification', {
        'sender_id': senderid,
        'username': userName??='',
        'profilepicture': profilePicture,
        'receiver': receverid, // Receiver user ID
        'content': "started to following you.",
        'createdAt': DateTime.now().toString(),
        // Notification message
        // Add other notification data here as needed
      });
      log('Happened');
    } catch (e) {
      log('Error:${e.toString()}');
    }
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

  getFollowNotification(
    NotificationStream notificationStream,
    socketio.Socket socket,
  ) async {
    log('Where is Notification1');
    socket.on('receive-notification', (notification) {
      log('Where is Notification');
      log(notification.toString());
      notificationStream.addfollowResponse(notification);
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

sendMessage(ChatDTO chat, socketio.Socket socket, String authToken) {
  // Emit the message to the server using the socket
  final userId = convertTokenToId(authToken);
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

class NotificationStream {
  final StreamController<dynamic> socketfollowResponse =
      StreamController.broadcast();
  void Function(dynamic) get addfollowResponse => socketfollowResponse.sink.add;
  Stream<dynamic> get getfollowResponse => socketfollowResponse.stream;
}

// STEP1:  Stream setup
class StreamSocket {
  final StreamController<dynamic> _socketResponse = StreamController();

  void Function(dynamic) get addResponse => _socketResponse.sink.add;

  Stream<dynamic> get getResponse => _socketResponse.stream;
  void clear() {
    _socketResponse.sink.add('Clear');
  }

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
  final String? replyId;
  final String? replyMessage;

  ChatDTO(
      {this.replyId,
      required this.replyMessage,
      required this.toUserId,
      required this.message,
      required this.roomid});
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
