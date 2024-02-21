import 'package:ahbas/utils/colors.dart';
import 'package:ahbas/view/edit_profile/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BirthDetailsScreen extends StatefulWidget {
  const BirthDetailsScreen({super.key});

  @override
  State<BirthDetailsScreen> createState() => _BirthDetailsScreenState();
}

class _BirthDetailsScreenState extends State<BirthDetailsScreen> {
  final TextEditingController birthYearController = TextEditingController();

  final TextEditingController birthMonthController = TextEditingController();

  final TextEditingController birthDateController = TextEditingController();

  final TextEditingController countryController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        title: Center(
          child: Text(
            'Birth Details',
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
              Text(
                'Birthday',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'Year',
                      maxLines: 1,
                      profileNameController: birthYearController,
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
                      profileNameController: birthMonthController,
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'Date',
                      maxLines: 1,
                      profileNameController: birthDateController,
                      isNumberfield: true,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Birth Place',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'Country',
                      maxLines: 1,
                      profileNameController: birthYearController,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'State',
                      maxLines: 1,
                      profileNameController: birthMonthController,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: EditingTextField(
                      fieldLabel: 'City',
                      maxLines: 1,
                      profileNameController: birthDateController,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Nationality By Birth',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black)),
                child: DropdownButton(
                    isExpanded: true,
                    value: 'Country 1',
                    items: const [
                      DropdownMenuItem(
                        value: 'Country 1',
                        child: Text('Country 1'),
                      ),
                      DropdownMenuItem(
                          value: 'Country 2',
                          child: Text('Country 2')),
                      DropdownMenuItem(
                        value: 'Country 3',
                        child: Text('Country 3'),
                      ),
                      DropdownMenuItem(
                        value: 'Country 4',
                        child: Text('Country 4'),
                      ),
                    ],
                    onChanged: (value) {}),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Religion By Birth',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black)),
                child: DropdownButton(
                    isExpanded: true,
                    value: 'Religion 1',
                    items: const [
                      DropdownMenuItem(
                        value: 'Religion 1',
                        child: Text('Religion 1'),
                      ),
                      DropdownMenuItem(
                          value: 'Religion 2',
                          child: Text('Religion 2')),
                      DropdownMenuItem(
                        value: 'Religion 3',
                        child: Text('Religion 3'),
                      ),
                      DropdownMenuItem(
                        value: 'Religion 4',
                        child: Text('Religion 4'),
                      ),
                    ],
                    onChanged: (value) {}),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
