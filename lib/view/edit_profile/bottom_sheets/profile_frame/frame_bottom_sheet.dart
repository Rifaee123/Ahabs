import 'package:ahbas/utils/colors.dart';
import 'package:ahbas/view/edit_profile/edit_pages/preview/screen_preview.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';

class FrameBottomSheet extends StatelessWidget {
  const FrameBottomSheet({super.key});

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
                'Profile Frame',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  const Circleframe(
                    frameColor: Colors.white,
                  ),
                  Positioned(
                      right: 0,
                      top: 10.h,
                      child: Image.asset(
                          'assets/images/colors-green-checkmark 1.png'))
                ],
              ),
              const Circleframe(
                frameColor: Colors.yellow,
              ),
              const Circleframe(
                frameColor: Colors.indigo,
              )
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PreviewScreen(),
                  ));
            },
            child: Container(
              width: 150.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Preview',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const Icon(
                    Icons.remove_red_eye,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Circleframe extends StatelessWidget {
  const Circleframe({
    super.key,
    required this.frameColor,
  });
  final Color frameColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: frameColor, width: 3.sp)),
      width: 90.w,
      height: 90.w,
    );
  }
}
