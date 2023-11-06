import 'package:ahbas/controller/getx/auth_controller.dart';
import 'package:ahbas/model/login/login_response/login_response.dart';
import 'package:ahbas/provider/login/login_provider.dart';
import 'package:ahbas/view/home_page/home_page.dart';
import 'package:ahbas/view/register_page/register_email_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/getx/tabbar_controller.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({
    super.key,
  });
  // final ValueNotifier<int> loginCurrentIndex;

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  final TabBarController controller = Get.put(TabBarController());
  TextEditingController loginemailcontroller = TextEditingController();
  TextEditingController loginemailpasscontroller = TextEditingController();
  final Authcontrolller authcontrolller = Get.put(Authcontrolller());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  authcontrolller.loginCurrentIndex.value = 0;
                },
                icon: const Icon(Icons.close)),
            Padding(
              padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
              child: Text(
                "Enter Registerd Email",
                style:
                    GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
              child: ComenFormFeild(
                  onChanged: (p0) {
                    controller.loginEmailvalidate.value = false;
                  },
                  controller: loginemailcontroller,
                  hinttext: "Enter Your Email",
                  icon: Icons.person,
                  callback: () {},
                  inputType: TextInputType.emailAddress,
                  obscureText: false),
            ),
            controller.loginEmailvalidate.value
                ? Padding(
                    padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
                    child: Text("Enter Email",
                        style: GoogleFonts.poppins(color: Colors.red)),
                  )
                : SizedBox(),
            Padding(
              padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
              child: Text(
                "Enter Password",
                style:
                    GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
              child: ComenFormFeild(
                  onChanged: (p0) {
                    controller.loginemailpasswordvalidate.value = false;
                  },
                  controller: loginemailpasscontroller,
                  hinttext: "Enter Your Password",
                  icon: Icons.person,
                  callback: () {},
                  inputType: TextInputType.visiblePassword,
                  obscureText: true),
            ),
            controller.loginemailpasswordvalidate.value
                ? Padding(
                    padding: EdgeInsets.only(
                      left: 30.w,
                    ),
                    child: Text("Enter Password",
                        style: GoogleFonts.poppins(color: Colors.red)),
                  )
                : SizedBox(),
            Padding(
              padding: EdgeInsets.only(left: 70.w, bottom: 10.h, top: 10.h),
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
                      loginemailcontroller.text.isEmpty
                          ? controller.loginEmailvalidate.value = true
                          : controller.loginEmailvalidate.value = false;
                      loginemailpasscontroller.text.isEmpty
                          ? controller.loginemailpasswordvalidate.value = true
                          : controller.loginemailpasswordvalidate.value = false;

                      if (loginemailcontroller.text.isNotEmpty &&
                          loginemailpasscontroller.text.isNotEmpty) {
                        Provider.of<LoginProvider>(context, listen: false)
                            .login(
                                identifier: loginemailcontroller.text,
                                pasword: loginemailpasscontroller.text);
                        LoginResponse logintoken = LoginResponse();

                        print(logintoken);
                        final result =
                            Provider.of<LoginProvider>(context, listen: false)
                                .resultData;
                        if (result.isAuthorized == true) {
                          Future.delayed(Duration.zero);
                          loginemailcontroller.clear();
                          loginemailpasscontroller.clear();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                          authcontrolller.registerCurrentIndex.value = 0;
                          authcontrolller.loginCurrentIndex.value = 0;
                        } else {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.white,
                            content: Consumer<LoginProvider>(
                                builder: (context, data, _) {
                              final result = data.resultData;

                              if (result.isLoading) {
                                return Text(
                                  'Loading',
                                  style:
                                      GoogleFonts.poppins(color: Colors.green),
                                );
                              } else if (result.isError) {
                                return Text(
                                  'Error',
                                  style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 248, 0, 25)),
                                );
                              } else if (result.isPasswordInvalid == true) {
                                return Text(
                                  'invalid Password',
                                  style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 248, 0, 25)),
                                );
                              } else {
                                return Text(
                                  'Tap login Button',
                                  style:
                                      GoogleFonts.poppins(color: Colors.green),
                                );
                              }
                            }),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => const HomePage(),
                      // ));
                    },
                    child: const Text("Login")),
              ),
            )
          ],
        ));
  }
}
