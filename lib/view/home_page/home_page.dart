import 'package:ahbas/view/calls_page/widgets/call_page.dart';
import 'package:ahbas/view/chat_page/chat_page.dart';
import 'package:ahbas/view/group_page/group_page.dart';
import 'package:ahbas/view/home_page/widgets/tabbar/calls.dart';
import 'package:ahbas/view/home_page/widgets/tabbar/group.dart';
import 'package:ahbas/view/home_page/widgets/tabbar/primary.dart';
import 'package:ahbas/view/home_page/widgets/tabbar/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isprimary = false;
  bool isgroup = false;
  @override
  Widget build(BuildContext context) {
    TabController tabcontroller =
        TabController(length: 5, initialIndex: 2, vsync: this);
    TabController calltabcontroller =
        TabController(length: 3, initialIndex: 0, vsync: this);
    TabController statustabcontroller =
        TabController(length: 3, initialIndex: 0, vsync: this);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: const Color(0xff449cc0),
              height: 60.h,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h, top: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/more1.png",
                        height: 20.h,
                      ),
                      Text(
                        "Ahabs",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 26.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/🦆 icon _notification_.png",
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Image.asset(
                            "assets/images/🦆 icon _save 2_.png",
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Image.asset(
                            "assets/images/🦆 icon _add_.png",
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Image.asset(
                            "assets/images/Group 12.png",
                            height: 20.h,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            ),
            Container(
              height: 40.h,
              color: const Color(0xff449cc0),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: TabBar(
                    dividerColor: const Color.fromARGB(0, 255, 214, 64),
                    indicatorPadding: EdgeInsets.zero,
                    // tabAlignment: TabAlignment.fill,
                    controller: tabcontroller,
                    indicator:
                        const BoxDecoration(color: Color.fromARGB(0, 0, 0, 0)),
                    labelPadding: EdgeInsets.symmetric(horizontal: 15.w),
                    onTap: (value) {
                      print("tabbar value : $value");
                      print(tabcontroller.index);
                    },
                    isScrollable: true,
                    labelColor: Colors.white,
                    unselectedLabelColor:
                        const Color.fromARGB(255, 218, 216, 216),
                    unselectedLabelStyle: GoogleFonts.poppins(fontSize: 15.sp),
                    labelStyle: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700),
                    tabs: [
                      const Tab(
                        icon: ImageIcon(AssetImage(
                          'assets/images/bussiness.png',
                        )),
                      ),
                      const Tab(
                          icon: ImageIcon(AssetImage(
                        'assets/images/calls.png',
                      ))),
                      Tab(
                        height: 18.h,
                        icon: ImageIcon(AssetImage(
                          'assets/images/status.png',
                        )),
                      ),
                      Tab(
                        icon: Row(
                          children: [
                            const Text("primary"),
                            SizedBox(
                              width: 10.w,
                            ),
                            Stack(
                              children: [
                                Positioned(
                                  child: ImageIcon(
                                      size: 20,
                                      AssetImage(
                                          "assets/images/Ellipse 42.png")),
                                ),
                                Positioned(
                                  top: 2.h,
                                  left: 7.w,
                                  child: Text(
                                    "4",
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff449cc0),
                                        fontSize: 10.sp),
                                  ),
                                ),
                              ],
                            )
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
                            //     )),
                          ],
                        ),
                      ),
                      Tab(
                        icon: Row(
                          children: [
                            const Text('Group'),
                            SizedBox(
                              width: 10.w,
                            ),
                            Stack(
                              children: [
                                Positioned(
                                  child: ImageIcon(
                                      size: 20,
                                      AssetImage(
                                          "assets/images/Ellipse 42.png")),
                                ),
                                Positioned(
                                  top: 2.h,
                                  left: 7.w,
                                  child: Text(
                                    "4",
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff449cc0),
                                        fontSize: 10.sp),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
            Expanded(
              child: TabBarView(controller: tabcontroller, children: [
                const Center(child: Text("Bussness")),
                CallsView(calltabcontroller: calltabcontroller),
                StatusView(statustabcontroller: statustabcontroller),
                const PrimaryView(),
                const GroupView(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
