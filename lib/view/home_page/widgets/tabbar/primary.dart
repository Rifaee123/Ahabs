import 'dart:developer';

import 'package:ahbas/data/chat/chat_service.dart';
import 'package:ahbas/data/services/hive/chat_length/chat_length_service.dart';
import 'package:ahbas/model/chat/primary_chatters/datum.dart';
import 'package:ahbas/model/chat/primary_chatters/primary_chatters.dart';
import 'package:ahbas/provider/chat/chat_provider.dart';
import 'package:ahbas/view/chat_page/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;

class PrimaryView extends StatelessWidget {
  const PrimaryView({
    super.key,
    required this.streamSocket,
  });
  final socketio.Socket streamSocket;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

      future: Provider.of<ChatProvider>(context,listen: false).getPrimaryChats(),
      builder: (context,snapshot) {
        return Consumer<ChatProvider>(builder: (context, provider, _) {
          if (provider.primrychatResponse.isLoading) {
            return const CircularProgressIndicator();

          }

          List<PrimaryChattersDTO> dataList = provider.primrychatResponse.chatList;
          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Provider.of<ChatProvider>(context, listen: false)

                    .getIndividualChats(
                        roomId: dataList[index].roomId );
                Provider.of<ChatProvider>(context, listen: false)
                    .clearAllMessages();
                Provider.of<ChatProvider>(context, listen: false).isReply(false);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(
                    streamSocket: streamSocket,
                    profilePic: dataList[index].profilepicture ,
                    userName: dataList[index].username ,
                    roomId: dataList[index].roomId ,
                    visitingUserId: dataList[index].id ,
                  ),

                ));
              },
              child: ListTile(
                trailing: SizedBox(
                  width: 90.w,
                  child: Row(
                    children: [
                      Text(latestChatTime(dataList[index].latestMsgTime),
                          style: GoogleFonts.poppins(
                              fontSize: 10.sp, color: Colors.grey)),
                      SizedBox(
                        width: 10.w,
                      ),
                      Consumer<ChatProvider>(builder: (context, provider, _) {
                        bool isOnline = false;
                        if (provider.onlineUserList.isNotEmpty) {
                          if (provider.onlineUserList.any((element) =>
                              element == dataList[index].id)) {
                            isOnline = true;
                          }
                        }
                        final numOfUnread = numberOfUnread(
                            dataList[index].messageCount,
                            dataList[index].roomId );
                        if (numOfUnread == 0 || numOfUnread < 1) {
                          return const SizedBox();
                        }
                        return CircleAvatar(
                          backgroundColor:
                              isOnline ? Colors.green : const Color(0xff449cc0),
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
                subtitle: Text(dataList[index].latestMessage ,
                    overflow: TextOverflow.ellipsis,
                    style:
                        GoogleFonts.poppins(fontSize: 13.sp, color: Colors.grey)),
                title: Text(

                  dataList[index].username ,

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
                          backgroundColor: const Color.fromARGB(255, 230, 229, 229),
                          radius: 25.r,
                          child: Image.asset(
                            'assets/images/icons8-person-96 2.png',
                            height: 30.h,
                            width: 30.w,
                          ),
                        ),
                      ),
                      Positioned(
                          right: 5.w,
                          bottom: -1.h,
                          child: Image.asset(
                            'assets/images/Group 26.png',
                            height: 22.h,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      }
    );
  }

  int numberOfUnread(int currentChatLength, String roomId) {
    final previousLength = ChatLengthService.instance.getChatListLength(roomId);

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
        return '$hour:${dateTime.minute}';
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
}
