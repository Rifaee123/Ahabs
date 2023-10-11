import 'package:ahbas/view/chat_page/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
              SizedBox(width: 15.w),
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
                        fontSize: 20.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text("How are You Today ?",
                      style: GoogleFonts.poppins(
                          fontSize: 14.sp, color: Colors.grey))
                ],
              ),
              SizedBox(width: 10.w),
              Text("2 Min ago",
                  style:
                      GoogleFonts.poppins(fontSize: 14.sp, color: Colors.grey)),
              SizedBox(width: 20.w),
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
                          color: Colors.black, fontSize: 12.sp),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
