import 'dart:developer';

import 'package:ahbas/controller/getx/chat_controller.dart';
import 'package:ahbas/data/services/hive/chat_length/chat_length_service.dart';
import 'package:ahbas/data/services/jwt_converter/jwt_converter.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';

import 'package:ahbas/data/services/socket_io/socket_io.dart';

import 'package:ahbas/provider/chat/chat_provider.dart';
import 'package:ahbas/view/chat_page/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;

class PrimaryView extends StatefulWidget {
  const PrimaryView({
    super.key,
    required this.streamSocket,
    required this.authToken,
  });
  final socketio.Socket streamSocket;
  final String authToken;

  @override
  State<PrimaryView> createState() => _PrimaryViewState();
}

class _PrimaryViewState extends State<PrimaryView> {
  final StreamSocket streamingSocket = StreamSocket();
  final ChatController unreadController = Get.put(ChatController());
  bool isTapped = false;
  dynamic previousMsg = [];
  @override
  void initState() {
    SocketIoService.instance
        .listenForPrimaryMessage(streamingSocket, widget.streamSocket);
    SocketIoService.instance.getOnlineStatus(widget.streamSocket, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            Provider.of<ChatProvider>(context, listen: false).getPrimaryChats(),
        builder: (context, snapshot) {
          int numOfUnread = 0;
          return StreamBuilder(
              stream: streamingSocket.getResponse,
              builder: (context, snapshot) {
                Map? latestMessage;
                if (snapshot.data != null) {
                  final currentMsg = snapshot.data;
                  if (previousMsg == []) {
                    previousMsg = snapshot.data;
                    latestMessage = snapshot.data;
                  } else {
                    if (currentMsg == previousMsg) {
                      // return const SizedBox();
                    } else {
                      latestMessage = snapshot.data;
                    }
                    previousMsg = currentMsg;
                  }
                }
                isTapped = false;
                return Consumer<ChatProvider>(builder: (context, provider, _) {
                  if (provider.primrychatResponse.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<PrimaryChattersDTO> dataList =
                      provider.primrychatResponse.chatList;
                  if (latestMessage != null) {
                    log(latestMessage['roomId'].toString());
                    final index = dataList.indexWhere((element) =>
                        element.roomId == latestMessage!['roomid']);

                    if (dataList.isNotEmpty && index != -1) {
                      dataList[index].latestMessage = latestMessage['message'];
                      dataList[index].latestMsgTime =
                          DateTime.parse(latestMessage['createdAt']);
                      final msgCount = dataList[index].messageCount;
                      dataList[index].messageCount = msgCount + 1;
                    } else if (index == -1 &&
                        latestMessage['to'] ==
                            convertTokenToId(widget.authToken)) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Provider.of<ChatProvider>(context, listen: false)
                            .getPrimaryChats();
                      });
                    }
                  }

                  dataList.sort(
                      (a, b) => a.latestMsgTime.compareTo(b.latestMsgTime));
                  dataList = dataList.reversed.toList();
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    unreadController.numOfUnreadChats.value =
                        findTotalUnreadChats(dataList);
                  });

                  if (dataList.isEmpty) {
                    return Center(
                      child: Text("Talk To SomeOne"),
                    );
                  }

                  return ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () async {
                        if (numOfUnread != 0 && numOfUnread > 0) {
                          final value = unreadController.numOfUnreadChats.value;
                          unreadController.numOfUnreadChats.value = value - 1;
                        }
                        Provider.of<ChatProvider>(context, listen: false)
                            .getIndividualChats(roomId: dataList[index].roomId);
                        Provider.of<ChatProvider>(context, listen: false)
                            .clearAllMessages();
                        Provider.of<ChatProvider>(context, listen: false)
                            .isReply(false);
                        isTapped = true;

                        await StorageService.instance
                            .readSecureData('AuthToken')
                            .then((token) =>
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    authToken: token!,
                                    streamSocket: widget.streamSocket,
                                    profilePic: dataList[index].profilepicture,
                                    userName: dataList[index].username,
                                    roomId: dataList[index].roomId,
                                    visitingUserId: dataList[index].id,
                                  ),
                                )));
                      },
                      child: ListTile(
                        trailing: SizedBox(
                          width: 90.w,
                          child: Row(
                            children: [
                              Text(
                                  latestChatTime(dataList[index].latestMsgTime),
                                  style: GoogleFonts.poppins(
                                      fontSize: 10.sp, color: Colors.grey)),
                              SizedBox(
                                width: 10.w,
                              ),
                              Consumer<ChatProvider>(
                                  builder: (context, provider, _) {
                                bool isOnline = false;
                                if (provider.onlineUserList.isNotEmpty) {
                                  if (provider.onlineUserList.any((element) =>
                                      element == dataList[index].id)) {
                                    isOnline = true;
                                  }
                                }

                                numOfUnread = numberOfUnread(
                                    dataList[index].messageCount,
                                    dataList[index].roomId);

                                if (numOfUnread == 0 ||
                                    numOfUnread < 1 ||
                                    isTapped == true) {
                                  return const SizedBox();
                                }

                                return CircleAvatar(
                                  backgroundColor: isOnline
                                      ? Colors.green
                                      : const Color(0xff449cc0),
                                  radius: 12.r,
                                  child: Center(
                                    child: Text(
                                      numOfUnread.toString(),
                                      style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: 12.sp),
                                    ),
                                  ),
                                );
                              })
                              // Container(
                              //     decoration: const BoxDecoration(
                              //         color: Color(0xff449cc0),
                              //         borderRadius: BorderRadius.all(Radius.circular(30))),
                              //     height: 18.h,
                              //     width: 20.w,
                              // child: Center(
                              //   child: Text(
                              //     "4",
                              //     style: GoogleFonts.poppins(
                              //         color: Colors.black, fontSize: 12.sp),
                              //   ),
                              // )),
                            ],
                          ),
                        ),
                        subtitle: Text(dataList[index].latestMessage,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 13.sp, color: Colors.grey)),
                        title: Text(
                          dataList[index].username,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 19.sp, fontWeight: FontWeight.w500),
                        ),
                        leading: SizedBox(
                          height: 50.h,
                          width: 62.w,
                          child: Stack(
                            children: [
                              Positioned(
                                child: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 230, 229, 229),
                                  radius: 25.r,
                                  child: Image.asset(
                                    'assets/images/icons8-person-96 2.png',
                                    height: 30.h,
                                    width: 30.w,
                                  ),
                                ),
                              ),
                              Consumer<ChatProvider>(
                                  builder: (context, provider, _) {
                                bool isOnline = false;
                                if (provider.onlineUserList.isNotEmpty) {
                                  if (provider.onlineUserList.any((element) =>
                                      element == dataList[index].id)) {
                                    isOnline = true;
                                  } else {
                                    isOnline = false;
                                  }
                                } else {
                                  isOnline = false;
                                }

                                return Positioned(
                                    right: 5.w,
                                    bottom: -1.h,
                                    child: Image.asset(
                                      isOnline
                                          ? 'assets/images/online.png'
                                          : 'assets/images/Group 26.png',
                                      height: 22.h,
                                    ));
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
              });
        });
  }

  int numberOfUnread(int currentChatLength, String roomId) {
    final previousLength = ChatLengthService.instance.getChatListLength(roomId);
    log('Yeah im working :$currentChatLength');

    if (previousLength == null || previousLength == -1) {
      return currentChatLength;
    } else if (previousLength == currentChatLength ||
        previousLength > currentChatLength) {
      return 0;
    } else {
      return currentChatLength - previousLength;
    }
  }

  String latestChatTime(DateTime? createdAt) {
    if (createdAt != null) {
      DateTime dateTime = createdAt.toLocal();
      int hour = dateTime.hour;

      if (hour > 12) {
        hour = hour - 12;
      }

      log(dateTime.toString());
      log(DateTime.now().toUtc().toString());
      Duration difference = DateTime.now().difference(dateTime);
      log(difference.inMinutes.toString());
      if (difference.inMinutes > 10) {
        if (dateTime.day != DateTime.now().day &&
            dateTime.month != DateTime.now().month &&
            dateTime.year != DateTime.now().year) {
          return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
        }

        return '$hour:${dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute}${dateTime.hour > 11 ? 'pm' : 'am'}';
      } else {
        if (difference.inMinutes == 0) {
          return 'just now';
        }
        return '${difference.inMinutes} Min ago';
      }
    } else {
      return '';
    }
  }

  int findTotalUnreadChats(List<PrimaryChattersDTO> dataList) {
    final list = dataList
        .where((element) =>
            element.messageCount >
            num.parse(
                ChatLengthService.instance.getChatListLength(element.roomId) ==
                        null
                    ? 0.toString()
                    : ChatLengthService.instance
                        .getChatListLength(element.roomId)
                        .toString()))
        .toList();
    return list.length;
  }
}
