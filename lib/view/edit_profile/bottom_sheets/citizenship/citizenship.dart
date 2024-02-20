import 'package:ahbas/utils/colors.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CitizenshipBottomSheet extends StatelessWidget {
  const CitizenshipBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      decoration: const BoxDecoration(
          color: AhabsColors.ahabsBasicBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              Text(
                'Citizenship',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5.sp),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ))
            ],
          ),
          SizedBox(
            width: 200.w,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CheckboxListTile(
                    tileColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: true,
                    onChanged: (value) {},
                    title: Text(
                      'Country 1',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: true,
                    onChanged: (value) {},
                    title: Text(
                      'Country 2',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: false,
                    onChanged: (value) {},
                    title: Text(
                      'Country 3',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
