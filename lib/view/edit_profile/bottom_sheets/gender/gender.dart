import 'package:ahbas/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';

class GenderBottomSheet extends StatelessWidget {
  const GenderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context);
    return Container(
      height: 250.h,
      decoration: const BoxDecoration(
          color: AhabsColors.ahabsBasicBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          )),
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
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
                'Gender',
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
            height: 20.h,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Circleframe(
                gender: 'MALE',
              ),
              Circleframe(
                gender: 'FEMALE',
              ),
              Circleframe(
                gender: 'Other',
              )
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            '*Gender Info Is Visible To Public',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class Circleframe extends StatelessWidget {
  const Circleframe({
    super.key,
    required this.gender,
  });
  final String gender;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(100),
          ),
          width: 90.w,
          height: 90.w,
          alignment: Alignment.center,
          child: Text(gender),
        ),
        Checkbox(value: false, onChanged: (value) {}, side: const BorderSide(color:Colors.white), ),
      ],
    );
  }
}
