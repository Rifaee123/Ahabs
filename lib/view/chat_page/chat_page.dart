import 'dart:developer';

import 'package:ahbas/data/services/jwt_converter/jwt_converter.dart';
import 'package:ahbas/data/services/socket_io/socket_io.dart';
import 'package:ahbas/provider/chat/chat_provider.dart';
import 'package:ahbas/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.visitingUserId,
      required this.roomId,
      required this.userName,
      required this.profilePic,
      required this.streamSocket});
  final String visitingUserId;
  final String roomId;
  final String userName;
  final String profilePic;
  final socketio.Socket streamSocket;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ValueNotifier<int> isTapped = ValueNotifier(0);
  TextEditingController chatcontroller = TextEditingController();
  double _containerWidth = 200.0;
  double _containerHeight = 40.0;
  StreamSocket streamingSocket = StreamSocket();
  List<ChatDataDTO> chatList = [];
  final currentUserId = convertTokenToId(sampleToken);
  late socketio.Socket socket;
  bool isReplying = false;

  final ScrollController scrollController = ScrollController();
  dynamic previousMsg = [];

  @override
  void initState() {
    // socket = socketio.io(
    //     'https://ahabs.cyenosure.in',
    //     socketio.OptionBuilder()
    //         .setTransports(['websocket'])
    //         .setQuery({'token': sampleToken})
    //         .setTimeout(10000)
    //         .build());

    // initstate(streamingSocket, socket,);
    // socket.on('chat-message', (message) {
    //   log('Where is hjk Message');
    //   log(message.toString());
    //   // setState(() {
    //   //   log('but');
    //   streamingSocket.addResponse(message);
    //   Provider.of<ChatProvider>(context,listen: false).addSingleChat(Datum(
    //     message: message['message'],
    //     senderId: message['senderId'],
    //     createdAt: DateTime.now(),
    //   ));
    //   // });
    // });

    //new

    SocketIoService.instance
        .listenMessage(streamingSocket, widget.streamSocket);
    super.initState();
  }

  @override
  void dispose() {
    log('dispose');
    // streamingSocket.dispose(streamingSocket);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(isReplying.toString());
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
            padding: EdgeInsets.only(left: 20.w, top: 600.h),
            child: ValueListenableBuilder(
              valueListenable: isTapped,
              builder: (context, value, child) {
                print('value $isTapped');
                if (value == 0) {
                  return Column(
                    children: [
                      isReplying == true
                          ? Container(
                            width: 500.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Column(
                                children: [
                                  Text('UserName'),
                                  Text('Part of the mesage')
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 34.h,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CircleAvatar(
                            radius: 17,
                            backgroundColor: const Color(0xff449cc0),
                            child: Image.asset(
                              'assets/images/more.png',
                              height: 17.h,
                              width: 17.w,
                            ),
                          ),
                          Container(
                            height: 35.h,
                            width: 200.w,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Color(0xffece8e8)),
                            child: TextFormField(
                              controller: chatcontroller,
                              onTap: () {
                                print('Tapped');
                                // setState(() {
                                isTapped.value = 1;
                                isTapped.value == 1
                                    ? _containerWidth = 500.0
                                    : _containerWidth = 200.0;
                                // });
                              },
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        log('sending...');
                                        // setState(() {
                                        Provider.of<ChatProvider>(context,
                                                listen: false)
                                            .addSingleChat(ChatDataDTO(
                                          message: chatcontroller.text,
                                          senderId: currentUserId,
                                          createdAt: DateTime.now(),
                                        ));
                                        // chatList.add(ChatDataDTO(
                                        //   message: chatcontroller.text,
                                        //   senderId: currentUserId,
                                        //   createdAt: DateTime.now(),
                                        // ));
                                        SocketIoService.instance.sendMessage(
                                            ChatDTO(
                                                toUserId: widget.visitingUserId,
                                                message: chatcontroller.text,
                                                roomid: widget.roomId),
                                            widget.streamSocket);

                                        // sendMessage(
                                        //     ChatDTO(
                                        //         toUserId: widget.visitingUserId,
                                        //         message: chatcontroller.text,
                                        //         roomid: widget.roomId),
                                        //     socket);

                                        scrollController.animateTo(
                                            scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                const Duration(milliseconds: 1),
                                            curve: Curves.slowMiddle);
                                        //       setState(() {
                                        //   isReplying == false;
                                        // });
                                        // });
                                      },
                                      icon: const Icon(Icons.send)),
                                  prefixIcon: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.emoji_emotions,
                                        color: Color.fromARGB(255, 93, 88, 88),
                                      )),
                                  border: InputBorder.none),
                            ),
                          ),
                          CircleAvatar(
                            radius: 17,
                            backgroundColor: const Color(0xff449cc0),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  enableDrag: true,
                                  isScrollControlled:
                                      true, // Allows the bottom sheet to take up the full screen
                                  builder: (BuildContext context) {
                                    return Stack(
                                      children: <Widget>[
                                        DraggableScrollableSheet(
                                          expand: false,

                                          initialChildSize:
                                              0.5, // Initial size of the bottom sheet
                                          minChildSize:
                                              0.25, // Minimum size of the bottom sheet
                                          maxChildSize:
                                              0.9, // Maximum size of the bottom sheet
                                          builder: (BuildContext context,
                                              ScrollController
                                                  scrollController) {
                                            return Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(15),
                                                            topRight:
                                                                Radius.circular(
                                                                    15))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GridView.builder(
                                                    controller:
                                                        scrollController,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisSpacing: 4,
                                                            mainAxisSpacing: 4,
                                                            crossAxisCount: 3),
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Container(
                                                      height: 30,
                                                      width: 30,
                                                      color: const Color(
                                                          0xff000088),
                                                    ),
                                                  ),
                                                ));
                                          },
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          child: Container(
                                            height: 70.h,
                                            width: 360.w,
                                            color: const Color(0xffbcddea),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  child: Image.asset(
                                                    "assets/images/Group 46.png",
                                                    height: 40.h,
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Image.asset(
                                                    "assets/images/Group 45.png",
                                                    height: 40.h,
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Image.asset(
                                                    "assets/images/Group 44.png",
                                                    height: 40.h,
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Image.asset(
                                                    "assets/images/Group 43.png",
                                                    height: 40.h,
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Image.asset(
                                                    "assets/images/Group 42.png",
                                                    height: 40.h,
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Image.asset(
                                                    "assets/images/Group 41.png",
                                                    height: 40.h,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Image.asset(
                                'assets/images/Upload.png',
                                height: 17.h,
                                width: 17.w,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 17,
                            backgroundColor: const Color(0xff449cc0),
                            child: Image.asset(
                              'assets/images/camara1.png',
                              height: 17.h,
                              width: 17.w,
                            ),
                          ),
                          CircleAvatar(
                            radius: 17,
                            backgroundColor: const Color(0xff449cc0),
                            child: Image.asset(
                              'assets/images/voice.png',
                              height: 17.h,
                              width: 17.w,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  if (value == 1) {
                    return AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      height: _containerHeight.h,
                      width: _containerWidth,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color(0xffece8e8)),
                      child: TextFormField(
                        autofocus: true,
                        onChanged: (text) {
                          // setState(() {
                          // Update the height of the container based on text length
                          _containerHeight = 40.0 + text.length / 2;
                          // You can adjust the factor (10.0 in this case) according to your preference
                          // });
                        },
                        onTapOutside: (event) {
                          isTapped.value = 0;
                        },
                        maxLines: null,
                        minLines: 5,
                        onEditingComplete: () {
                          isTapped.value = 0;
                        },
                        controller: chatcontroller,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {}, icon: const Icon(Icons.send)),
                            prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.emoji_emotions,
                                  color: Color.fromARGB(255, 93, 88, 88),
                                )),
                            border: InputBorder.none),
                      ),
                    );
                  } else {
                    if (value == 2) {
                      return Container(
                        width: 500,
                        height: 70,
                        color: Colors.blue,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                }
              },
            )),
        body: StreamBuilder(
            stream: streamingSocket.getResponse,
            builder: (context, snapshot) {
              log('heree');
              log(snapshot.data.toString());
              dynamic message;
              if (snapshot.data != null) {
                final currentMsg = snapshot.data;
                if (previousMsg == []) {
                  previousMsg = snapshot.data;
                  message = snapshot.data;
                } else {
                  if (currentMsg == previousMsg) {
                    // return const SizedBox();
                  } else {
                    message = snapshot.data;
                  }
                  previousMsg = currentMsg;
                }

                // log('Recalled ${message['message']}');
                if (message != null) {
                  chatList.add(ChatDataDTO(
                    message: message['message'],
                    senderId: message['senderId'],
                    createdAt: DateTime.parse(message['createdAt']),
                  ));
                }
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.slowMiddle);
                });
              }
              return Consumer<ChatProvider>(builder: (context, provider, _) {
                final response = provider.chatResponse;
                if (response.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (response.isError) {
                  return const Text('Error');
                }
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (scrollController.hasClients) {
                    scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 1),
                        curve: Curves.easeOut);
                  }
                });

                chatList = response.chatList;

                return Column(
                  children: [
                    Container(
                      height: 50.h,
                      color: const Color(0xff449cc0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                            child: SizedBox(
                              height: 50.h,
                              width: 62.w,
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: CircleAvatar(
                                      backgroundColor: const Color.fromARGB(
                                          255, 230, 229, 229),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.userName,
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 16.sp),
                              ),
                              const Text(
                                "online",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 208, 208, 208)),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.call,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 10.w,
                          ),
                          Image.asset(
                            "assets/images/bussiness.png",
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Image.asset(
                            "assets/images/Group 12.png",
                            height: 20.h,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SwipeTo(
                            rightSwipeWidget: const SizedBox(),
                            onRightSwipe: () {
                              log('isReplying');
                              setState(() {
                                isReplying = true;
                              });
                            },
                            child: ChatBubble(
                                dateTimeString:
                                    chatList[index].createdAt.toString(),
                                message: chatList[index].message,
                                isMe: chatList[index].senderId == currentUserId
                                    ? true
                                    : false),
                          );
                        },
                        itemCount: chatList.length,
                      ),
                    ),
                    SizedBox(
                      height: 55.h,
                    ),
                  ],
                );
                // });
              });
            }),
      ),
    );
  }
}
//ChatBubble(message: "sugalle", isMe: true),

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String dateTimeString;

  const ChatBubble(
      {super.key,
      required this.message,
      required this.isMe,
      required this.dateTimeString});

  @override
  Widget build(BuildContext context) {
    DateTime ustDateTime = DateTime.parse(dateTimeString);
    DateTime dateTime = ustDateTime.add(const Duration(hours: 5, minutes: 30));
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding:
              isMe ? EdgeInsets.only(right: 10.w) : EdgeInsets.only(left: 10.w),
          child: Stack(
            children: [
              isMe
                  ? Positioned(
                      right: 0,
                      top: 2.h,
                      child: Image.asset(
                        "assets/images/chatbubble send.png",
                        height: 20.h,
                      ))
                  : Positioned(
                      left: 0,
                      top: 2.h,
                      child: Image.asset(
                        "assets/images/chatbuble recive.png",
                        height: 20.h,
                      )),
              Positioned(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isMe
                          ? const Color(0xffbcddea)
                          : const Color(0xffececec),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          message,
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.sp),
                        ),
                        isMe
                            ? Row(
                                children: [
                                  Text(
                                    "${dateTime.hour}.${dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute}pm",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color.fromARGB(
                                            255, 134, 133, 133)),
                                  ),
                                  Image.asset(
                                    "assets/images/chatTick.png",
                                    height: 10.h,
                                  )
                                ],
                              )
                            : Text(
                                "${dateTime.hour}.${dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute}pm",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color.fromARGB(
                                        255, 134, 133, 133)))
                      ],
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
