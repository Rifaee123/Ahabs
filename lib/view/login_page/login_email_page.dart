import 'package:ahbas/view/home_page/home_page.dart';
import 'package:ahbas/view/register_page/register_email_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({super.key, required this.loginCurrentIndex});
  final ValueNotifier<int> loginCurrentIndex;

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController loginemailcontroller = TextEditingController();
    TextEditingController loginemailpasscontroller = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                widget.loginCurrentIndex.value = 0;
              });
            },
            icon: const Icon(Icons.close)),
        Padding(
          padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
          child: Text(
            "Enter Registerd Email",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
          child: ComenFormFeild(
              controller: loginemailcontroller,
              hinttext: "Enter Your Email",
              icon: Icons.person,
              callback: () {},
              inputType: TextInputType.emailAddress,
              obscureText: false),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
          child: Text(
            "Enter Password",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
          child: ComenFormFeild(
              controller: loginemailpasscontroller,
              hinttext: "Enter Your Password",
              icon: Icons.person,
              callback: () {},
              inputType: TextInputType.visiblePassword,
              obscureText: true),
        ),
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
                    textStyle: MaterialStatePropertyAll(GoogleFonts.poppins())),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
                },
                child: const Text("Login")),
          ),
        )
      ],
    );
  }
}
