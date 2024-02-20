import 'package:ahbas/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';

class PhotoBottomSheet extends StatelessWidget {
  const PhotoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context);
    return Container(
      height: 160.h,
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
                'Profile Photo',
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
              PickPictureColumn(
                icon: Icons.camera_alt_rounded,
                pickerName: 'Camera',
              ),
              PickPictureColumn(
                icon: Icons.photo,
                pickerName: 'Gallery',
              ),
              PickPictureColumn(
                icon: Icons.person,
                pickerName: 'Avatar',
              ),
              PickPictureColumn(
                icon: Icons.recycling_rounded,
                pickerName: 'Recent',
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PickPictureColumn extends StatelessWidget {
  const PickPictureColumn(
      {super.key, required this.icon, required this.pickerName});
  final IconData icon;
  final String pickerName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30.sp,
          backgroundColor: Colors.white,
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                icon,
                color: AhabsColors.ahabsBasicBlue,
                size: 25.sp,
              )),
        ),
        Text(
          pickerName,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
