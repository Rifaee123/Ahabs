import 'package:ahbas/utils/colors.dart';
import 'package:ahbas/view/edit_profile/edit_pages/contact_details/addresses/view_address.dart';
import 'package:ahbas/view/edit_profile/edit_pages/contact_details/contact_number/view_contact_number.dart';
import 'package:ahbas/view/edit_profile/edit_pages/contact_details/email/view_email.dart';
import 'package:ahbas/view/edit_profile/edit_pages/contact_details/links/screen_links.dart';
import 'package:ahbas/view/edit_profile/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactDetailsScreen extends StatelessWidget {
  const ContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        title: Center(
          child: Text(
            'Contact Details',
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
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: SizedBox(
            height: 220.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileContentRow(
                  content: 'Addresses',
                  width: double.infinity,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewAddressScreen(),
                        ));
                  },
                ),
                 ProfileContentRow(
                  content: 'Contact Number',
                  width: double.infinity,
                     onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewContactNumberScreen(),
                        ));
                  },
                ),
                 ProfileContentRow(
                  content: 'Email',
                  width: double.infinity,
                   onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewEmailStatusScreen(),
                        ));
                  },
                ),
                const ProfileContentRow(
                  content: 'Location',
                  width: double.infinity,
                  
                ),
                ProfileContentRow(
                    content: 'Links',
                    width: double.infinity,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LinksScreen(),
                          ));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
