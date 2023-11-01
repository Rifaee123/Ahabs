import 'dart:developer';

import 'package:ahbas/controller/getx/follow_controller.dart';
import 'package:ahbas/provider/folllow_following/follow_following_provider.dart';
import 'package:ahbas/provider/search/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key, required this.userData});
  final UserDTO userData;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FolloControlller controller = Get.put(FolloControlller());

  @override
  void initState() {
    log("initFollowStatus:${controller.isFollow.value.toString()}");
    log(widget.userData.userId.toString());
    checkFollowStatus();
    Provider.of<SearchPrvider>(context, listen: false).getAllUsers();
    Provider.of<FollowFollowingProvider>(context, listen: false)
        .getFollowersList(visitingUserId: widget.userData.userId);
    Provider.of<FollowFollowingProvider>(context, listen: false)
        .getFollowingList(visitingUserId: widget.userData.userId);

    super.initState();
  }

  Future<void> checkFollowStatus() async {
    var followProvider =
        Provider.of<FollowFollowingProvider>(context, listen: false);
    await followProvider.checkFollowStatus(
        visitingUserId: widget.userData.userId);
    await followProvider.getFollowersList(
        visitingUserId: widget.userData.userId);

    if (controller.isNeither.value == true) {
      log('isNeither true');
      controller.isFollow.value = true;
      controller.isFollowback.value = false;
    } else if (controller.isFollowing.value == true) {
      log('isFollowing true');
      controller.isFollow.value = false;
      controller.isFollowback.value = false;
    } else if (controller.isFollower.value == true) {
      log('follower true');
      controller.isFollow.value = false;
      controller.isFollowback.value = true;
    } else if (controller.isBoth.value == true) {
      log('isBoth true');
      controller.isFollow.value = false;
      controller.isFollowback.value = false;
    }
  }

  void sentFollow() async {
    var followProvider =
        Provider.of<FollowFollowingProvider>(context, listen: false);
    await followProvider.sentFollowRequest(
        visitingUserId: widget.userData.userId);
    log(widget.userData.userId);
    controller.isFollow.value = false;
    await followProvider.getFollowersList(
        visitingUserId: widget.userData.userId);
    await followProvider.getFollowingList(
        visitingUserId: widget.userData.userId);
  }

  void unFollow() async {
    var followProvider =
        Provider.of<FollowFollowingProvider>(context, listen: false);

    await followProvider.sentUnFollowRequest(
        visitingUserId: widget.userData.userId);
    log(widget.userData.userId);
    controller.isFollow.value = true;
    await followProvider.getFollowersList(
        visitingUserId: widget.userData.userId);
    await followProvider.getFollowingList(
        visitingUserId: widget.userData.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => Column(
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
                              widget.userData.userName,
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
                                Text(controller.followingList.length.toString())
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Followers'),
                                Text(controller.followerList.length.toString())
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
                        child: Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                controller.currentuserid.value ==
                                        widget.userData.userId
                                    ? AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        width: 194.w,
                                        height: 38.h,
                                        decoration:
                                            //  BoxDecoration(
                                            //         color: Color.fromARGB(
                                            //             255, 255, 255, 255),
                                            //         border: Border.all(
                                            //             color: Colors.black),
                                            //         borderRadius: BorderRadius.all(
                                            //             Radius.circular(30)))
                                            //     :
                                            BoxDecoration(
                                                color: Color(0xff449cc0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                        child: Center(
                                            child: Text(
                                          "Edit Profile",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        )))
                                    : controller.isFollowback.value == true &&
                                            controller.isFollow.value == false
                                        ? InkWell(
                                            onTap: () {
                                              controller.isFollow.value = false;
                                              controller.isFollowback.value =
                                                  false;
                                              sentFollow();

                                              // if (controller.isNeither.value ==
                                              //     true) {
                                              //   log('isNeither true');
                                              //   controller.isFollow.value =
                                              //       true;
                                              //   controller.isFollowback.value =
                                              //       false;
                                              // } else if (controller
                                              //         .isFollowing.value ==
                                              //     true) {
                                              //   log('isFollowing true');
                                              //   controller.isFollow.value =
                                              //       false;
                                              //   controller.isFollowback.value =
                                              //       false;
                                              // } else if (controller
                                              //         .isFollower.value ==
                                              //     true) {
                                              //   log('follower true');
                                              //   controller.isFollow.value =
                                              //       false;
                                              //   controller.isFollowback.value =
                                              //       true;
                                              // } else if (controller
                                              //         .isBoth.value ==
                                              //     true) {
                                              //   log('isBoth true');
                                              //   controller.isFollow.value =
                                              //       false;
                                              //   controller.isFollowback.value =
                                              //       false;
                                              // }
                                              // // log("result ${controller.checkresult.value}");
                                              // checkFollowStatus();
                                              // Provider.of<SearchPrvider>(
                                              //         context,
                                              //         listen: false)
                                              //     .getAllUsers();
                                              // print(controller.checkresult.value
                                              //     .toString());
                                              // if (controller.isNeither.value ==
                                              //     true) {
                                              //   log('hai');
                                              //   controller.isFollow.value =
                                              //       true;
                                              // } else if (controller
                                              //         .isFollowing.value ==
                                              //     true) {
                                              //   log('hallo');
                                              //   controller.isFollow.value =
                                              //       false;
                                              // } else if (controller
                                              //         .isFollower.value ==
                                              //     true) {
                                              //   log('hallo');
                                              //   controller.isFollowback.value =
                                              //       false;
                                              // }
                                              // controller.isFollow.value = false;
                                              // controller.isFollowback.value =
                                              //     false;
                                            },
                                            child: AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 300),
                                              width: 200.w,
                                              height: 38.h,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff449cc0),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30))),
                                              child: Center(
                                                  child: Text(
                                                "Follow Back",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              )),
                                            ))
                                        : controller.isFollow.value == true &&
                                                controller.isFollowback.value ==
                                                    false
                                            ? InkWell(
                                                onTap: () async {
                                                  sentFollow();
                                                  log("result ${controller.checkresult.value}");
                                                  // checkFollowStatus();
                                                  controller.isFollow.value =
                                                      false;
                                                  controller.isFollowback
                                                      .value = false;
                                                  // Provider.of<SearchPrvider>(
                                                  //         context,
                                                  //         listen: false)
                                                  //     .getAllUsers();
                                                  print(controller
                                                      .checkresult.value
                                                      .toString());
                                                  // if (controller
                                                  //         .isNeither.value ==
                                                  //     true) {
                                                  //   log('isNeither true');
                                                  //   controller.isFollow.value =
                                                  //       true;
                                                  //   controller.isFollowback
                                                  //       .value = false;
                                                  // } else if (controller
                                                  //         .isFollowing.value ==
                                                  //     true) {
                                                  //   log('isFollowing true');
                                                  //   controller.isFollow.value =
                                                  //       false;
                                                  //   controller.isFollowback
                                                  //       .value = false;
                                                  // } else if (controller
                                                  //         .isFollower.value ==
                                                  //     true) {
                                                  //   log('follower true');
                                                  //   controller.isFollow.value =
                                                  //       false;
                                                  //   controller.isFollowback
                                                  //       .value = true;
                                                  // } else if (controller
                                                  //         .isBoth.value ==
                                                  //     true) {
                                                  //   log('isBoth true');
                                                  //   controller.isFollow.value =
                                                  //       false;
                                                  //   controller.isFollowback
                                                  //       .value = false;
                                                  // }
                                                },
                                                child: AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  width: 200.w,
                                                  height: 38.h,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff449cc0),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30))),
                                                  child: Center(
                                                      child: Text(
                                                    "Follow",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white),
                                                  )),
                                                ))
                                            : AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                width: 200.w,
                                                height: 38.h,
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 254, 255, 255),
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30))),
                                                child: Center(
                                                  child: DropdownButton<String>(
                                                    value: controller
                                                        .dropdownvalue.value,
                                                    items: <String>[
                                                      'Following',
                                                      'Unfollow'
                                                    ].map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        controller.dropdownvalue
                                                            .value = newValue!;
                                                      });
                                                      if (newValue ==
                                                          'Unfollow') {
                                                        // Handle unfollow logic

                                                        unFollow();
                                                        print('unfollow');
                                                        checkFollowStatus();
                                                        // if (controller.isNeither
                                                        //         .value ==
                                                        //     true) {
                                                        //   log('isNeither true');
                                                        //   controller.isFollow
                                                        //       .value = true;
                                                        //   controller
                                                        //       .isFollowback
                                                        //       .value = false;
                                                        // } else if (controller
                                                        //         .isFollowing
                                                        //         .value ==
                                                        //     true) {
                                                        //   log('isFollowing true');
                                                        //   controller.isFollow
                                                        //       .value = false;
                                                        //   controller
                                                        //       .isFollowback
                                                        //       .value = false;
                                                        // } else if (controller
                                                        //         .isFollower
                                                        //         .value ==
                                                        //     true) {
                                                        //   log('follower true');
                                                        //   controller.isFollow
                                                        //       .value = false;
                                                        //   controller
                                                        //       .isFollowback
                                                        //       .value = true;
                                                        // } else if (controller
                                                        //         .isBoth.value ==
                                                        //     true) {
                                                        //   log('isBoth true');
                                                        //   controller.isFollow
                                                        //       .value = false;
                                                        //   controller
                                                        //       .isFollowback
                                                        //       .value = false;
                                                        // }
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                Container(
                                  width: 78.w,
                                  height: 38.h,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff449cc0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: Center(
                                      child: Text(
                                    "Contact",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                                )
                              ],
                            )),
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
                          child:
                              const Text("Wait For Next Update .............."),
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
                  // ... rest of your code remains unchanged
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
