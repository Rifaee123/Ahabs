import 'package:ahbas/controller/getx/auth_controller.dart';
import 'package:ahbas/controller/getx/tabbar_controller.dart';
import 'package:ahbas/view/auth_page/auth_page.dart';
import 'package:ahbas/view/register_page/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterEmailPage extends StatefulWidget {
  const RegisterEmailPage({
    super.key,
  });
  // final ValueNotifier<int> registercurntIndex;

  @override
  State<RegisterEmailPage> createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends State<RegisterEmailPage> {
  @override
  Widget build(BuildContext context) {
    final TabBarController controller = Get.put(TabBarController());
    final Authcontrolller authcontrolller = Get.put(Authcontrolller());
    TextEditingController emailcontroller = TextEditingController();
    // TextEditingController dobcontroller = TextEditingController();
    TextEditingController namecontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    TextEditingController conpasswordcontroller = TextEditingController();

    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    authcontrolller.registerCurrentIndex.value = 0;
                    print(authcontrolller.registerCurrentIndex.value);
                  });
                },
                icon: const Icon(Icons.close)),
            TextFealdAndHeading(
                onChanged: (p0) {
                  controller.registerEmailemailvalidate.value = false;
                },
                isValidate: controller.registerEmailemailvalidate.value,
                validationtext: 'Please Enter Email',
                controller: emailcontroller,
                heading: 'Enter Email Address',
                hintText: 'Email',
                icon: Icons.phone_android,
                inputType: TextInputType.emailAddress,
                obscureText: false),
            Padding(
              padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
              child: Container(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      shape: const MaterialStatePropertyAll(
                          ContinuousRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      backgroundColor:
                          const MaterialStatePropertyAll(Color(0xff449cc0)),
                      elevation: const MaterialStatePropertyAll(5),
                      foregroundColor:
                          const MaterialStatePropertyAll(Colors.white),
                      textStyle:
                          MaterialStatePropertyAll(GoogleFonts.poppins())),
                  child: const Text("Verify"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Your Birth Date',
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 18.sp),
                  ),
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
                        locale: Locale('en', 'US'),
                        // Set the locale to enforce YYYY-MM-DD format
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
                  controller.registerEmaildobvalidate.value == true
                      ? Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text("Enter DOB",
                              style: GoogleFonts.poppins(color: Colors.red)),
                        )
                      : SizedBox()
                ],
              ),
            ),
            TextFealdAndHeading(
                onChanged: (p0) {
                  controller.registerEmailnamevalidate.value = false;
                },
                isValidate: controller.registerEmailnamevalidate.value,
                validationtext: 'Please Enter Name',
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
                style:
                    GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
              child: const DropdownMenuExample(),
            ),
            TextFealdAndHeading(
                onChanged: (p0) {
                  controller.registerEmailpasswordvalidate.value = false;
                },
                isValidate: controller.registerEmailpasswordvalidate.value,
                validationtext: 'Please Enter Password',
                controller: passwordcontroller,
                heading: "Enter Your Password",
                icon: Icons.lock,
                hintText: "password",
                inputType: TextInputType.visiblePassword,
                obscureText: true),
            TextFealdAndHeading(
                onChanged: (p0) {
                  controller.registerEmailrepasswordvalidate.value = false;
                },
                isValidate: controller.registerEmailrepasswordvalidate.value,
                validationtext: 'Please Enter Re Password',
                controller: conpasswordcontroller,
                heading: "RE Enter Password",
                icon: Icons.lock,
                hintText: "RE Enter password",
                inputType: TextInputType.visiblePassword,
                obscureText: true),
            Padding(
              padding: EdgeInsets.only(left: 70.w, bottom: 10.h, top: 20.h),
              child: SizedBox(
                width: 200.w,
                height: 50.h,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: const MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)))),
                        backgroundColor:
                            const MaterialStatePropertyAll(Color(0xff449cc0)),
                        elevation: const MaterialStatePropertyAll(5),
                        foregroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                        textStyle:
                            MaterialStatePropertyAll(GoogleFonts.poppins())),
                    onPressed: () {
                      emailcontroller.text.isEmpty
                          ? controller.registerEmailemailvalidate.value = true
                          : controller.registerEmailemailvalidate.value = false;
                      namecontroller.text.isEmpty
                          ? controller.registerEmailnamevalidate.value = true
                          : controller.registerEmailnamevalidate.value = false;
                      passwordcontroller.text.isEmpty
                          ? controller.registerEmailpasswordvalidate.value =
                              true
                          : controller.registerEmailpasswordvalidate.value =
                              false;
                      conpasswordcontroller.text.isEmpty
                          ? controller.registerEmailrepasswordvalidate.value =
                              true
                          : controller.registerEmailrepasswordvalidate.value =
                              false;
                      controller.dob.value == 'YYYY MM DD'
                          ? controller.registerEmaildobvalidate.value = true
                          : controller.registerEmaildobvalidate.value = false;
                      // if (emailcontroller.text.isEmpty ||
                      //     namecontroller.text.isEmpty ||
                      //     passwordcontroller.text.isEmpty ||
                      //     conpasswordcontroller.text.isEmpty) {}
                      print(controller.selectedGender.value);
                    },
                    child: const Text("Register")),
              ),
            )
          ],
        ));
  }
}

class TextFealdAndHeading extends StatelessWidget {
  const TextFealdAndHeading({
    super.key,
    required this.heading,
    required this.icon,
    required this.hintText,
    required this.inputType,
    required this.obscureText,
    required this.controller,
    required this.validationtext,
    required this.isValidate,
    this.onChanged,
  });
  final String heading;
  final IconData icon;
  final String hintText;
  final TextInputType inputType;
  final bool obscureText;
  final TextEditingController controller;
  final String validationtext;
  final bool isValidate;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
          child: Text(
            heading,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
          child: ComenFormFeild(
            onChanged: onChanged,
            controller: controller,
            hinttext: hintText,
            icon: icon,
            callback: () {},
            inputType: inputType,
            obscureText: obscureText,
          ),
        ),
        isValidate == true
            ? Padding(
                padding: EdgeInsets.only(
                  left: 30.w,
                ),
                child: Text(validationtext,
                    style: GoogleFonts.poppins(color: Colors.red)),
              )
            : SizedBox()
      ],
    );
  }
}

class ComenFormFeild extends StatelessWidget {
  const ComenFormFeild({
    super.key,
    required this.hinttext,
    required this.icon,
    required this.callback,
    required this.inputType,
    required this.obscureText,
    required this.controller,
    this.onChanged,
  });
  final String hinttext;
  final IconData icon;
  final Function() callback;
  final TextInputType inputType;
  final bool obscureText;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 400.w,
      child: Stack(
        children: [
          Positioned(top: 15.h, left: 15.w, child: Icon(icon)),
          Positioned(
            child: SizedBox(
              height: 46.h,
              child: Image.asset(
                'assets/images/Group 75.png',
                height: 100.h,
              ),
            ),
          ),
          Positioned(
              left: 90.w,
              top: 15.h,
              child: SizedBox(
                height: 30,
                width: 200,
                child: Form(
                  child: TextFormField(
                    onChanged: onChanged,
                    controller: controller,
                    obscureText: obscureText,
                    keyboardType: inputType,
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 15.sp),
                        hintText: hinttext,
                        border: InputBorder.none),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
