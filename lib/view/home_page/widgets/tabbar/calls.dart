import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CallsView extends StatelessWidget {
  const CallsView({
    super.key,
    required this.calltabcontroller,
  });

  final TabController calltabcontroller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 10.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 35.w,
              ),
              Image.asset(
                "assets/images/Group 9.png",
                height: 47.h,
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                "Create Call Link",
                style: GoogleFonts.poppins(fontSize: 20.sp),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
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
              controller: calltabcontroller,
              tabs: const [
                Tab(
                  text: "Missed",
                ),
                Tab(
                  text: "Recived",
                ),
                Tab(
                  text: "Dialed",
                )
              ]),
        ),
        Expanded(
            child: TabBarView(controller: calltabcontroller, children: const [
          MissedCalls(),
          RecivedCalls(),
          DialedCalls(),
        ]))
      ],
    );
  }
}

class DialedCalls extends StatelessWidget {
  const DialedCalls({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) => Row(
        children: [
          SizedBox(
            width: 15.w,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.h,
              left: 20.w,
            ),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 230, 229, 229),
              radius: 30.r,
              child: Image.asset(
                'assets/images/icons8-person-96 2.png',
                height: 40.h,
                width: 40.w,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            children: [
              Text(
                index == 0 ? "Pachukuttan" : "Thakudu (5)",
                style: GoogleFonts.poppins(
                    fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15.w,
                  ),
                  Image.asset(
                    'assets/images/dailed.png',
                    height: 10.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text("Today,9.00 pm",
                      style: GoogleFonts.poppins(
                          fontSize: 15.sp, color: Colors.grey)),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 30.w,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.call,
                color: Color(0xff449cc0),
              ))
        ],
      ),
    );
  }
}

class RecivedCalls extends StatelessWidget {
  const RecivedCalls({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) => Row(
        children: [
          SizedBox(
            width: 15.w,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.h,
              left: 20.w,
            ),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 230, 229, 229),
              radius: 30.r,
              child: Image.asset(
                'assets/images/icons8-person-96 2.png',
                height: 40.h,
                width: 40.w,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            children: [
              Text(
                index == 0 ? "Pachukuttan" : "Thakudu (5)",
                style: GoogleFonts.poppins(
                    fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15.w,
                  ),
                  Image.asset(
                    'assets/images/recived calls.png',
                    height: 10.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text("Today,9.00 pm",
                      style: GoogleFonts.poppins(
                          fontSize: 15.sp, color: Colors.grey)),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 30.w,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.call,
                color: Color(0xff449cc0),
              ))
        ],
      ),
    );
  }
}

class MissedCalls extends StatelessWidget {
  const MissedCalls({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) => Row(
        children: [
          SizedBox(
            width: 15.w,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.h,
              left: 20.w,
            ),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 230, 229, 229),
              radius: 30.r,
              child: Image.asset(
                'assets/images/icons8-person-96 2.png',
                height: 40.h,
                width: 40.w,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            children: [
              Text(
                index == 0 ? "Pachukuttan" : "Thakudu (5)",
                style: GoogleFonts.poppins(
                    fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15.w,
                  ),
                  Image.asset(
                    'assets/images/Vector.png',
                    height: 10.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text("Today,9.00 pm",
                      style: GoogleFonts.poppins(
                          fontSize: 15.sp, color: Colors.grey)),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 30.w,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.call,
                color: Color(0xff449cc0),
              ))
        ],
      ),
    );
  }
}
