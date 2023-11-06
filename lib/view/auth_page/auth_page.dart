import 'dart:developer';

import 'package:ahbas/controller/getx/auth_controller.dart';
import 'package:ahbas/view/home_page/home_page.dart';
import 'package:ahbas/view/login_page/login_email_page.dart';
import 'package:ahbas/view/login_page/login_phone_page.dart';
import 'package:ahbas/view/register_page/register_email_page.dart';
import 'package:ahbas/view/register_page/register_phone_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  final Authcontrolller controller = Get.put(Authcontrolller());
  // ValueNotifier<int> registercurntIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    log("rebuild");
    print("rebuld");
    return Scaffold(
      body: SafeArea(
          child: Obx(() => SingleChildScrollView(
                  child: Container(
                height: controller.registerCurrentIndex.value == 1 ||
                        controller.registerCurrentIndex.value == 2
                    ? 1030.h
                    : 680.h,
                width: 500,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Color(0xffbfdde9), Color(0xff479ec1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const LoginTopText(),
                    SizedBox(
                      height: 20.h,
                    ),
                    TopTabBar()
                  ],
                ),
              )))),
    );
  }
}

class TopTabBar extends StatefulWidget {
  const TopTabBar({
    super.key,
  });
  // final ValueNotifier<int> registercurntIndex;
  // final ValueNotifier<int> logincurntIndex;

  @override
  State<TopTabBar> createState() => _TopTabBarState();
}

class _TopTabBarState extends State<TopTabBar> with TickerProviderStateMixin {
  final Authcontrolller controller = Get.put(Authcontrolller());
  late TabController tabcontroller;
  @override
  void initState() {
    super.initState();
    tabcontroller = TabController(length: 3, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Container(
              height: 55.h,
              width: 326.w,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: const Color(0xff7abbd6),
                  borderRadius: BorderRadius.all(Radius.circular(15.r))),
              child: TabBar(
                  // isScrollable: true,
                  controller: tabcontroller,
                  dividerColor: const Color.fromARGB(0, 255, 214, 64),
                  splashBorderRadius:
                      const BorderRadius.all(Radius.circular(30)),
                  indicatorSize: TabBarIndicatorSize.tab,
                  // labelPadding: EdgeInsets.symmetric(horizontal: 34.w),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicator: const BoxDecoration(
                      color: Color(0xff449cc0),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  tabs: const [
                    Tab(
                      text: 'Register',
                    ),
                    Tab(
                      text: 'Login',
                    ),
                    Tab(
                      text: 'Recover',
                    )
                  ]),
            ),
            SizedBox(
                height: controller.registerCurrentIndex.value == 1 ||
                        controller.registerCurrentIndex.value == 2
                    ? 850.h
                    : 350.h,
                child: TabBarView(controller: tabcontroller, children: [
                  RegisterComenpage(),
                  LoginCommenPage(),
                  const RecoverComenPage(),
                ]))
          ],
        ));
  }
}

class RecoverComenPage extends StatelessWidget {
  const RecoverComenPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Recover Page Coming Soon',
      style: GoogleFonts.poppins(color: Colors.white, fontSize: 16.sp),
    ));
  }
}

class LoginCommenPage extends StatelessWidget {
  const LoginCommenPage({
    super.key,
  });
  // final ValueNotifier<int> loginCurrentIndex;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    final Authcontrolller authcontrolller = Get.put(Authcontrolller());

    bool? valuefirst = true;
    bool valuesecond = false;
    return Obx(() {
      if (authcontrolller.loginCurrentIndex.value == 0) {
        return Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            ComenButton(
              text: 'Login With Email',
              icon: Icons.mail_outline,
              callback: () {
                authcontrolller.loginCurrentIndex.value = 1;

                print(authcontrolller.loginCurrentIndex.value);
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => const RegisterPage(),
                // ));
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            ComenButton(
              text: 'Login With Mobile',
              icon: Icons.phone_android_outlined,
              callback: () {
                authcontrolller.loginCurrentIndex.value = 2;

                print(authcontrolller.loginCurrentIndex.value);
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => const RegisterPage(),
                // ));
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            ComenButton(
              text: 'Login as a guest',
              icon: Icons.person_2_rounded,
              callback: () {
                authcontrolller.loginCurrentIndex.value = 3;
                // setState(() {

                // });
                print(authcontrolller.loginCurrentIndex.value);
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            languageFeald(),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  checkColor: const Color.fromARGB(255, 255, 255, 255),
                  activeColor: const Color.fromARGB(105, 255, 255, 255),
                  value: valuefirst,
                  onChanged: (bool? value) {
                    valuefirst = valuesecond;
                  },
                ),
                Text(
                  'Agree Terms And Conditions',
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 16.sp),
                )
              ],
            )
          ],
        );
      }
      if (authcontrolller.loginCurrentIndex.value == 1) {
        return LoginEmailPage();
      }
      if (authcontrolller.loginCurrentIndex.value == 2) {
        return LoginPhonePage();
      }
      if (authcontrolller.loginCurrentIndex.value == 3) {
        return Column(
          children: [
            IconButton(
                onPressed: () {
                  authcontrolller.loginCurrentIndex.value = 0;
                },
                icon: const Icon(Icons.close)),
            const Text("login As A guest"),
            ElevatedButton(
                onPressed: () {
                  authcontrolller.loginCurrentIndex.value = 0;
                  authcontrolller.registerCurrentIndex.value = 0;

                  // authcontrolller.dispose();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text("go home"))
          ],
        );
      } else {
        return Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            ComenButton(
              text: 'Login With Email',
              icon: Icons.mail_outline,
              callback: () {
                authcontrolller.loginCurrentIndex.value = 1;

                print(authcontrolller.loginCurrentIndex.value);
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => const RegisterPage(),
                // ));
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            ComenButton(
              text: 'Login With Mobile',
              icon: Icons.phone_android_outlined,
              callback: () {
                authcontrolller.loginCurrentIndex.value = 2;

                print(authcontrolller.loginCurrentIndex.value);
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => const RegisterPage(),
                // ));
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            ComenButton(
              text: 'Login as a guest',
              icon: Icons.person_2_rounded,
              callback: () {
                authcontrolller.loginCurrentIndex.value = 3;

                print(authcontrolller.loginCurrentIndex.value);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            languageFeald(),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  checkColor: const Color.fromARGB(255, 255, 255, 255),
                  activeColor: const Color.fromARGB(105, 255, 255, 255),
                  value: valuefirst,
                  onChanged: (bool? value) {
                    valuefirst = valuesecond;
                  },
                ),
                Text(
                  'Agree Terms And Conditions',
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 16.sp),
                )
              ],
            )
          ],
        );
      }
    });
  }

  // void callbackFunction() {
  Row languageFeald() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'English',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
        ),
        const Icon(Icons.arrow_drop_down),
      ],
    );
  }
}

class ComenButton extends StatelessWidget {
  const ComenButton({
    super.key,
    required this.text,
    required this.icon,
    required this.callback,
  });
  final String text;
  final IconData icon;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Stack(
        children: [
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
              child: Text(
                text,
                style:
                    GoogleFonts.poppins(fontSize: 16.sp, color: Colors.white),
              )),
          Positioned(top: 15.h, left: 15.w, child: Icon(icon))
        ],
      ),
    );
  }
}

class WhiteTextFormFeild extends StatelessWidget {
  const WhiteTextFormFeild({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 293,
      height: 54,
      child: TextFormField(
          textAlign: TextAlign.center,
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.white60,
            ),
            prefixIcon: Icon(icon),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
          )),
    );
  }
}

class RegisterComenpage extends StatefulWidget {
  const RegisterComenpage({
    super.key,
  });
  // final ValueNotifier<int> registercurntIndex;

  @override
  State<RegisterComenpage> createState() => _RegisterComenpageState();
}

class _RegisterComenpageState extends State<RegisterComenpage> {
  final Authcontrolller controller = Get.put(Authcontrolller());
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    bool? valuefirst = true;
    bool valuesecond = false;
    if (controller.registerCurrentIndex.value == 0) {
      return comenregisterContainer(valuefirst, valuesecond);
    }
    if (controller.registerCurrentIndex.value == 1) {
      return RegisterEmailPage();
    }
    if (controller.registerCurrentIndex.value == 2) {
      return RegisterPhonePage();
    }
    if (controller.registerCurrentIndex.value == 3) {
      return const Text("Register As A guest");
    } else {
      return comenregisterContainer(valuefirst, valuesecond);
    }
  }

  Column comenregisterContainer(bool? valuefirst, bool valuesecond) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        ComenButton(
          text: 'Register With Email',
          icon: Icons.mail_outline,
          callback: () {
            setState(() {
              controller.registerCurrentIndex.value = 1;
            });
            print(controller.registerCurrentIndex.value);
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => const RegisterPage(),
            // ));
          },
        ),
        SizedBox(
          height: 30.h,
        ),
        ComenButton(
          text: 'Register With Mobile',
          icon: Icons.phone_android_outlined,
          callback: () {
            setState(() {
              controller.registerCurrentIndex.value = 2;
            });
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => const RegisterPage(),
            // ));
          },
        ),
        SizedBox(
          height: 30.h,
        ),
        ComenButton(
          text: 'Register as a guest',
          icon: Icons.person_2_rounded,
          callback: () {
            setState(() {
              controller.registerCurrentIndex.value = 3;
            });
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => const RegisterPage(),
            // ));
          },
        ),
        SizedBox(
          height: 30.h,
        ),
        languageFeald(),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              checkColor: const Color.fromARGB(255, 255, 255, 255),
              activeColor: const Color.fromARGB(105, 255, 255, 255),
              value: valuefirst,
              onChanged: (bool? value) {
                setState(() {
                  valuefirst = valuesecond;
                });
              },
            ),
            Text(
              'Agree Terms And Conditions',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16.sp),
            )
          ],
        )
      ],
    );
  }

  Row languageFeald() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'English',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
        ),
        const Icon(Icons.arrow_drop_down),
      ],
    );
  }
}

class LoginTopText extends StatelessWidget {
  const LoginTopText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60.h),
      child: Text('Ahabs',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(color: Colors.black, fontSize: 35.sp),
          )),
    );
  }
}
