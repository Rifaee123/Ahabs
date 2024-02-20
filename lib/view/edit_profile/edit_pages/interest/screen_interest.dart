import 'package:ahbas/utils/colors.dart';

import 'package:ahbas/view/edit_profile/edit_pages/interest/bottom_sheet.dart';
import 'package:ahbas/view/edit_profile/edit_pages/interest/settings.dart';
import 'package:ahbas/view/edit_profile/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InterestsScreen extends StatelessWidget {
  const InterestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        title: Center(
          child: Text(
            'Interest',
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
              onPressed: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return const SettingsBottomSheet();
                  },
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: SizedBox(
            height: 460.h,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileContentRow(
                  content: 'Foods',
                  width: double.infinity,
                  bottomSheetwidget: InterestBottomSheet(title: 'Foods'),
                ),
                ProfileContentRow(
                  content: 'Board Games',
                  width: double.infinity,
                  bottomSheetwidget: InterestBottomSheet(title: 'Board Games'),
                ),
                ProfileContentRow(
                  content: 'Social Apps',
                  width: double.infinity,
                  bottomSheetwidget: InterestBottomSheet(title: 'Social Apps'),
                ),
                ProfileContentRow(
                  content: 'Countries',
                  width: double.infinity,
                  bottomSheetwidget: InterestBottomSheet(title: 'Countries'),
                ),
                ProfileContentRow(
                  content: 'Sports',
                  width: double.infinity,
                  bottomSheetwidget: InterestBottomSheet(title: 'Sports'),
                ),
                ProfileContentRow(
                  content: 'Ideologies',
                  width: double.infinity,
                  bottomSheetwidget: InterestBottomSheet(title: 'Ideologies'),
                ),
                ProfileContentRow(
                  content: 'Culture',
                  width: double.infinity,
                  bottomSheetwidget: InterestBottomSheet(title: 'Culture'),
                ),
                ProfileContentRow(
                  content: 'Car Brand',
                  width: double.infinity,
                  bottomSheetwidget: InterestBottomSheet(title: 'Car Brand'),
                ),
                ProfileContentRow(
                  content: 'movies',
                  width: double.infinity,
                  bottomSheetwidget: InterestBottomSheet(title: 'movies'),
                ),
                ProfileContentRow(
                  content: 'Language',
                  width: double.infinity,
                  bottomSheetwidget: InterestBottomSheet(title: 'Language'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
