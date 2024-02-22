import 'package:ahbas/utils/colors.dart';
import 'package:ahbas/view/edit_profile/bottom_sheets/citizenship/citizenship.dart';
import 'package:ahbas/view/edit_profile/bottom_sheets/gender/gender.dart';
import 'package:ahbas/view/edit_profile/bottom_sheets/religion/religion.dart';
import 'package:ahbas/view/edit_profile/edit_pages/birth_details/screen_birth_details.dart';
import 'package:ahbas/view/edit_profile/edit_pages/habit/screen_habit.dart';
import 'package:ahbas/view/edit_profile/edit_pages/interest/screen_interest.dart';
import 'package:ahbas/view/edit_profile/edit_pages/language/screen_languages.dart';
import 'package:ahbas/view/edit_profile/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        title: Center(
          child: Text(
            'Personal Details',
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
            height: 300.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileContentRow(
                  content: 'Birth Details',
                  width: double.infinity,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BirthDetailsScreen(),
                        ));
                  },
                ),
                const ProfileContentRow(
                  content: 'Gender',
                  width: double.infinity,
                  bottomSheetwidget: GenderBottomSheet(),
                ),
                const ProfileContentRow(
                  content: 'Religion',
                  width: double.infinity,
                  bottomSheetwidget: ReligionBottomSheet(),
                ),
                const ProfileContentRow(
                  content: 'Citizenship',
                  width: double.infinity,
                  bottomSheetwidget: CitizenshipBottomSheet(),
                ),
                ProfileContentRow(
                    content: 'Languages',
                    width: double.infinity,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LanguagesScreen(),
                          ));
                    }),
                ProfileContentRow(
                    content: 'Habits',
                    width: double.infinity,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HabitsScreen(),
                          ));
                    }),
                ProfileContentRow(
                    content: 'Interests',
                    width: double.infinity,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InterestsScreen(),
                          ));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
