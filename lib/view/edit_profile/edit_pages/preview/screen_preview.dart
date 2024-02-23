import 'package:ahbas/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        leadingWidth: 20.w,
        title: Center(
          child: Text(
            'Preview',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: Center(
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              Container(
                height: 400.h,
                width: 200.w,
                decoration: const BoxDecoration(
                    color: AhabsColors.ahabsBasicBlue,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(1000),
                        topRight: Radius.circular(1000))),
              ),
              Positioned(
                right: 50.w,
                top: 100.h,
                child: Container(
                  height: 220.w,
                  width: 220.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(
                        color: Colors.yellow,
                        width: 10.w,
                      )),
                  child: Icon(
                    Icons.person,
                    size: 150.w,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
