import 'package:ahbas/controller/getx/follow_controller.dart';
import 'package:ahbas/provider/profile/current_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CurrentUserProvider>(context, listen: false).getCurrentUser();
    super.initState();
  }

  FolloControlller controlller = Get.put(FolloControlller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd9d9d9),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 18.w, top: 15),
            child:
                Consumer<CurrentUserProvider>(builder: (context, value, child) {
              controlller.currentuserid.value =
                  value.currentUserResult.currentUser!.id!;
              if (value.currentUserResult.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (value.currentUserResult.currentUser == null) {
                return const Text("null");
              }
              return Column(
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
                        SizedBox(
                            width: 120.w,
                            child: Text(
                              value.currentUserResult.currentUser!.username
                                  .toString(),
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
                    width: 323.w,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(children: [
                      SizedBox(
                        height: 20.h,
                      ),
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
                                Text(value.currentUserResult.currentUser!
                                    .following!.length
                                    .toString())
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Followers'),
                                Text(
                                  value.currentUserResult.currentUser!
                                      .followers!.length
                                      .toString(),
                                )
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100.w,
                              child: Text(
                                value.currentUserResult.currentUser!.id
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.copy),
                            SizedBox(
                                width: 100.w,
                                child: Text(
                                  value.currentUserResult.currentUser!.createdAt
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                ))
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
                                "Edit Account Details",
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
                                "Preview",
                                style: GoogleFonts.poppins(color: Colors.white),
                              )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 323.w,
                    decoration: const BoxDecoration(
                        color: Colors.white,
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
              );
            })),
      )),
    );
  }
}
