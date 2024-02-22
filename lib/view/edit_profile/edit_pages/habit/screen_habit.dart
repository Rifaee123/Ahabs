import 'package:ahbas/utils/colors.dart';
import 'package:ahbas/view/edit_profile/edit_pages/habit/bottom_sheet.dart';
import 'package:ahbas/view/edit_profile/edit_pages/habit/settings.dart';
import 'package:ahbas/view/edit_profile/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        title: Center(
          child: Text(
            'Habit',
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
                  content: 'Dress',
                  width: double.infinity,
                  bottomSheetwidget: HabitBottomSheet(title: 'Dress'),
                ),
                ProfileContentRow(
                  content: 'Eating',
                  width: double.infinity,
                  bottomSheetwidget: HabitBottomSheet(title: 'Eating'),
                ),
                ProfileContentRow(
                  content: 'Alchoholic',
                  width: double.infinity,
                  bottomSheetwidget: HabitBottomSheet(title: 'Alchoholic'),
                ),
                ProfileContentRow(
                  content: 'Smoke',
                  width: double.infinity,
                  bottomSheetwidget: HabitBottomSheet(title: 'Smoke'),
                ),
                ProfileContentRow(
                  content: 'Sports',
                  width: double.infinity,
                  bottomSheetwidget: HabitBottomSheet(title: 'Sports'),
                ),
                ProfileContentRow(
                  content: 'Swimming',
                  width: double.infinity,
                  bottomSheetwidget: HabitBottomSheet(title: 'Swimming'),
                ),
                ProfileContentRow(
                  content: 'Exercise',
                  width: double.infinity,
                  bottomSheetwidget: HabitBottomSheet(title: 'Exercise'),
                ),
                ProfileContentRow(
                  content: 'Reading',
                  width: double.infinity,
                  bottomSheetwidget: HabitBottomSheet(title: 'Reading'),
                ),
                ProfileContentRow(
                  content: 'Volunteering',
                  width: double.infinity,
                  bottomSheetwidget: HabitBottomSheet(title: 'Volunteering'),
                ),
                ProfileContentRow(
                  content: 'Traveling',
                  width: double.infinity,
                  bottomSheetwidget: HabitBottomSheet(title: 'Traveling'),
                ),
                ProfileContentRow(
                  content: 'Adventure',
                  width: double.infinity,
                  bottomSheetwidget: HabitBottomSheet(title: 'Adventure'),
                ),
                ProfileContentRow(
                  content: 'Cultural',
                  width: double.infinity,
                  bottomSheetwidget: HabitBottomSheet(title: 'Cultural'),
                ),
                ProfileContentRow(
                  content: 'Religious',
                  width: double.infinity,
                  bottomSheetwidget: HabitBottomSheet(title: 'Religious'),
                ),
                ProfileContentRow(
                  content: 'Music',
                  width: double.infinity,
                  bottomSheetwidget: HabitBottomSheet(title: 'Music'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
