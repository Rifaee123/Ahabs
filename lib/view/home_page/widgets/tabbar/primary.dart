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
        child: ListTile(
          trailing: SizedBox(
            width: 90.w,
            child: Row(
              children: [
                Text("2 Min ago",
                    style: GoogleFonts.poppins(
                        fontSize: 10.sp, color: Colors.grey)),
                SizedBox(
                  width: 10.w,
                ),
                CircleAvatar(
                  backgroundColor: Color(0xff449cc0),
                  radius: 12.r,
                  child: Center(
                    child: Text(
                      "4",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 12.sp),
                    ),
                  ),
                )
                // Container(
                //     decoration: const BoxDecoration(
                //         color: Color(0xff449cc0),
                //         borderRadius: BorderRadius.all(Radius.circular(30))),
                //     height: 18.h,
                //     width: 20.w,
                // child: Center(
                //   child: Text(
                //     "4",
                //     style: GoogleFonts.poppins(
                //         color: Colors.black, fontSize: 12.sp),
                //   ),
                // )),
              ],
            ),
          ),
          subtitle: Text("How are You Today ?",
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(fontSize: 13.sp, color: Colors.grey)),
          title: Text(
            "Pachukuttan",
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
                fontSize: 19.sp, fontWeight: FontWeight.w500),
          ),
          leading: SizedBox(
            height: 50.h,
            width: 62.w,
            child: Stack(
              children: [
                Positioned(
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
      ),
    );
  }
}
