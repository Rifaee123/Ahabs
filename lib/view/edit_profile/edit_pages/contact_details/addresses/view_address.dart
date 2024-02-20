import 'package:ahbas/utils/colors.dart';
import 'package:ahbas/view/edit_profile/edit_pages/contact_details/addresses/add_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewAddressScreen extends StatelessWidget {
  const ViewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        leadingWidth: 20.w,
        title: Center(
          child: Text(
            'Addresses',
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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddressText(
                      isName: true,
                      text: 'Name',
                    ),
                    AddressText(
                      text: 'Street',
                    ),
                    AddressText(
                      text: 'City,Region',
                    ),
                    AddressText(
                      text: 'Country',
                    ),
                    AddressText(
                      text: 'PinCode',
                    ),
                    AddressText(
                      text: 'Phone Number',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EditDeleteButton(
                          text: 'Edit',
                        ),
                        EditDeleteButton(
                          text: 'Delete',
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNewAddressScreen(),
                      ));
                },
                child: Container(
                  width: 250.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AhabsColors.ahabsBasicBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Add New Address',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class EditDeleteButton extends StatelessWidget {
  const EditDeleteButton({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100.w,
      height: 30.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[400]),
      child: Text(text,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 12.sp,
          )),
    );
  }
}

class AddressText extends StatelessWidget {
  const AddressText({
    super.key,
    required this.text,
    this.isName = false,
  });
  final String text;
  final bool isName;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 15.sp,
        fontWeight: isName ? FontWeight.bold : FontWeight.w400,
      ),
    );
  }
}
