import 'package:ahbas/view/auth_page/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterEmailPage extends StatefulWidget {
  const RegisterEmailPage({super.key, required this.registercurntIndex});
  final ValueNotifier<int> registercurntIndex;

  @override
  State<RegisterEmailPage> createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends State<RegisterEmailPage> {
  @override
  Widget build(BuildContext context) {
    String gender = "male";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                widget.registercurntIndex.value = 0;
                print(widget.registercurntIndex.value);
              });
            },
            icon: const Icon(Icons.close)),
        const TextFealdAndHeading(
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
              child: Text("Verify"),
              style: ButtonStyle(
                  shape: const MaterialStatePropertyAll(
                      ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  backgroundColor:
                      const MaterialStatePropertyAll(Color(0xff449cc0)),
                  elevation: const MaterialStatePropertyAll(5),
                  foregroundColor: const MaterialStatePropertyAll(Colors.white),
                  textStyle: MaterialStatePropertyAll(GoogleFonts.poppins())),
            ),
          ),
        ),
        const TextFealdAndHeading(
            heading: 'Enter Your Birth Date',
            icon: Icons.calendar_month,
            hintText: "YYYY  MM  DD",
            inputType: TextInputType.datetime,
            obscureText: false),
        const TextFealdAndHeading(
            heading: 'Enter Profile Name',
            icon: Icons.person,
            hintText: "Name",
            inputType: TextInputType.name,
            obscureText: false),
        Padding(
          padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
          child: Text(
            'Enter Your Genders',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
          child: SizedBox(
            width: 400.w,
            child: Row(
              children: [
                Radio(
                  value: "Male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                const Icon(Icons.male),
                const Text('Male'),
                Radio(
                  value: "Female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                const Icon(Icons.female),
                const Text('Female'),
                Radio(
                  value: "Other",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                const Icon(Icons.transgender),
                const Text('Other'),
              ],
            ),
          ),
        ),
        const TextFealdAndHeading(
            heading: "Enter Your Password",
            icon: Icons.lock,
            hintText: "password",
            inputType: TextInputType.visiblePassword,
            obscureText: true),
        const TextFealdAndHeading(
            heading: "RE Enter Password",
            icon: Icons.lock,
            hintText: "RE Enter password",
            inputType: TextInputType.visiblePassword,
            obscureText: true),
        Padding(
          padding: EdgeInsets.only(left: 70.w, bottom: 10.h, top: 20.h),
          child: Container(
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
                onPressed: () {},
                child: const Text("Register")),
          ),
        )
      ],
    );
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
  });
  final String heading;
  final IconData icon;
  final String hintText;
  final TextInputType inputType;
  final bool obscureText;

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
            hinttext: hintText,
            icon: icon,
            callback: () {},
            inputType: inputType,
            obscureText: obscureText,
          ),
        ),
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
  });
  final String hinttext;
  final IconData icon;
  final Function() callback;
  final TextInputType inputType;
  final bool obscureText;

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
                child: TextFormField(
                  obscureText: obscureText,
                  keyboardType: inputType,
                  decoration: InputDecoration(
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 15.sp),
                      hintText: hinttext,
                      border: InputBorder.none),
                ),
              )),
        ],
      ),
    );
  }
}
