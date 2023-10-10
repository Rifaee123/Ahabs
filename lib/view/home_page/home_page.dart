import 'package:ahbas/view/calls_page/widgets/call_page.dart';
import 'package:ahbas/view/chat_page/chat_page.dart';
import 'package:ahbas/view/group_page/group_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
          children: [
            Container(
              color: const Color(0xff449cc0),
              height: 60.h,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h, top: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/more.png",
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
                            width: 10.w,
                          ),
                          Image.asset(
                            "assets/images/🦆 icon _save 2_.png",
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Image.asset(
                            "assets/images/🦆 icon _add_.png",
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Image.asset(
                            "assets/images/Group 12.png",
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 10.w,
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
              child: TabBar(

                  // tabAlignment: TabAlignment.fill,
                  controller: tabcontroller,
                  indicator:
                      const BoxDecoration(color: Color.fromARGB(0, 0, 0, 0)),
                  // labelPadding: EdgeInsets.symmetric(horizontal: 30.w),
                  isScrollable: true,
                  labelColor: Colors.white,
                  unselectedLabelColor:
                      const Color.fromARGB(255, 218, 216, 216),
                  unselectedLabelStyle: GoogleFonts.poppins(fontSize: 13.sp),
                  labelStyle: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700),
                  tabs: [
                    const Tab(
                        icon: ImageIcon(
                            size: 25,
                            color: Color.fromARGB(255, 230, 229, 229),
                            AssetImage(
                              'assets/images/bussiness.png',
                            ))),
                    const Tab(
                        icon: ImageIcon(
                            size: 25,
                            color: Color.fromARGB(255, 230, 229, 229),
                            AssetImage(
                              'assets/images/calls.png',
                            ))),
                    Tab(
                      icon: Row(
                        children: [
                          const Text("primary"),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              height: 15.h,
                              width: 15.h,
                              child: Center(
                                child: Text(
                                  "4",
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff449cc0),
                                      fontSize: 10),
                                ),
                              )),
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
                          Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              height: 15.h,
                              width: 15.h,
                              child: Center(
                                child: Text(
                                  "6",
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff449cc0),
                                      fontSize: 10),
                                ),
                              )),
                        ],
                      ),
                    ),
                    const Tab(
                      text: 'Status',
                    )
                  ]),
            ),
            Expanded(
              child: TabBarView(controller: tabcontroller, children: [
                const Center(child: Text("Bussness")),
                CallsView(calltabcontroller: calltabcontroller),
                const PrimaryView(),
                const GroupView(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50.h,
                            width: 55.w,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 230, 229, 229),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Status",
                                style: GoogleFonts.poppins(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text("Yesterday,9.04 pm",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14.sp, color: Colors.grey)),
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_horiz))
                        ],
                      ),
                    ),
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: const Color(0xff7abbd6),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.r))),
                      child: TabBar(
                          splashBorderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelPadding: EdgeInsets.symmetric(horizontal: 30.w),
                          isScrollable: true,
                          indicatorWeight: 1,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          indicator: const BoxDecoration(
                              color: Color(0xff449cc0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          controller: statustabcontroller,
                          tabs: const [
                            Tab(
                              text: "Recent",
                            ),
                            Tab(
                              text: "Views",
                            ),
                            Tab(
                              text: "Replied",
                            )
                          ]),
                    ),
                    Expanded(
                        child: TabBarView(
                            controller: statustabcontroller,
                            children: [
                          const RecentStatus(),
                          const ViewsStatus(),
                          ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 55.w,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 230, 229, 229),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Appukuttan",
                                        style: GoogleFonts.poppins(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text("Yesterday,9.54 pm",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14.sp,
                                              color: Colors.grey)),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.more_horiz))
                                ],
                              ),
                            ),
                          ),
                        ]))
                  ],
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewsStatus extends StatelessWidget {
  const ViewsStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50.h,
              width: 55.w,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 230, 229, 229),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thakudu",
                  style: GoogleFonts.poppins(
                      fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
                Text("Yesterday,9.54 pm",
                    style: GoogleFonts.poppins(
                        fontSize: 14.sp, color: Colors.grey)),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
          ],
        ),
      ),
    );
  }
}

class RecentStatus extends StatelessWidget {
  const RecentStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50.h,
              width: 55.w,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 230, 229, 229),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pachukuttan",
                  style: GoogleFonts.poppins(
                      fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
                Text("Yesterday,9.54 pm",
                    style: GoogleFonts.poppins(
                        fontSize: 14.sp, color: Colors.grey)),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
          ],
        ),
      ),
    );
  }
}

class GroupView extends StatelessWidget {
  const GroupView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const GroupPage(),
        )),
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.h,
          ),
          child: Row(
            children: [
              SizedBox(width: 20.h),
              Container(
                height: 50.h,
                width: 55.w,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 230, 229, 229),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Image.asset(
                  'assets/images/icons8-person-96 2.png',
                  height: 40.h,
                ),
              ),
              SizedBox(width: 10.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kvk Chandha",
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text("~~Pachu:Aa ok",
                      style: GoogleFonts.poppins(
                          fontSize: 11.sp, color: Colors.grey))
                ],
              ),
              SizedBox(width: 20.h),
              Text("2 Min ago",
                  style:
                      GoogleFonts.poppins(fontSize: 11.sp, color: Colors.grey)),
              SizedBox(width: 20.h),
              Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff449cc0),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  height: 20.h,
                  width: 24.w,
                  child: Center(
                    child: Text(
                      "4",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 10.sp),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class PrimaryView extends StatelessWidget {
  const PrimaryView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ChatPage(),
        )),
        child: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Row(
            children: [
              SizedBox(width: 15.h),
              SizedBox(
                height: 50.h,
                width: 55.w,
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: 40.h,
                        width: 45.w,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 230, 229, 229),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Image.asset(
                          'assets/images/icons8-person-96 2.png',
                          height: 20.h,
                          width: 20.w,
                        ),
                      ),
                    ),
                    Positioned(
                        right: 5.w,
                        bottom: 0.h,
                        child: Image.asset(
                          'assets/images/Group 26.png',
                          height: 22.h,
                        )),
                  ],
                ),
              ),
              SizedBox(width: 5.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pachukuttan",
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text("How are You Today ?",
                      style: GoogleFonts.poppins(
                          fontSize: 11.sp, color: Colors.grey))
                ],
              ),
              SizedBox(width: 30.w),
              Text("2 Min ago",
                  style:
                      GoogleFonts.poppins(fontSize: 11.sp, color: Colors.grey)),
              SizedBox(width: 30.w),
              Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff449cc0),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  height: 20.h,
                  width: 24.w,
                  child: Center(
                    child: Text(
                      "4",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 10.sp),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
