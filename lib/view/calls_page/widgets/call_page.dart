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
            left: 30.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/Group 9.png",
                height: 40.h,
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                "Create Call Link",
                style: GoogleFonts.poppins(fontSize: 16.sp),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          height: 40.h,
          color: const Color(0xff449cc0),
          child: TabBar(
          
              unselectedLabelColor: const Color.fromARGB(255, 221, 221, 221),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                  Image.asset(
                    'assets/images/dailed.png',
                    height: 10.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text("Today,9.00 pm",
                      style: GoogleFonts.poppins(
                          fontSize: 11.sp, color: Colors.grey)),
                ],
              ),
            ],
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                  Image.asset(
                    'assets/images/recived calls.png',
                    height: 10.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text("Today,9.00 pm",
                      style: GoogleFonts.poppins(
                          fontSize: 11.sp, color: Colors.grey)),
                ],
              ),
            ],
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                  Image.asset(
                    'assets/images/Vector.png',
                    height: 10.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text("Today,9.00 pm",
                      style: GoogleFonts.poppins(
                          fontSize: 11.sp, color: Colors.grey)),
                ],
              ),
            ],
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
