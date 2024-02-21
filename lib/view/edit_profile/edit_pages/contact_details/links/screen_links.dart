import 'package:ahbas/utils/colors.dart';
import 'package:ahbas/view/edit_profile/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LinksScreen extends StatefulWidget {
  const LinksScreen({super.key});

  @override
  State<LinksScreen> createState() => _LinksScreenState();
}

class _LinksScreenState extends State<LinksScreen> {
  final TextEditingController facebookController = TextEditingController();

  final TextEditingController youtubeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        title: Center(
          child: Text(
            'Links',
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
        child: Form(
            child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
                child: EditingTextField(
                  profileNameController: youtubeController,
                  maxLines: 1,
                  fieldLabel: 'Youtube',
                ),
              ),
              SizedBox(
                height: 60.h,
                child: EditingTextField(
                  profileNameController: facebookController,
                  maxLines: 1,
                  fieldLabel: 'Facebook',
                ),
              ),
            ],
          ),
        )),
      )),
    );
  }
}
