import 'package:ahbas/utils/colors.dart';
import 'package:ahbas/view/edit_profile/edit_pages/language/bottom_sheet.dart';
import 'package:ahbas/view/edit_profile/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        title: Center(
          child: Text(
            'Language',
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: SizedBox(
            height: 230.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileContentRow(
                  content: 'Native Language',
                  width: double.infinity,
                  bottomSheetwidget:
                      LanguageBottomSheet(title: 'Native Language'),
                ),
                ProfileContentRow(
                  content: 'Lanaguage You Speak',
                  width: double.infinity,
                  bottomSheetwidget:
                      LanguageBottomSheet(title: 'Lanaguage You Speak'),
                ),
                const ProfileContentRow(
                  content: 'Lanaguage You Write',
                  width: double.infinity,
                  bottomSheetwidget:
                      LanguageBottomSheet(title: 'Lanaguage You Write'),
                ),
                const ProfileContentRow(
                  content: 'Lanaguage You Read',
                  width: double.infinity,
                  bottomSheetwidget:
                      LanguageBottomSheet(title: 'Lanaguage You Read'),
                ),
                ProfileContentRow(
                  content: 'Lanaguage You Understand',
                  width: double.infinity,
                  bottomSheetwidget:
                      LanguageBottomSheet(title: 'Lanaguage You Understand'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
