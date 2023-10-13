import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ValueNotifier<int> isTapped = ValueNotifier(0);
  TextEditingController chatcontroller = TextEditingController();
  double _containerWidth = 200.0;
  double _containerHeight = 40.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: ValueListenableBuilder(
              valueListenable: isTapped,
              builder: (context, value, child) {
                print('value $isTapped');
                if (value == 0) {
                  return Container(
                      child: Row(
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
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color(0xffece8e8)),
                        child: TextFormField(
                          controller: chatcontroller,
                          onTap: () {
                            print('Tapped');
                            setState(() {
                              isTapped.value = 1;
                              isTapped.value == 1
                                  ? _containerWidth = 500.0
                                  : _containerWidth = 200.0;
                            });
                          },
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {},
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
                                          ScrollController scrollController) {
                                        return Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GridView.builder(
                                                controller: scrollController,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisSpacing: 4,
                                                        mainAxisSpacing: 4,
                                                        crossAxisCount: 3),
                                                itemBuilder: (context, index) =>
                                                    Container(
                                                  height: 30,
                                                  width: 30,
                                                  color:
                                                      const Color(0xff000088),
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
                  ));
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
                          setState(() {
                            // Update the height of the container based on text length
                            _containerHeight = 40.0 + text.length / 2;
                            // You can adjust the factor (10.0 in this case) according to your preference
                          });
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
        body: Column(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pachukuttan",
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
            const Expanded(
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Today"),
                ),
                ChatBubble(message: "sugalle", isMe: true),
                ChatBubble(message: "ahda sugam", isMe: false),
                ChatBubble(message: "Nee Eviden Ippo?", isMe: false),
                ChatBubble(
                  message: "Njan Vtl Undada",
                  isMe: true,
                ),
                ChatBubble(
                  message: "Neeee Evida",
                  isMe: true,
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
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
                                    "9.45pm",
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
                            : Text("9.45pm",
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
