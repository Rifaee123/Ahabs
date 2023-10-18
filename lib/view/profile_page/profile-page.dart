import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd9d9d9),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 18.w, top: 15),
          child: Column(
            children: [
              Container(
                width: 323.w,
                height: 51.h,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24,
                      ),
                    ),
                    Container(
                        width: 120.w,
                        child: Text(
                          "Pachukuttan",
                          style: GoogleFonts.poppins(fontSize: 16.sp),
                          overflow: TextOverflow.ellipsis,
                        )),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 26,
                    ),
                    SizedBox(
                      width: 50.w,
                    ),
                    Row(
                      children: [
                        ImageIcon(
                            AssetImage("assets/images/Qr code scanner.png"),
                            size: 26),
                        SizedBox(
                          width: 10.w,
                        ),
                        ImageIcon(
                          AssetImage("assets/images/more2.png"),
                          size: 19,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 304.h,
                width: 323.w,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(children: [
                      Row(children: [
                        
                      ],)
                    ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}
