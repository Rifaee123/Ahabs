import 'dart:developer';


import 'package:ahbas/data/services/hive/chat_length/chat_length_service.dart';


import 'package:ahbas/controller/getx/follow_controller.dart';

import 'package:ahbas/data/services/jwt_converter/jwt_converter.dart';
import 'package:ahbas/data/services/socket_io/socket_io.dart';
import 'package:ahbas/provider/chat/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.visitingUserId,
      required this.roomId,
      required this.userName,
      required this.profilePic,
      required this.streamSocket,
      required this.authToken});
  final String visitingUserId;
  final String roomId;
  final String userName;
  final String profilePic;
  final socketio.Socket streamSocket;

  final String authToken;


  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FolloControlller followcontroller = Get.put(FolloControlller());
  ValueNotifier<int> isTapped = ValueNotifier(0);
  TextEditingController chatcontroller = TextEditingController();
  double _containerWidth = 200.0;
  double _containerHeight = 40.0;
  StreamSocket streamingSocket = StreamSocket();
  List<ChatDataDTO> chatList = [];
  bool emojiShowing = false;

  late String currentUserId;
  // late socketio.Socket socket;

  final ScrollController scrollController = ScrollController();
  var currentChatDay = 0;
  dynamic previousMsg = [];

  @override
  void initState() {
    currentUserId = convertTokenToId(widget.authToken!);

    log('Visiting');
    log(widget.roomId.toString());
    currentUserId = convertTokenToId(widget.authToken);
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
    log('Hereeeee');
    log(Provider.of<ChatProvider>(context, listen: false).chatList.toString());
    SocketIoService.instance
        .listenMessage(streamingSocket, widget.streamSocket);
    SocketIoService.instance
        .listenToDelete(widget.streamSocket, widget.roomId, context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton:
            Consumer<ChatProvider>(builder: (context, provider, _) {
          final isreplying = provider.isReplying;
          return Padding(

              padding: EdgeInsets.only(
                  left: 20.w, top: provider.isEmojiShowing ? 330.h : 560.h),

              child: ValueListenableBuilder(
                valueListenable: isTapped,
                builder: (context, value, child) {
                  print('value $isTapped');
                  if (value == 0) {
                    return Column(
                      children: [
                        isreplying == true
                            ? Container(
                                width: 500.w,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 15.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            provider.replyMessage[
                                                'userName'] ??= '',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Provider.of<ChatProvider>(
                                                        context,
                                                        listen: false)
                                                    .isReply(false);
                                              },
                                              icon: const Icon(Icons.close))
                                        ],
                                      ),
                                      Text(
                                          provider.replyMessage['message'] ??=
                                              '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp))
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 69.h,
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
                              height: 40.h,
                              width: 200.w,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: Color(0xffece8e8)),
                              child: TextFormField(
                                onTapOutside: (point) {},
                                controller: chatcontroller,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis),
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
                                          // Provider.of<ChatProvider>(context,
                                          //         listen: false)
                                          //     .addSingleChat(ChatDataDTO(
                                          //   replyId: provider.isReplying
                                          //       ? ReplyId(
                                          //           message:
                                          //               provider.replyMessage[
                                          //                   'message']!,
                                          //           replyId: provider.replyId)
                                          //       : null,
                                          //   isReply: provider.isReplying,
                                          //   message: chatcontroller.text,
                                          //   senderId: currentUserId,
                                          //   createdAt: DateTime.now(),
                                          // ));

                                          // chatList.add(ChatDataDTO(
                                          //   message: chatcontroller.text,
                                          //   senderId: currentUserId,
                                          //   createdAt: DateTime.now(),
                                          // ));
                                          if (provider.isReplying) {
                                            // SocketIoService.instance.sendMessage(
                                            //   ChatDTO(

                                            //       toUserId:
                                            //           widget.visitingUserId,
                                            //       message: chatcontroller.text,
                                            //       roomid: widget.roomId),
                                            //   widget.streamSocket);
                                          }
                                          // SocketIoService.instance.sendMessage(
                                          //     ChatDTO(
                                          //         toUserId:
                                          //             widget.visitingUserId,
                                          //         message: chatcontroller.text,
                                          //         roomid: widget.roomId),
                                          //     widget.streamSocket);
                                          Provider.of<ChatProvider>(context,
                                                  listen: false)
                                              .sendMessage(
                                                  ChatDTO(
                                                      replyMessage: provider
                                                              .isReplying
                                                          ? provider
                                                                  .replyMessage[
                                                              'message']
                                                          : null,
                                                      replyId:
                                                          provider.isReplying
                                                              ? provider.replyId
                                                              : null,
                                                      toUserId:
                                                          widget.visitingUserId,
                                                      message:
                                                          chatcontroller.text,
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
                                              duration: const Duration(
                                                  milliseconds: 1),
                                              curve: Curves.slowMiddle);
                                          Provider.of<ChatProvider>(context,
                                                  listen: false)
                                              .isReply(false);
                                          chatcontroller.clear();
                                        },
                                        icon: const Icon(Icons.send)),
                                    prefixIcon: IconButton(
                                        onPressed: () {
                                          provider.showEmoji(
                                              !provider.isEmojiShowing);
                                        },
                                        icon: const Icon(
                                          Icons.emoji_emotions,
                                          color:
                                              Color.fromARGB(255, 93, 88, 88),
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
                                                              topRight: Radius
                                                                  .circular(
                                                                      15))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GridView.builder(
                                                      controller:
                                                          scrollController,
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisSpacing:
                                                                  4,
                                                              mainAxisSpacing:
                                                                  4,
                                                              crossAxisCount:
                                                                  3),
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
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
                        Offstage(
                          offstage: !provider.isEmojiShowing,
                          child: SizedBox(
                              height: 250,
                              child: EmojiPicker(
                                textEditingController: chatcontroller,
                                onBackspacePressed: onBackspacePressed,
                                config: Config(
                                  columns: 7,
                                  // Issue: https://github.com/flutter/flutter/issues/28894
                                  emojiSizeMax: 32 *
                                      (foundation.defaultTargetPlatform ==
                                              TargetPlatform.iOS
                                          ? 1.30
                                          : 1.0),
                                  verticalSpacing: 0,
                                  horizontalSpacing: 0,
                                  gridPadding: EdgeInsets.zero,
                                  initCategory: Category.RECENT,
                                  bgColor: const Color(0xFFF2F2F2),
                                  indicatorColor: Colors.blue,
                                  iconColor: Colors.grey,
                                  iconColorSelected: Colors.blue,
                                  backspaceColor: Colors.blue,
                                  skinToneDialogBgColor: Colors.white,
                                  skinToneIndicatorColor: Colors.grey,
                                  enableSkinTones: true,
                                  recentTabBehavior: RecentTabBehavior.RECENT,
                                  recentsLimit: 28,
                                  replaceEmojiOnLimitExceed: false,
                                  noRecents: const Text(
                                    'No Recents',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black26),
                                    textAlign: TextAlign.center,
                                  ),
                                  loadingIndicator: const SizedBox.shrink(),
                                  tabIndicatorAnimDuration: kTabScrollDuration,
                                  categoryIcons: const CategoryIcons(),
                                  buttonMode: ButtonMode.MATERIAL,
                                  checkPlatformCompatibility: true,
                                ),
                              )),
                        ),
                      ],
                    );
                  } else {
                    if (value == 1) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 1),
                        height: isreplying == true
                            ? _containerHeight.h * 2
                            : _containerHeight.h,
                        width: _containerWidth,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color(0xffece8e8)),
                        child: Column(
                          children: [
                            isreplying == true
                                ? Container(
                                    width: 500.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0.5.h, horizontal: 15.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                provider.replyMessage[
                                                    'userName'] ??= '',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // IconButton(
                                              //     onPressed: () {
                                              //       log('Pressed');
                                              //       Provider.of<ChatProvider>(
                                              //               context,
                                              //               listen: false)
                                              //           .isReply(false);
                                              //     },
                                              //     icon: const Icon(Icons.close))
                                            ],
                                          ),
                                          Text(
                                              provider.replyMessage[
                                                  'message'] ??= '',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp))
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    // height: 60.h,
                                    ),
                            SizedBox(
                              height: _containerHeight.h,
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
                                  provider.showEmoji(false);
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
                                        onPressed: () {
                                          log('sending...');
                                          // setState(() {
                                          // Provider.of<ChatProvider>(context,
                                          //         listen: false)
                                          //     .addSingleChat(ChatDataDTO(
                                          //   replyId: provider.isReplying
                                          //       ? ReplyId(
                                          //           message:
                                          //               provider.replyMessage[
                                          //                   'message']!,
                                          //           replyId: provider.replyId)
                                          //       : null,
                                          //   isReply: provider.isReplying,
                                          //   message: chatcontroller.text,
                                          //   senderId: currentUserId,
                                          //   createdAt: DateTime.now(),
                                          // ));
                                          // chatList.add(ChatDataDTO(
                                          //   message: chatcontroller.text,
                                          //   senderId: currentUserId,
                                          //   createdAt: DateTime.now(),
                                          // ));
                                          // SocketIoService.instance.sendMessage(
                                          //     ChatDTO(
                                          //         toUserId:
                                          //             widget.visitingUserId,
                                          //         message: chatcontroller.text,
                                          //         roomid: widget.roomId),
                                          //     widget.streamSocket);
                                          Provider.of<ChatProvider>(context,
                                                  listen: false)
                                              .sendMessage(
                                                  ChatDTO(
                                                      replyMessage: provider
                                                              .isReplying
                                                          ? provider
                                                                  .replyMessage[
                                                              'message']
                                                          : null,
                                                      replyId:
                                                          provider.isReplying
                                                              ? provider.replyId
                                                              : null,
                                                      toUserId:
                                                          widget.visitingUserId,
                                                      message:
                                                          chatcontroller.text,
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
                                              duration: const Duration(
                                                  milliseconds: 1),
                                              curve: Curves.slowMiddle);
                                          Provider.of<ChatProvider>(context,
                                                  listen: false)
                                              .isReply(false);
                                          chatcontroller.clear();
                                        },
                                        icon: const Icon(Icons.send)),
                                    prefixIcon: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.emoji_emotions,
                                          color:
                                              Color.fromARGB(255, 93, 88, 88),
                                        )),
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
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
              ));
        }),
        body: StreamBuilder(
            stream: streamingSocket.getResponse,
            builder: (context, snapshot) {
              log(snapshot.data.toString());
              if (snapshot.data == 'Clear') {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
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
                  log('Hiii');
                  log(message.toString());
                  log(message['chatId'].toString());
                  chatList.add(ChatDataDTO(
                    message: message['message'],
                    senderId: message['userId'],
                    createdAt: DateTime.parse(message['createdAt']),
                    isReply: message['replyId'] != null ? true : false,
                    replyId: message['replyId'] != null
                        ? ReplyId(
                            message: message['replyId']['message'],
                            replyId: message['replyId']['_id'])
                        : null,
                    id: message['chatId'],
                  ));
                  Provider.of<ChatProvider>(context).addToPrimarylatest(
                      message['message'],
                      widget.roomId,
                      DateTime.parse(message['createdAt']));
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

                return GestureDetector(
                  onTap: () {
                    provider.showEmoji(false);
                  },
                  child: Column(
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
                                    Consumer<ChatProvider>(
                                        builder: (context, provider, _) {
                                      bool isOnline = false;
                                      if (provider.onlineUserList.isNotEmpty) {
                                        if (provider.onlineUserList.any(
                                            (element) =>
                                                element ==
                                                widget.visitingUserId)) {
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  child: Text(
                                    widget.userName,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 16.sp),
                                  ),
                                ),
                                Consumer<ChatProvider>(
                                    builder: (context, provider, _) {
                                  bool isOnline = false;
                                  if (provider.onlineUserList.isNotEmpty) {
                                    if (provider.onlineUserList.any((element) =>
                                        element == widget.visitingUserId)) {
                                      isOnline = true;
                                    } else {
                                      isOnline = false;
                                    }
                                  } else {
                                    isOnline = false;
                                  }
                                  return Text(
                                    isOnline ? "online" : "offline",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 208, 208, 208)),
                                  );
                                })
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
                            InkWell(
                              onTap: () {
                                Provider.of<ChatProvider>(context,
                                        listen: false)
                                    .clearChat(widget.roomId);
                              },
                              child: Image.asset(
                                "assets/images/bussiness.png",
                                height: 20.h,
                              ),
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
                        child: ListView(
                          controller: scrollController,
                          children: List.generate(
                            chatList.length,
                            (index) {
                              log('currenDayListView');
                              String senderId = '';
                              if (chatList[index].isReply) {
                                final replyedToChat = chatList
                                    .where((element) =>
                                        element.id ==
                                        chatList[index].replyId!.replyId)
                                    .toList();
                                if (replyedToChat.isNotEmpty) {
                                  senderId = replyedToChat[0].senderId;
                                } else {
                                  senderId = 'Deleted';
                                }
                              }
                              GlobalKey buttonKey = GlobalKey();
                              final dateTime = chatList[index]
                                  .createdAt
                                  .add(const Duration(hours: 5, minutes: 30));
                              if (index == 0) {
                                currentChatDay = dateTime.day;
                              }
                              return Column(
                                children: [
                                  chatDay(index, currentChatDay, dateTime),
                                  InkWell(
                                    key: buttonKey,
                                    onTap: () {
                                      provider.showEmoji(false);
                                    },
                                    onLongPress: () {
                                      showDeleteMenu(
                                          buttonKey,
                                          chatList[index].id!,
                                          chatList[index].senderId ==
                                                  currentUserId
                                              ? true
                                              : false);
                                    },
                                    child: SwipeTo(
                                      rightSwipeWidget: const SizedBox(),
                                      onRightSwipe: () {
                                        log('currenDayisReplying');
                                        Provider.of<ChatProvider>(context,
                                                listen: false)
                                            .replyToMessage(
                                                chatList[index].message,
                                                chatList[index].senderId ==
                                                        currentUserId
                                                    ? "You"
                                                    : widget.userName);
                                        Provider.of<ChatProvider>(context,
                                                listen: false)
                                            .getReplyId(chatList[index].id!);

                                        Provider.of<ChatProvider>(context,
                                                listen: false)
                                            .isReply(true);
                                      },
                                      child: Column(
                                        children: [
                                          ChatBubble(
                                              isReply: chatList[index].isReply,
                                              replyMessage: chatList[index]
                                                      .isReply
                                                  ? {
                                                      'currentUserId':
                                                          currentUserId,
                                                      'userName':
                                                          widget.userName,
                                                      'message': chatList[index]
                                                          .replyId!
                                                          .message,
                                                      'replyUserId': senderId
                                                    }
                                                  : {},
                                              dateTimeString: chatList[index]
                                                  .createdAt
                                                  .toString(),
                                              message: chatList[index].message,
                                              isMe: chatList[index].senderId ==
                                                      currentUserId
                                                  ? true
                                                  : false),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55.h,
                      ),
                      SizedBox(
                        height: provider.isReplying ? 65.h : 0.0,
                      ),
                    ],
                  ),
                );
                // });
              });
            }),
      ),
    );
  }

  void showDeleteMenu(GlobalKey buttonKey, String messageId, bool isMe) {
    final RenderBox renderBox =
        buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset buttonPosition = renderBox.localToGlobal(Offset.zero);
    final double buttonWidth = renderBox.size.width;
    final double buttonHeight = renderBox.size.height;

    const double menuWidth = 150.0; // Set the desired menu width
    const double menuHeight = 100.0; // Set the desired menu height

    // Calculate the position for the menu
    final double x = buttonPosition.dx + buttonWidth - menuWidth;
    final double y = buttonPosition.dy + buttonHeight;

    // final Offset offset = renderBox.localToGlobal(Offset.zero);
    showMenu(
        color: Colors.red[400],
        context: context,
        position: RelativeRect.fromLTRB(
          isMe ? x : 0,
          y,
          x + menuWidth,
          y + menuHeight,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        items: [
          buildPopupMenuItem('Delete for me', () {
            Provider.of<ChatProvider>(context, listen: false)
                .deleteForMe(messageId, widget.roomId);
            Navigator.pop(context);
          }, false, context),
          buildPopupMenuItem('Delete for everyone', () {
            Provider.of<ChatProvider>(context, listen: false)
                .deleteForEveryone(messageId, widget.roomId);
            SocketIoService.instance.deleteForEveryOneNotify(
              widget.streamSocket,
              messageId,
              widget.roomId,
              widget.visitingUserId,
            );
            Navigator.pop(context);
          }, !isMe, context),
        ]);
  }

  Widget chatDay(int index, int currenChatDay, DateTime dateTime) {
    if (index == 0 || currenChatDay != dateTime.day) {
      log('currenDay${currenChatDay.toString()}');
      currentChatDay = dateTime.day;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            const Expanded(
                child: Divider(
              color: Colors.black,
              thickness: .2,
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    DateTime.now().day == dateTime.day
                        ? 'Today'
                        : '${dateTime.day}/${dateTime.month}',
                    style: const TextStyle(fontSize: 11),
                  )),
            ),
            const Expanded(
                child: Divider(
              thickness: .2,
              color: Colors.black,
            )),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  onBackspacePressed() {
    chatcontroller
      ..text = chatcontroller.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: chatcontroller.text.length));
  }
}

PopupMenuItem buildPopupMenuItem(
    String title, Function() onTap, bool isForme, BuildContext context) {
  return PopupMenuItem(
    child: isForme
        ? InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ))
        : InkWell(
            onTap: onTap,
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            )),
  );
}
//ChatBubble(message: "sugalle", isMe: true),

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String dateTimeString;
  final bool isReply;
  final Map<String, String> replyMessage;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.dateTimeString,
    required this.isReply,
    required this.replyMessage,
  });

  @override
  Widget build(BuildContext context) {
    log(replyMessage['currentUserId'].toString());
    log(replyMessage.toString());

    DateTime ustDateTime = DateTime.parse(dateTimeString);
    DateTime dateTime = ustDateTime.add(const Duration(hours: 5, minutes: 30));
    int hour = dateTime.hour;

    if (hour > 12) {
      hour = hour - 12;
    }
    log('hour$hour');
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                        isReply
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                margin: const EdgeInsets.only(bottom: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      replyMessage['replyUserId'] == 'Deleted'
                                          ? ''
                                          : replyMessage['replyUserId'] ==
                                                  replyMessage['currentUserId']
                                              ? 'You'
                                              : replyMessage['userName'] ??= '',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        replyMessage['replyUserId'] == 'Deleted'
                                            ? 'Message was deleted'
                                            : replyMessage['message'] ??= '',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp))
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          width: widthOfText(message.length, 1.w),
                          child: Text(
                            message,
                            maxLines: null,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        isMe
                            ? Row(
                                children: [
                                  Text(
                                    "$hour:${dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute}${dateTime.hour > 11 ? 'pm' : 'am'}",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color.fromRGBO(
                                            134, 133, 133, 1)),
                                  ),
                                  Image.asset(
                                    "assets/images/chatTick.png",
                                    height: 10.h,
                                  )
                                ],
                              )
                            : Text(
                                "$hour:${dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute}${dateTime.hour > 11 ? 'pm' : 'am'}",
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

  double widthOfText(int length, double widthOf1) {
    if (length <= 5) {
      return 50 * widthOf1;
    } else if (length <= 10) {
      return 100 * widthOf1;
    } else if (length <= 15) {
      return 150 * widthOf1;
    } else if (length <= 20) {
      return 200 * widthOf1;
    } else {
      return (300 * widthOf1);
    }
  }
}
