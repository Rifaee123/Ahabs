import 'package:ahbas/utils/colors.dart';
import 'package:ahbas/view/edit_profile/edit_pages/contact_details/addresses/widgets/bottom_sheet.dart';
import 'package:ahbas/view/edit_profile/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController countryController = TextEditingController();

  final TextEditingController regionController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController streetController = TextEditingController();

  final TextEditingController pincodeController = TextEditingController();

  final TextEditingController nearLandMarkController = TextEditingController();

  final TextEditingController phoneNumController = TextEditingController();

  final TextEditingController alternativePhoneNumController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        title: Center(
          child: Text(
            'Add New Address',
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
                  profileNameController: nameController,
                  maxLines: 1,
                  fieldLabel: 'Name',
                ),
              ),
              SizedBox(
                height: 60.h,
                child: EditingTextField(
                  profileNameController: countryController,
                  maxLines: 1,
                  fieldLabel: 'Country',
                ),
              ),
              SizedBox(
                height: 60.h,
                child: EditingTextField(
                  profileNameController: regionController,
                  maxLines: 1,
                  fieldLabel: 'Region',
                ),
              ),
              SizedBox(
                height: 60.h,
                child: EditingTextField(
                  profileNameController: cityController,
                  maxLines: 1,
                  fieldLabel: 'City',
                ),
              ),
              SizedBox(
                height: 60.h,
                child: EditingTextField(
                  profileNameController: streetController,
                  maxLines: 1,
                  fieldLabel: 'Street/Road/Colony',
                ),
              ),
              SizedBox(
                height: 60.h,
                child: EditingTextField(
                  profileNameController: pincodeController,
                  maxLines: 1,
                  fieldLabel: 'Pincode',
                ),
              ),
              SizedBox(
                height: 60.h,
                child: EditingTextField(
                  profileNameController: nearLandMarkController,
                  maxLines: 1,
                  fieldLabel: 'Nearby LandMark',
                ),
              ),
              SizedBox(
                height: 60.h,
                child: EditingTextField(
                  profileNameController: phoneNumController,
                  maxLines: 1,
                  fieldLabel: 'Phone Number',
                ),
              ),
              SizedBox(
                height: 60.h,
                child: EditingTextField(
                  profileNameController: alternativePhoneNumController,
                  maxLines: 1,
                  fieldLabel: 'Alternative Phone Number',
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              const ProfileContentRow(
                content: 'Type of address',
                width: double.infinity,
                bottomSheetwidget: AddressBottomSheet(title: 'Type of address'),
              )
            ],
          ),
        )),
      )),
    );
  }
}
