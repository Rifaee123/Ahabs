import 'package:ahbas/utils/colors.dart';
import 'package:ahbas/view/edit_profile/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEducationStatusScreen extends StatefulWidget {
  const AddEducationStatusScreen({super.key});

  @override
  State<AddEducationStatusScreen> createState() => _AddEducationStatusScreenState();
}

class _AddEducationStatusScreenState extends State<AddEducationStatusScreen> {
  final TextEditingController admissionYearController = TextEditingController();

  final TextEditingController admissionMonthController =
      TextEditingController();

  final TextEditingController admissionDateController = TextEditingController();

  final TextEditingController completionYearController =
      TextEditingController();

  final TextEditingController completionMonthController =
      TextEditingController();

  final TextEditingController completionDateController =
      TextEditingController();

  final TextEditingController developedSkillsController =
      TextEditingController();

  final TextEditingController institutonController = TextEditingController();

  final TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        title: Center(
          child: Text(
            'Educational Status',
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
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditingTextField(
                fieldLabel: 'Name Of Institution',
                maxLines: 1,
                profileNameController: institutonController,
              ),
              SizedBox(
                height: 5.h,
              ),
              EditingTextField(
                fieldLabel: 'Term of Study',
                maxLines: 1,
                profileNameController: termController,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'Admission Date',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'Year',
                      maxLines: 1,
                      profileNameController: admissionYearController,
                      isNumberfield: true,
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'Month',
                      maxLines: 1,
                      profileNameController: admissionMonthController,
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'Date',
                      maxLines: 1,
                      profileNameController: admissionDateController,
                      isNumberfield: true,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'Completion Date',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'Year',
                      maxLines: 1,
                      profileNameController: completionYearController,
                      isNumberfield: true,
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'Month',
                      maxLines: 1,
                      profileNameController: completionMonthController,
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'Date',
                      maxLines: 1,
                      profileNameController: completionDateController,
                      isNumberfield: true,
                    ),
                  )
                ],
              ),
              // SizedBox(
              //   height: 5.h,
              // ),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                  Text(
                    'Still Studying',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              EditingTextField(
                fieldLabel: 'Developed Skills',
                maxLines: 1,
                profileNameController: developedSkillsController,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
