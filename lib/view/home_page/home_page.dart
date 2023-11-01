import 'dart:developer';

import 'package:ahbas/controller/getx/auth_controller.dart';
import 'package:ahbas/controller/getx/tabbar_controller.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';

import 'package:ahbas/data/services/socket_io/socket_io.dart';
import 'package:ahbas/provider/profile/current_user_provider.dart';
import 'package:ahbas/provider/search/search_provider.dart';
import 'package:ahbas/view/auth_page/auth_page.dart';

import 'package:ahbas/view/home_page/widgets/tabbar/calls.dart';
import 'package:ahbas/view/home_page/widgets/tabbar/group.dart';
import 'package:ahbas/view/home_page/widgets/tabbar/primary.dart';
import 'package:ahbas/view/home_page/widgets/tabbar/status.dart';
import 'package:ahbas/view/profile_page/profile-page.dart';
import 'package:ahbas/view/search_page/search_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:socket_io_client/socket_io_client.dart' as socketio;

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.authorizationToken});
  final String authorizationToken;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isprimary = false;
  bool isgroup = false;
  late socketio.Socket streamSocket;


   Authcontrolller authcontrolller = Get.put(Authcontrolller());
    final TabBarController controller = Get.put(TabBarController());
  
   

   @override
    void initState() {
      // TODO: implement initState

     
       streamSocket = SocketIoService.instance.initializeSocket(widget.authorizationToken );
      super.initState();
    }
 
  @override
  Widget build(BuildContext context) {
   
   

    final token = fetchData();

    log(token.toString());
    TabController tabcontroller =
        TabController(length: 5, initialIndex: 3, vsync: this);
    TabController calltabcontroller =
        TabController(length: 3, initialIndex: 0, vsync: this);
    TabController statustabcontroller =
        TabController(length: 3, initialIndex: 0, vsync: this);
    return Scaffold(
      body: SafeArea(
          child: Obx(
        () => Column(
          children: [
            Container(
              color: const Color(0xff449cc0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 10.h, top: 12.h, left: 31.w, right: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ));
                          },
                          child: Image.asset(
                            "assets/images/more1.png",
                            height: 14.h,
                          ),
                        ),
                        Text(
                          "Ahabs",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 20.sp),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/🦆 icon _notification_.png",
                              height: 15.h,
                            ),
                            SizedBox(
                              width: 26.w,
                            ),
                            InkWell(
                              onTap: () async {
                                authcontrolller.isRegister.value = false;
                                await StorageService.instance
                                    .deleteAllSecureData();
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => AuthPage(),
                                ));
                              },
                              child: Image.asset(
                                "assets/images/🦆 icon _add_.png",
                                height: 15.h,
                              ),
                            ),
                            SizedBox(
                              width: 26.w,
                            ),
                            InkWell(
                              onTap: () {
                                Provider.of<CurrentUserProvider>(context,
                                        listen: false)
                                    .getCurrentUser();
                                Provider.of<SearchPrvider>(context,
                                        listen: false)
                                    .getAllUsers();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SearchPage(),
                                ));
                              },
                              child: Image.asset(
                                "assets/images/Group 12.png",
                                height: 15.h,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    // color: const Color(0xff449cc0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.updatePage(0);
                                },
                                child: ImageIcon(
                                    size: 20,
                                    color: controller.currentindex.value == 0
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            198, 216, 216, 216),
                                    const AssetImage(
                                      'assets/images/bussiness.png',
                                    )),
                              ),
                              InkWell(
                                  onTap: () {
                                    controller.updatePage(1);
                                  },
                                  child: ImageIcon(
                                      size: 20,
                                      color: controller.currentindex.value == 1
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              198, 216, 216, 216),
                                      const AssetImage(
                                        'assets/images/calls.png',
                                      ))),
                              InkWell(
                                onTap: () {
                                  controller.updatePage(2);
                                },
                                child: ImageIcon(
                                    size: 18,
                                    color: controller.currentindex.value == 2
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            198, 216, 216, 216),
                                    const AssetImage(
                                      'assets/images/status.png',
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.updatePage(3);
                                },
                                child: Row(children: [
                                  ImageIcon(
                                      size: 20,
                                      color: controller.currentindex.value == 3
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              198, 216, 216, 216),
                                      const AssetImage(
                                        'assets/images/Primary.png',
                                      )),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Stack(children: [
                                    Positioned(
                                      child: ImageIcon(
                                          color:
                                              controller.currentindex.value == 3
                                                  ? Colors.white
                                                  : const Color.fromARGB(
                                                      198, 216, 216, 216),
                                          size: 16.h,
                                          const AssetImage(
                                              "assets/images/Ellipse 42.png")),
                                    ),
                                    Positioned(
                                      top: 2.h,
                                      left: 6.w,
                                      child: Text(
                                        "4",
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xff449cc0),
                                            fontSize: 10.sp),
                                      ),
                                    )
                                  ])
                                ]),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.updatePage(4);
                                },
                                child: Row(children: [
                                  ImageIcon(
                                      size: 20,
                                      color: controller.currentindex.value == 4
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              198, 216, 216, 216),
                                      const AssetImage(
                                        'assets/images/group.png',
                                      )),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Stack(children: [
                                    Positioned(
                                      child: ImageIcon(
                                          color:
                                              controller.currentindex.value == 4
                                                  ? Colors.white
                                                  : const Color.fromARGB(
                                                      198, 216, 216, 216),
                                          size: 16.h,
                                          const AssetImage(
                                              "assets/images/Ellipse 42.png")),
                                    ),
                                    Positioned(
                                      top: 2.h,
                                      left: 6.w,
                                      child: Text(
                                        "4",
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xff449cc0),
                                            fontSize: 10.sp),
                                      ),
                                    )
                                  ])
                                ]),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 2.h,
                              width: 70.w,
                              color: controller.currentindex.value == 0
                                  ? Colors.white
                                  : Color.fromARGB(0, 216, 216, 216),
                            ),
                            Container(
                              height: 2.h,
                              width: 55.w,
                              color: controller.currentindex.value == 1
                                  ? Colors.white
                                  : Color.fromARGB(0, 216, 216, 216),
                            ),
                            Container(
                              height: 2.h,
                              width: 50.w,
                              color: controller.currentindex.value == 2
                                  ? Colors.white
                                  : Color.fromARGB(0, 216, 216, 216),
                            ),
                            Container(
                              height: 2.h,
                              width: 75.w,
                              color: controller.currentindex.value == 3
                                  ? Colors.white
                                  : Color.fromARGB(0, 216, 216, 216),
                            ),
                            Container(
                              height: 2.h,
                              width: 100.w,
                              color: controller.currentindex.value == 4
                                  ? Colors.white
                                  : Color.fromARGB(0, 216, 216, 216),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: controller.pageController,
                      onPageChanged: (index) {
                        controller.currentindex.value = index;
                      },
                      children: [
                        Column(
                          children: [
                            const Center(child: Text("Bussiness")),
                            Text('')
                          ],
                        ),
                        CallsView(calltabcontroller: calltabcontroller),
                        StatusView(statustabcontroller: statustabcontroller),
                        PrimaryView(streamSocket: streamSocket),
                        const GroupView(),
                      ],
                    ),
                  ),
                  // Expanded(
                  //     child: Obx(() => IndexedStack(
                  //           index: controller.currentindex.value,
                  //           children: [
                  //             const Center(child: Text("Bussness")),
                  //             CallsView(calltabcontroller: calltabcontroller),
                  //             StatusView(
                  //                 statustabcontroller: statustabcontroller),
                  //             const PrimaryView(),
                  //             const GroupView(),
                  //           ],
                  //         )))
                ],
              ),
              // color: const Color(0xff449cc0),
              // child: ContainedTabBarView(
              //   initialIndex: 3,
              //   tabBarProperties: TabBarProperties(
              //       // isScrollable: true,
              //       alignment: TabBarAlignment.center,
              //       labelPadding: EdgeInsets.symmetric(horizontal: 15.w),
              //       width: 390.w,
              //       indicatorColor: const Color.fromARGB(0, 255, 193, 7),
              //       labelColor: Colors.white,
              //       unselectedLabelColor:
              //           const Color.fromARGB(255, 218, 216, 216),
              //       unselectedLabelStyle: GoogleFonts.poppins(fontSize: 14.sp),
              //       labelStyle: GoogleFonts.poppins(
              //           color: Colors.white,
              //           fontSize: 14.sp,
              //           fontWeight: FontWeight.w700),
              //       background: Container(
              //         // height: 50,
              //         color: const Color(0xff449cc0),
              //       )),
              //   tabs: [
              //     SizedBox(width: 5, child: Icon(Icons.home)),
              //     SizedBox(width: 5, child: Icon(Icons.search)),
              //     SizedBox(width: 5, child: Icon(Icons.favorite)),
              //     SizedBox(width: 80, child: Tab(text: 'Long Tab 1')),
              //     SizedBox(width: 170, child: Tab(text: 'Long Tab 2')),
              //     //   const Tab(
              // icon: ImageIcon(AssetImage(
              //   'assets/images/bussiness.png',
              // )),
              //     //   ),
              //     //   const Tab(
              //     icon: ImageIcon(AssetImage(
              //   'assets/images/calls.png',
              // ))),
              //     //   Tab(
              //     //     height: 16.h,
              //     //     icon: const ImageIcon(AssetImage(
              //     //       'assets/images/status.png',
              //     //     )),
              //     //   ),
              //     //   Tab(
              // icon: Row(
              //   children: [
              //     const Text("primary"),
              //     SizedBox(
              //       width: 10.w,
              //     ),
              //     Stack(
              //       children: [
              //         Positioned(
              //           child: ImageIcon(
              //               size: 16.h,
              //               const AssetImage(
              //                   "assets/images/Ellipse 42.png")),
              //         ),
              //         Positioned(
              //           top: 2.h,
              //           left: 7.w,
              //           child: Text(
              //             "4",
              //             style: GoogleFonts.poppins(
              //                 color: const Color(0xff449cc0),
              //                 fontSize: 10.sp),
              //           ),
              //         ),
              //       ],
              //     )
              // Container(
              //     decoration: BoxDecoration(
              //         color:Colors.white,
              //         borderRadius:
              //             BorderRadius.all(Radius.circular(30))),
              //     height: 15.h,
              //     width: 15.w,
              //     child: Center(
              //       child: Text(
              //         "4",
              //         style: GoogleFonts.poppins(
              //             color: const Color(0xff449cc0),
              //             fontSize: 10.sp),
              //       ),
              //     //         //     )),
              //     //       ],
              //     //     ),
              //     //   ),
              //     //   Tab(
              //     //     icon: Row(
              //     //       children: [
              //     //         const Text('Group'),
              //     //         SizedBox(
              //     //           width: 10.w,
              //     //         ),
              //     //         Stack(
              //     //           children: [
              //     //             Positioned(
              //     //               child: ImageIcon(
              //     //                   size: 16.h,
              //     //                   const AssetImage(
              //     //                       "assets/images/Ellipse 42.png")),
              //     //             ),
              //     //             Positioned(
              //     //               top: 3.h,
              //     //               left: 7.w,
              //     //               child: Text(
              //     //                 "4",
              //     //                 style: GoogleFonts.poppins(
              //     //                     color: const Color(0xff449cc0),
              //     //                     fontSize: 10.sp),
              //     //               ),
              //     //             ),
              //     //           ],
              //     //         )
              //     //       ],
              //     //     ),
              //     //   ),
              //   ],
              //   views: [
              // const Center(child: Text("Bussness")),
              // CallsView(calltabcontroller: calltabcontroller),
              // StatusView(statustabcontroller: statustabcontroller),
              // const PrimaryView(),
              // const GroupView(),
              //   ],
              //   onChange: (index) => print(index),
              // ),
              // TabBar(
              //     padding: const EdgeInsets.all(0),
              //     labelPadding: EdgeInsets.symmetric(horizontal: 0.w),
              //     dividerColor: const Color.fromARGB(0, 255, 214, 64),
              //     indicatorPadding: EdgeInsets.zero,
              //     controller: tabcontroller,
              //     indicator:
              //         const BoxDecoration(color: Color.fromARGB(0, 0, 0, 0)),
              //     // labelPadding: EdgeInsets.symmetric(horizontal: 15.w),
              //     onTap: (value) {
              //       print("tabbar value : $value");
              //       print(tabcontroller.index);
              //     },
              //     //  isScrollable: true,
              // labelColor: Colors.white,
              // unselectedLabelColor:
              //     const Color.fromARGB(255, 218, 216, 216),
              // unselectedLabelStyle: GoogleFonts.poppins(fontSize: 14.sp),
              // labelStyle: GoogleFonts.poppins(
              //     color: Colors.white,
              //     fontSize: 14.sp,
              //     fontWeight: FontWeight.w700),
              //     tabs: [
              // const Tab(
              //   icon: ImageIcon(AssetImage(
              //     'assets/images/bussiness.png',
              //   )),
              // ),
              // const Tab(
              //     icon: ImageIcon(AssetImage(
              //   'assets/images/calls.png',
              // ))),
              // Tab(
              //   height: 18.h,
              //   icon: const ImageIcon(AssetImage(
              //     'assets/images/status.png',
              //   )),
              // ),
              // Tab(
              //   icon: Row(
              //     children: [
              //       const Text("primary"),
              //       SizedBox(
              //         width: 10.w,
              //       ),
              //       Stack(
              //         children: [
              //           const Positioned(
              //             child: ImageIcon(
              //                 size: 20,
              //                 AssetImage("assets/images/Ellipse 42.png")),
              //           ),
              //           Positioned(
              //             top: 2.h,
              //             left: 7.w,
              //             child: Text(
              //               "4",
              //               style: GoogleFonts.poppins(
              //                   color: const Color(0xff449cc0),
              //                   fontSize: 10.sp),
              //             ),
              //           ),
              //         ],
              //       )
              //       // Container(
              //       //     decoration: BoxDecoration(
              //       //         color:Colors.white,
              //       //         borderRadius:
              //       //             BorderRadius.all(Radius.circular(30))),
              //       //     height: 15.h,
              //       //     width: 15.w,
              //       //     child: Center(
              //       //       child: Text(
              //       //         "4",
              //       //         style: GoogleFonts.poppins(
              //       //             color: const Color(0xff449cc0),
              //       //             fontSize: 10.sp),
              //       //       ),
              //       //     )),
              //     ],
              //   ),
              // ),
              // Tab(
              //   icon: Row(
              //     children: [
              //       const Text('Group'),
              //       SizedBox(
              //         width: 10.w,
              //       ),
              //       Stack(
              //         children: [
              //           const Positioned(
              //             child: ImageIcon(
              //                 size: 20,
              //                 AssetImage("assets/images/Ellipse 42.png")),
              //           ),
              //           Positioned(
              //             top: 2.h,
              //             left: 7.w,
              //             child: Text(
              //               "4",
              //               style: GoogleFonts.poppins(
              //                   color: const Color(0xff449cc0),
              //                   fontSize: 10.sp),
              //             ),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // ),

              //     ]),
            )

            // Expanded(
            //   child: TabBarView(controller: tabcontroller, children: [
            //     const Center(child: Text("Bussness")),
            //     CallsView(calltabcontroller: calltabcontroller),
            //     StatusView(statustabcontroller: statustabcontroller),
            //     const PrimaryView(),
            //     const GroupView(),
            //   ]),
            // ),
          ],
        ),
      )),
    );
  }
}
// class ManuallyControlledSlider extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _ManuallyControlledSliderState();
//   }
// }

// class _ManuallyControlledSliderState extends State<ManuallyControlledSlider> {
//   final CarouselController _controller = CarouselController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Get.put(TabBarController());
//     return Scaffold(
//         appBar: AppBar(title: Text('Manually controlled slider')),
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               CarouselSlider(
//                 items: imageSliders,
//                 options: CarouselOptions(enlargeCenterPage: true, height: 200),
//                 carouselController: _controller,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Flexible(
//                     child: ElevatedButton(
//                       onPressed: () => _controller.previousPage(),
//                       child: Text('←'),
//                     ),
//                   ),
//                   Flexible(
//                     child: ElevatedButton(
//                       onPressed: () => _controller.nextPage(),
//                       child: Text('→'),
//                     ),
//                   ),
//                   ...Iterable<int>.generate(imgList.length).map(
//                     (int pageIndex) => Flexible(
//                       child: ElevatedButton(
//                         onPressed: () => _controller.animateToPage(pageIndex),
//                         child: Text("$pageIndex"),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   PageController _pageController = PageController();
//   int _currentIndex = 0;

//   void _updatePage(int index) {
//     _pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PageView Example'),
//       ),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         children: [
//           const Center(
//             child: Text('Screen 1'),
//           ),
//           const Center(
//             child: Text('Screen 2'),
//           ),
//           const Center(
//             child: Text('Screen 3'),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _updatePage,
//         items: [
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Screen 1',
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: 'Screen 2',
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.school),
//             label: 'Screen 3',
//           ),
//         ],
//       ),
//     );
//   }
// }
fetchData() async {
  final authTokenData =
      await StorageService.instance.readSecureData('AuthToken');
  return authTokenData;
}
