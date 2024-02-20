import 'dart:developer';

import 'package:ahbas/utils/colors.dart';
import 'package:ahbas/view/edit_profile/bottom_sheets/profile_frame/frame_bottom_sheet.dart';
import 'package:ahbas/view/edit_profile/bottom_sheets/profile_photo/photo_bottom_sheet.dart';
import 'package:ahbas/view/edit_profile/bottom_sheets/profile_purpose/purpose_bottom_sheet.dart';
import 'package:ahbas/view/edit_profile/edit_pages/contact_details/screen_contact_details.dart';
import 'package:ahbas/view/edit_profile/edit_pages/personal_details/screen_personal_details.dart';
import 'package:ahbas/view/edit_profile/edit_pages/physical_status/screen_physical_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key});

  final TextEditingController profileNameController = TextEditingController();
  final TextEditingController introController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        title: Center(
          child: Text(
            '50% Done',
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5.sp),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'ID:234567890123B',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 11.sp),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return const PhotoBottomSheet();
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 100.sp,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 40.sp,
                            ),
                            Positioned(
                                top: 60.sp,
                                left: 75.sp,
                                child:
                                    Image.asset('assets/images/Group 171.png'))
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 90.sp,
                            height: 30.sp,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/Group 196.png',
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            width: 8.sp,
                          ),
                          CircleAvatar(
                            radius: 7.sp,
                            backgroundColor: Colors.grey,
                            child: Text(
                              '?',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 7.sp),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const Column(
                    children: [
                      ProfileContentRow(
                          content: 'Profile Purpose',
                          bottomSheetwidget: PurposeBottomSheet()),
                      ProfileContentRow(
                        content: 'Profile Type',
                      ),
                      ProfileContentRow(
                        content: 'Profile Frame',
                        bottomSheetwidget: FrameBottomSheet(),
                      ),
                      ProfileContentRow(content: 'Profile Card'),
                    ],
                  )
                ],
              ),
              EditingTextField(
                fieldLabel: 'Profile Name',
                profileNameController: profileNameController,
                maxLines: 1,
              ),
              EditingTextField(
                fieldLabel: 'Intro',
                profileNameController: introController,
                maxLines: 5,
              ),
              ProfileContentRow(
                content: 'Personal Details',
                width: double.infinity,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PersonalDetailsScreen(),
                      ));
                },
              ),
              ProfileContentRow(
                content: 'Contact Details',
                width: double.infinity,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactDetailsScreen(),
                      ));
                },
              ),
              const ProfileContentRow(
                content: 'Educational Status',
                width: double.infinity,
              ),
              const ProfileContentRow(
                content: 'Work Status',
                width: double.infinity,
              ),
              const ProfileContentRow(
                content: 'Relation Status',
                width: double.infinity,
              ),
              ProfileContentRow(
                content: 'Physical Status',
                width: double.infinity,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhysicalStatusScreen(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditingTextField extends StatelessWidget {
  const EditingTextField(
      {super.key,
      required this.profileNameController,
      required this.maxLines,
      required this.fieldLabel,
      this.fieldColor,
      this.isNumberfield = false,
      this.padding});

  final TextEditingController profileNameController;
  final int maxLines;
  final String fieldLabel;
  final bool isNumberfield;
  final Color? fieldColor;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: 10.w,
          ),
      child: TextFormField(
        style: TextStyle(
          color: fieldColor ?? Colors.black,
        ),
        keyboardType: isNumberfield ? TextInputType.number : TextInputType.name,
        decoration: InputDecoration(
            fillColor: fieldColor,
            label: Text(fieldLabel,
                style:
                    GoogleFonts.poppins(color: Colors.black, fontSize: 16.sp)),
            border: const OutlineInputBorder()),
        controller: profileNameController,
        maxLines: maxLines,
      ),
    );
  }
}

class ProfileContentRow extends StatelessWidget {
  const ProfileContentRow({
    super.key,
    required this.content,
    this.width,
    this.bottomSheetwidget,
    this.onTap,
  });
  final String content;
  final double? width;
  final Widget? bottomSheetwidget;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (bottomSheetwidget != null) {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            context: context,
            builder: (context) {
              return bottomSheetwidget!;
            },
          );
        } else if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        width: width ?? 200.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(content,
                style:
                    GoogleFonts.poppins(color: Colors.black, fontSize: 16.sp)),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
