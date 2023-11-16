import 'package:ahbas/controller/getx/auth_controller.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/model/login/login_response/login_response.dart';
import 'package:ahbas/provider/login/login_provider.dart';
import 'package:ahbas/view/home_page/home_page.dart';
import 'package:ahbas/view/register_page/register_email_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      backgroundColor: Color(0xff479ec1),
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
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
                    height: 150.h,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close)),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
                    child: Text(
                      "Enter Registerd Email",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 18.sp),
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
                      : const SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
                    child: Text(
                      "Enter Password",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 18.sp),
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
                      : const SizedBox(),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 70.w, bottom: 10.h, top: 10.h),
                    child: SizedBox(
                      width: 200.w,
                      height: 50.h,
                      child: LoginButton(
                          loginemailcontroller: loginemailcontroller,
                          controller: controller,
                          loginemailpasscontroller: loginemailpasscontroller,
                          authcontrolller: authcontrolller),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.loginemailcontroller,
    required this.controller,
    required this.loginemailpasscontroller,
    required this.authcontrolller,
  });

  final TextEditingController loginemailcontroller;
  final TabBarController controller;
  final TextEditingController loginemailpasscontroller;
  final Authcontrolller authcontrolller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authcontrolller.isLogin.value == true) {
        Future.microtask(() async {
          final String? authorizationToken =
              await StorageService.instance.readSecureData('AuthToken');
          if (authorizationToken!.isNotEmpty) {
            return Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  HomePage(authorizationToken: authorizationToken),
            ));
          } else {
            return Text("auth token is null");
          }
        });
      }
      return ElevatedButton(
          style: ButtonStyle(
              shape: const MaterialStatePropertyAll(ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)))),
              backgroundColor:
                  const MaterialStatePropertyAll(Color(0xff449cc0)),
              elevation: const MaterialStatePropertyAll(5),
              foregroundColor: const MaterialStatePropertyAll(Colors.white),
              textStyle: MaterialStatePropertyAll(GoogleFonts.poppins())),
          onPressed: () {
            loginemailcontroller.text.isEmpty
                ? controller.loginEmailvalidate.value = true
                : controller.loginEmailvalidate.value = false;
            loginemailpasscontroller.text.isEmpty
                ? controller.loginemailpasswordvalidate.value = true
                : controller.loginemailpasswordvalidate.value = false;

            if (loginemailcontroller.text.isNotEmpty &&
                loginemailpasscontroller.text.isNotEmpty) {
              Provider.of<LoginProvider>(context, listen: false).login(
                  identifier: loginemailcontroller.text,
                  pasword: loginemailpasscontroller.text);
              LoginResponse logintoken = LoginResponse();

              print(logintoken);
              final result =
                  Provider.of<LoginProvider>(context, listen: false).resultData;
              if (result.isAuthorized == true) {
                Future.delayed(Duration.zero);
                loginemailcontroller.clear();
                loginemailpasscontroller.clear();

                authcontrolller.registerCurrentIndex.value = 0;
                authcontrolller.loginCurrentIndex.value = 0;
              } else {
                final snackBar = SnackBar(
                  backgroundColor: Colors.white,
                  content: Consumer<LoginProvider>(builder: (context, data, _) {
                    final result = data.resultData;

                    if (result.isLoading) {
                      return Text(
                        'Loading',
                        style: GoogleFonts.poppins(color: Colors.green),
                      );
                    } else if (result.isError) {
                      return Text(
                        'Error',
                        style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 248, 0, 25)),
                      );
                    } else if (result.isPasswordInvalid == true) {
                      return Text(
                        'invalid Password',
                        style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 248, 0, 25)),
                      );
                    } else if (result.isAuthorized == true) {
                      return Text(
                        'Login sucsesfull',
                        style: GoogleFonts.poppins(color: Colors.green),
                      );
                    } else {
                      return Text(
                        'Email Incurrect',
                        style: GoogleFonts.poppins(color: Colors.green),
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
          child: const Text("Login"));
    });
  }
}
