import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusView extends StatelessWidget {
  const StatusView({
    super.key,
    required this.statustabcontroller,
  });

  final TabController statustabcontroller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 230, 229, 229),
                radius: 30.r,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Status",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, fontWeight: FontWeight.w500),
                  ),
                  Text("Yesterday,9.04 pm",
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp, color: Colors.grey)),
                ],
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
            ],
          ),
        ),
        Container(
          height: 40.h,
          width: 310.w,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xff7abbd6),
              borderRadius: BorderRadius.all(Radius.circular(15.r))),
          child: TabBar(
              dividerColor: const Color.fromARGB(0, 255, 214, 64),
              splashBorderRadius: const BorderRadius.all(Radius.circular(30)),
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: EdgeInsets.symmetric(horizontal: 30.w),
              indicatorWeight: 1,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle: GoogleFonts.poppins(fontSize: 11.sp),
              labelStyle: GoogleFonts.poppins(fontSize: 12.sp),
              indicator: const BoxDecoration(
                  color: Color(0xff449cc0),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
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
            child: TabBarView(controller: statustabcontroller, children: [
          const RecentStatus(),
          const ViewsStatus(),
          ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 230, 229, 229),
                    radius: 30.r,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Appukuttan",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                      Text("Yesterday,9.54 pm",
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp, color: Colors.grey)),
                    ],
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_horiz))
                ],
              ),
            ),
          ),
        ]))
      ],
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
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 230, 229, 229),
              radius: 30.r,
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
                        fontSize: 15.sp, color: Colors.grey)),
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
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 230, 229, 229),
              radius: 30.r,
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
                        fontSize: 15.sp, color: Colors.grey)),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
          ],
        ),
      ),
    );
  }
}
