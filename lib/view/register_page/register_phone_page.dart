import 'dart:developer';

import 'package:ahbas/data/services/secure_storage/secure_storage.dart';

import 'package:ahbas/controller/getx/auth_controller.dart';
import 'package:ahbas/controller/getx/tabbar_controller.dart';

import 'package:ahbas/provider/register/phone_registration_provider.dart';
import 'package:ahbas/provider/register/registration_result.dart';
import 'package:ahbas/provider/verify_phone/verify_phone_provider.dart';

import 'package:ahbas/view/auth_page/auth_page.dart';
import 'package:ahbas/view/home_page/home_page.dart';
import 'package:ahbas/view/register_page/register_email_page.dart';
import 'package:ahbas/view/register_page/widgets/dropdown.dart';
import 'package:ahbas/view/register_page/widgets/phone_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/register/email_registration_provider.dart';

class RegisterPhonePage extends StatefulWidget {
  const RegisterPhonePage({
    super.key,
  });
  // final ValueNotifier<int> registercurntIndex;

  @override
  State<RegisterPhonePage> createState() => _RegisterPhonePageState();
}

class _RegisterPhonePageState extends State<RegisterPhonePage> {
  final Authcontrolller authcontrolller = Get.put(Authcontrolller());
  final TabBarController controller = Get.put(TabBarController());
  TextEditingController Phonecontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController conpasswordcontroller = TextEditingController();
  @override
  void initState() {
    log('heyyyyyy');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String gender = "male";
    return Scaffold(
      backgroundColor: const Color(0xff479ec1),
      body: SafeArea(
        child: Obx(() => SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Color(0xffbfdde9), Color(0xff479ec1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close)),
                    TextFealdAndHeading(
                        onChanged: (p0) {
                          controller.registerPhoneemailvalidate.value = false;
                        },
                        isValidate: controller.registerPhoneemailvalidate.value,
                        validationtext: "Enthe Phone Number",
                        controller: Phonecontroller,
                        heading: 'Enter Active Mobile Number',
                        hintText: '+91',
                        icon: Icons.phone_android,
                        inputType: TextInputType.phone,
                        obscureText: false),
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
                      child: Container(
                        child: ElevatedButton(
                          onPressed: () {
                            Provider.of<VerifyPhoneProvider>(context,
                                    listen: false)
                                .sentVerficationMail(
                                    phoneNumber: Phonecontroller.text);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PhoneVerifyPage(Phone: Phonecontroller.text),
                            ));
                          },
                          style: ButtonStyle(
                              shape: const MaterialStatePropertyAll(
                                  ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xff449cc0)),
                              elevation: const MaterialStatePropertyAll(5),
                              foregroundColor:
                                  const MaterialStatePropertyAll(Colors.white),
                              textStyle: MaterialStatePropertyAll(
                                  GoogleFonts.poppins())),
                          child: const Text("Verify"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Enter Your Birth Date',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 18.sp)),
                          SizedBox(
                            height: 10.h,
                          ),
                          ComenButton(
                            text: controller.dob.value,
                            icon: Icons.calendar_month,
                            callback: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2050),
                                locale: const Locale('en',
                                    'US'), // Set the locale to enforce YYYY-MM-DD format
                                builder: (context, picker) {
                                  return Theme(
                                    data: ThemeData.light(),
                                    child: picker!,
                                  );
                                },
                              ).then((selectedDate) {
                                // Handle selected date (selectedDate will contain only year, month, and day)
                                if (selectedDate != null) {
                                  // Format the selected date as YYYY-MM-DD
                                  String formattedDate =
                                      "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                  controller.dob.value = formattedDate;
                                }
                              });

                              print(controller.dob.value);
                            },
                          ),
                          controller.registerPhonedobvalidate.value == true
                              ? Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Text("Enter DOB",
                                      style: GoogleFonts.poppins(
                                          color: Colors.red)),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                    TextFealdAndHeading(
                        onChanged: (p0) {
                          controller.registerPhonenamevalidate.value = false;
                        },
                        validationtext: "Enter Valid Name",
                        isValidate: controller.registerPhonenamevalidate.value,
                        controller: namecontroller,
                        heading: 'Enter Profile Name',
                        icon: Icons.person,
                        hintText: "Name",
                        inputType: TextInputType.name,
                        obscureText: false),
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
                      child: Text(
                        'Enter Your Genders',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 18.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
                      child: const DropdownMenuExample(),
                    ),
                    TextFealdAndHeading(
                        onChanged: (p0) {
                          controller.registerPhonepasswordvalidate.value =
                              false;
                        },
                        isValidate:
                            controller.registerPhonepasswordvalidate.value,
                        validationtext: "Enter Password",
                        controller: passwordcontroller,
                        heading: "Enter Your Password",
                        icon: Icons.lock,
                        hintText: "password",
                        inputType: TextInputType.visiblePassword,
                        obscureText: true),
                    TextFealdAndHeading(
                        onChanged: (p0) {
                          controller.registerPhonerepasswordvalidate.value =
                              false;
                        },
                        isValidate:
                            controller.registerPhonerepasswordvalidate.value,
                        validationtext: "Enter RePassWord",
                        controller: conpasswordcontroller,
                        heading: "RE Enter Password",
                        icon: Icons.lock,
                        hintText: "RE Enter password",
                        inputType: TextInputType.visiblePassword,
                        obscureText: true),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 70.w, bottom: 10.h, top: 20.h),
                      child: SizedBox(
                        width: 200.w,
                        height: 50.h,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: const MaterialStatePropertyAll(
                                    ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color(0xff449cc0)),
                                elevation: const MaterialStatePropertyAll(5),
                                foregroundColor: const MaterialStatePropertyAll(
                                    Colors.white),
                                textStyle: MaterialStatePropertyAll(
                                    GoogleFonts.poppins())),
                            onPressed: () async {
                              Phonecontroller.text.isEmpty
                                  ? controller
                                      .registerPhoneemailvalidate.value = true
                                  : controller
                                      .registerPhoneemailvalidate.value = false;
                              namecontroller.text.isEmpty
                                  ? controller.registerPhonenamevalidate.value =
                                      true
                                  : controller.registerPhonenamevalidate.value =
                                      false;
                              passwordcontroller.text.isEmpty
                                  ? controller.registerPhonepasswordvalidate
                                      .value = true
                                  : controller.registerPhonepasswordvalidate
                                      .value = false;
                              conpasswordcontroller.text.isEmpty
                                  ? controller.registerPhonerepasswordvalidate
                                      .value = true
                                  : controller.registerPhonerepasswordvalidate
                                      .value = false;
                              controller.dob.value == 'YYYY MM DD'
                                  ? controller.registerPhonedobvalidate.value =
                                      true
                                  : controller.registerPhonedobvalidate.value =
                                      false;
                              print(controller.selectedGender.value);
                              if (passwordcontroller.text !=
                                  conpasswordcontroller.text) {
                                controller.registerEmailrepasswordvalidate
                                    .value = true;
                                print("password not valid");
                              } else {
                                controller.registerEmailrepasswordvalidate
                                    .value = false;
                                if (namecontroller.text.isNotEmpty ||
                                    Phonecontroller.text.isNotEmpty ||
                                    passwordcontroller.text.isNotEmpty) {
                                  String phone = Phonecontroller.text;
                                  String password = passwordcontroller.text;
                                  String gender =
                                      controller.selectedGender.string;
                                  String dateOfBirth = controller.dob.value;
                                  String username = namecontroller.text;
                                  Provider.of<PhoneRegistrationProvider>(
                                          context,
                                          listen: false)
                                      .registerWithPhone(
                                          gender: gender,
                                          dateOfBirth: dateOfBirth,
                                          password: password,
                                          phone: phone,
                                          username: username);
                                  final RegistrationResult result =
                                      Provider.of<PhoneRegistrationProvider>(
                                              context,
                                              listen: false)
                                          .resultData;

                                  if (result.isRegistarationSuccess == true) {
                                    final authorizationToken =
                                        await StorageService.instance
                                            .readSecureData('AuthToken');
                                    Future.delayed(Duration.zero);
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => HomePage(
                                          authorizationToken:
                                              authorizationToken!),
                                    ));
                                    Phonecontroller.clear();
                                    passwordcontroller.clear();
                                    namecontroller.clear();

                                    conpasswordcontroller.clear();
                                  } else {
                                    final snackBar = SnackBar(
                                      backgroundColor: Colors.white,
                                      content:
                                          Consumer<EmailRegistrationProvider>(
                                              builder: (context, data, _) {
                                        final result = data.resultData;

                                        if (result.isRegistarationSuccess ==
                                            true) {
                                          return Text(
                                            'Registration Completed',
                                            style: GoogleFonts.poppins(
                                                color: Colors.green),
                                          );
                                        } else if (result.isLoadng) {
                                          return Text(
                                            'Loading',
                                            style: GoogleFonts.poppins(
                                                color: Colors.green),
                                          );
                                        } else if (result.isError) {
                                          return Text(
                                            'Error',
                                            style: GoogleFonts.poppins(
                                                color: Colors.green),
                                          );
                                        } else if (result.emailAlreadyExisted !=
                                                null &&
                                            result.emailAlreadyExisted!) {
                                          return Text(
                                            'Something Went Wrong',
                                            style: GoogleFonts.poppins(
                                                color: Colors.green),
                                          );
                                        } else if (result
                                                    .userNameAlreadyExisted !=
                                                null &&
                                            result.userNameAlreadyExisted!) {
                                          return Text(
                                            'Something Went Wrong',
                                            style: GoogleFonts.poppins(
                                                color: Colors.green),
                                          );
                                        } else {
                                          return Text(
                                            'Something Went Wrong',
                                            style: GoogleFonts.poppins(
                                                color: Colors.green),
                                          );
                                        }
                                      }),
                                    );

                                    // final progresssnackBar = SnackBar(
                                    //     backgroundColor: Colors.white,
                                    //     content: CircularProgressIndicator());
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }

                                  // else if (result.isLoadng) {
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(progresssnackBar);
                                  // } else if (result.isError) {
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(errorsnackBar);
                                  // }
                                }
                              }
                            },
                            child: const Text("Register")),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

// class TextFealdAndHeading extends StatelessWidget {
//   const TextFealdAndHeading({
//     super.key,
//     required this.heading,
//     required this.icon,
//     required this.hintText,
//     required this.inputType,
//     required this.obscureText,
//     required this.controller,
//   });
//   final String heading;
//   final IconData icon;
//   final String hintText;
//   final TextInputType inputType;
//   final bool obscureText;
//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
//           child: Text(
//             heading,
//             style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
//           child: ComenFormFeild(
//             controller: controller,
//             hinttext: hintText,
//             icon: icon,
//             callback: () {},
//             inputType: inputType,
//             obscureText: obscureText,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ComenFormFeild extends StatelessWidget {
//   const ComenFormFeild({
//     super.key,
//     required this.hinttext,
//     required this.icon,
//     required this.callback,
//     required this.inputType,
//     required this.obscureText,
//     required this.controller,
//   });
//   final String hinttext;
//   final IconData icon;
//   final Function() callback;
//   final TextInputType inputType;
//   final bool obscureText;
//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50.h,
//       width: 400.w,
//       child: Stack(
//         children: [
//           Positioned(top: 15.h, left: 15.w, child: Icon(icon)),
//           Positioned(
//             child: SizedBox(
//               height: 46.h,
//               child: Image.asset(
//                 'assets/images/Group 75.png',
//                 height: 100.h,
//               ),
//             ),
//           ),
//           Positioned(
//               left: 90.w,
//               top: 15.h,
//               child: SizedBox(
//                 height: 30,
//                 width: 200,
//                 child: TextFormField(
//                   controller: controller,
//                   obscureText: obscureText,
//                   keyboardType: inputType,
//                   decoration: InputDecoration(
//                       hintStyle: GoogleFonts.poppins(
//                           color: Colors.white, fontSize: 15.sp),
//                       hintText: hinttext,
//                       border: InputBorder.none),
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }
