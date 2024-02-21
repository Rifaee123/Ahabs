import 'package:ahbas/utils/colors.dart';
import 'package:ahbas/view/edit_profile/edit_pages/work_status/bottom_sheet/working_bottom_sheet.dart';
import 'package:ahbas/view/edit_profile/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddWorkStatusScreen extends StatefulWidget {
  const AddWorkStatusScreen({super.key});

  @override
  State<AddWorkStatusScreen> createState() => _AddWorkStatusScreenState();
}

class _AddWorkStatusScreenState extends State<AddWorkStatusScreen> {
  final TextEditingController joiningYearController = TextEditingController();

  final TextEditingController joiningMonthController = TextEditingController();

  final TextEditingController joiningDateController = TextEditingController();

  final TextEditingController resigningYearController = TextEditingController();

  final TextEditingController resigningMonthController =
      TextEditingController();

  final TextEditingController resigningDateController = TextEditingController();

  final TextEditingController developedSkillsController =
      TextEditingController();

  final TextEditingController workTitleController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        title: Center(
          child: Text(
            'Work Status',
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
                fieldLabel: 'Work Title',
                maxLines: 1,
                profileNameController: workTitleController,
              ),
              SizedBox(
                height: 0.h,
              ),
              EditingTextField(
                fieldLabel: 'Working Location',
                maxLines: 1,
                profileNameController: locationController,
              ),
              SizedBox(
                height: 7.h,
              ),
              const DropDownBottomSheet(
                  bottomSheet: WorkingBottomSheet(
                      title: 'Working Type',
                      itemList: ['Type 1', 'Type 2', 'Type 3']),
                  title: 'Working Type'),
              SizedBox(
                height: 17.h,
              ),
              const DropDownBottomSheet(
                  bottomSheet: WorkingBottomSheet(
                      title: 'Type of organization',
                      itemList: ['Type 1', 'Type 2', 'Type 3']),
                  title: 'Type of organization'),

              SizedBox(
                height: 17.h,
              ),
              Text(
                'Date Of Join',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 0.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'Year',
                      maxLines: 1,
                      profileNameController: joiningYearController,
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
                      profileNameController: joiningMonthController,
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'Date',
                      maxLines: 1,
                      profileNameController: joiningDateController,
                      isNumberfield: true,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 0.h,
              ),
              Text(
                'Date Of Resign',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 0.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'Year',
                      maxLines: 1,
                      profileNameController: resigningYearController,
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
                      profileNameController: resigningMonthController,
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'Date',
                      maxLines: 1,
                      profileNameController: resigningDateController,
                      isNumberfield: true,
                    ),
                  )
                ],
              ),
              // SizedBox(
              //   height: 0.h,
              // ),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                  Text(
                    'Currently Working',
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

class DropDownBottomSheet extends StatelessWidget {
  const DropDownBottomSheet({
    super.key,
    required this.title,
    required this.bottomSheet,
  });
  final String title;
  final Widget bottomSheet;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          context: context,
          builder: (context) => bottomSheet,
        );
      },
      child: Container(
        padding: EdgeInsets.all(10.w),
        height: 45.h,
        decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
        width: double.infinity,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Icon(Icons.arrow_drop_down_outlined)
          ],
        ),
      ),
    );
  }
}
