import 'package:ahbas/view/group_page/group_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
                width: 45.w,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 230, 229, 229),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Image.asset(
                  'assets/images/icons8-person-96 2.png',
                  height: 20.h,
                  width: 20.w,
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kvk Chandha",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text("~~Pachu:Aa ok",
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
