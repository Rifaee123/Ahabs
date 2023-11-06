import 'package:ahbas/provider/search/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key, required this.userData});
  final UserDTO userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                decoration: const BoxDecoration(
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
                    SizedBox(
                        width: 120.w,
                        child: Text(
                          userData.userName,
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
                        const ImageIcon(
                            AssetImage("assets/images/Qr code scanner.png"),
                            size: 26),
                        SizedBox(
                          width: 10.w,
                        ),
                        const ImageIcon(
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
                // height: 304.h,

                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/Group 50.png",
                          width: 70.w,
                        ),
                        Column(
                          children: [
                            const Text('Following'),
                            Text(userData.following!.isEmpty
                                ? userData.following!.length.toString()
                                : '0')
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Following'),
                            Text(userData.following!.isEmpty
                                ? userData.following!.length.toString()
                                : '0')
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ID:13882459"),
                        ImageIcon(AssetImage("assets/images/copyicon.png")),
                        Text("Created 2023 March 8")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: const SizedBox(
                      child: ReadMoreText(
                        'Bio: Captuture Every .......................................................................................................................................................................................................................................................................................................................................................................................',
                        trimLines: 3,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Read More',
                        trimExpandedText: 'Read Less',
                        moreStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 194.w,
                          height: 38.h,
                          decoration: const BoxDecoration(
                              color: Color(0xff449cc0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Center(
                              child: Text(
                            "Follow",
                            style: GoogleFonts.poppins(color: Colors.white),
                          )),
                        ),
                        Container(
                          width: 78.w,
                          height: 38.h,
                          decoration: const BoxDecoration(
                              color: Color(0xff449cc0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Center(
                              child: Text(
                            "Contact",
                            style: GoogleFonts.poppins(color: Colors.white),
                          )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ]),
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: const Text("Wait For Next Update .............."),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Image.asset(
                        "assets/images/games.png",
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 166.h,
                width: 323.w,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
