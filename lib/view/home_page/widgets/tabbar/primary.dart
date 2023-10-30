import 'package:ahbas/data/chat/chat_service.dart';
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
        future: ChatService().getPrimaryChats(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Text('Null');
          }
          PrimaryChatters? data;
          data = snapshot.data!.fold((l) => null, (r) => r);
          if (data == null) {
            return const Text('Null');
          }
          List<Datum> dataList = data.data!;
          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Provider.of<ChatProvider>(context, listen: false)
                    .getIndividualChats(roomId: dataList[index].roomId ??= '');

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(
                    streamSocket: streamSocket,
                    profilePic: dataList[index].sendeduser!.profilepicture ??=
                        '',
                    userName: dataList[index].sendeduser!.username ??= '',
                    roomId: dataList[index].roomId ??= '',
                    visitingUserId: dataList[index].sendeduser!.id ??= '',
                  ),
                ));
              },
              child: ListTile(
                trailing: SizedBox(
                  width: 90.w,
                  child: Row(
                    children: [
                      Text("2 Min ago",
                          style: GoogleFonts.poppins(
                              fontSize: 10.sp, color: Colors.grey)),
                      SizedBox(
                        width: 10.w,
                      ),
                      Consumer<ChatProvider>(builder: (context, provider, _) {
                        bool isOnline = false;
                        if (provider.onlineUserList.isNotEmpty) {
                          if (provider.onlineUserList.any((element) =>
                              element == dataList[index].sendeduser!.id)) {
                            isOnline = true;
                          }
                        }
                        return CircleAvatar(
                          backgroundColor:isOnline?Colors.green: const Color(0xff449cc0),
                          radius: 12.r,
                          child: Center(
                            child: Text(
                              "4",
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
                subtitle: Text("How are You Today ?",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 13.sp, color: Colors.grey)),
                title: Text(
                  dataList[index].sendeduser!.username ??= '',
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
}
