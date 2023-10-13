import 'package:ahbas/view/chat_page/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
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
                    padding: const EdgeInsets.all(8.0),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kvk Chandha",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 18.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 90.w,
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

// class MyBottomSheetScreen extends StatelessWidget {
//   void _showBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled:
//           true, // Allows the bottom sheet to take up the full screen
//       builder: (BuildContext context) {
//         return Stack(
//           children: <Widget>[
//             DraggableScrollableSheet(
//               expand: false,
//               initialChildSize: 0.5, // Initial size of the bottom sheet
//               minChildSize: 0.25, // Minimum size of the bottom sheet
//               maxChildSize: 0.9, // Maximum size of the bottom sheet
//               builder:
//                   (BuildContext context, ScrollController scrollController) {
//                 return Container(
//                   color: Colors.white,
//                   child: ListView.builder(
//                     controller: scrollController,
//                     itemCount: 50, // Replace with your content
//                     itemBuilder: (BuildContext context, int index) {
//                       return ListTile(
//                         title: Text('Item $index'),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//             Positioned(
//               bottom: 0,
//               child: Container(
//                 height: 70,
//                 width: 400,
//                 color: Colors.amber,
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Navigation Bar Above Bottom Sheet'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             _showBottomSheet(context);
//           },
//           child: Text('Show Bottom Sheet'),
//         ),
//       ),
//     );
//   }
// }
