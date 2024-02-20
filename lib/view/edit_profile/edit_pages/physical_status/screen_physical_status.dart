import 'package:ahbas/utils/colors.dart';

import 'package:ahbas/view/edit_profile/edit_pages/physical_status/bottom_sheet.dart';
import 'package:ahbas/view/edit_profile/edit_pages/physical_status/settings.dart';
import 'package:ahbas/view/edit_profile/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PhysicalStatusScreen extends StatelessWidget {
  PhysicalStatusScreen({super.key});
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        title: Center(
          child: Text(
            'Physical Status',
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: SizedBox(
              height: 700.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfileContentRow(
                    content: 'Physical Appearance',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Physical Appearance',
                      itemList: ['Normal', 'Challenged'],
                    ),
                  ),
                  ProfileContentRow(
                    content: 'General Apperance',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'General Apperance',
                      itemList: ['Beautiful', 'Cute', 'Handsome'],
                    ),
                  ),
                  ProfileContentRow(
                    content: 'Height',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Height',
                      textController: heightController,
                    ),
                  ),
                  ProfileContentRow(
                    content: 'Weight',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Weight',
                      textController: weightController,
                    ),
                  ),
                  ProfileContentRow(
                    content: 'Blood',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Blood',
                      itemList: [
                        "A+",
                        "B+",
                        "AB+",
                        "O+",
                        "A-",
                        "B-",
                        "AB-",
                        "O-"
                      ],
                    ),
                  ),
                  ProfileContentRow(
                    content: 'Moustache',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Moustache',
                      itemList: ['None', 'Normal', 'Medium', 'Heavy'],
                    ),
                  ),
                  ProfileContentRow(
                    content: 'Beard',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Beard',
                      itemList: ['None', 'Normal', 'Medium', 'Heavy'],
                    ),
                  ),
                  ProfileContentRow(
                    content: 'Hair',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                        title: 'Hair', itemList: ['Curly', 'Straight', 'Long']),
                  ),
                  ProfileContentRow(
                    content: 'Hair Color',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                        title: 'Hair Color',
                        itemList: ['Black', 'Blonde', 'Brown']),
                  ),
                  ProfileContentRow(
                    content: 'Body Color',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Body Color',
                      itemList: ['Wheatish', 'Wheatish Brown', 'Blackish'],
                    ),
                  ),
                  ProfileContentRow(
                    content: 'Body Shape',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Body Shape',
                      itemList: [
                        'Normal',
                        'Slim',
                        'Sporty Fit',
                      ],
                    ),
                  ),
                  ProfileContentRow(
                    content: 'Lip Color',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Lip Color',
                      itemList: ['Reddish', 'Pinkish', 'Brownish'],
                    ),
                  ),
                  ProfileContentRow(
                    content: 'Lip Shape',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Lip Shape',
                      itemList: [
                        'Thin',
                        'Fatty',
                        'Normal',
                      ],
                    ),
                  ),
                  ProfileContentRow(
                    content: 'Nose',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Nose',
                      itemList: ['Normal', 'Fatty', 'Flatty'],
                    ),
                  ),
                  ProfileContentRow(
                    content: 'Eyebrows',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Eyebrows',
                      itemList: [
                        'Black',
                        'Blonde',
                        'Brown',
                      ],
                    ),
                  ),
                  ProfileContentRow(
                    content: 'Tattooed',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Tattooed',
                      itemList: ['Yes', 'No'],
                    ),
                  ),
                  ProfileContentRow(
                    content: 'Hearing',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Hearing',
                      itemList: ['Normal', 'Average', 'With machine'],
                    ),
                  ),
                  ProfileContentRow(
                    content: 'Sight',
                    width: double.infinity,
                    bottomSheetwidget: PhysicalStatusBottomSheet(
                      title: 'Sight',
                      itemList: ['Normal', 'Average', 'With lens'],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
