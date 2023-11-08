import 'dart:developer';
import 'package:ahbas/controller/getx/tabbar_controller.dart';
import 'package:ahbas/provider/verify_phone/verify_phone_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otp_fields/otp_fields.dart';
import 'package:provider/provider.dart';

class PhoneVerifyPage extends StatefulWidget {
  const PhoneVerifyPage({super.key, required this.Phone});
  final String Phone;

  @override
  State<PhoneVerifyPage> createState() => _PhoneVerifyPageState();
}

class _PhoneVerifyPageState extends State<PhoneVerifyPage> {
  @override
  Widget build(BuildContext context) {
    Future<void> _navigateToNextScreen() async {
      await Future.delayed(
          Duration(seconds: 1)); // defer the execution to the next frame
      Navigator.pop(context);
    }

    final TabBarController controller = Get.put(TabBarController());
    void verifyOtp({String? otp}) {
      Provider.of<VerifyPhoneProvider>(context, listen: false)
          .verifyPhoneOtp(phoneNumber: widget.Phone, otp: otp!);

      final VerificationStatus result =
          Provider.of<VerifyPhoneProvider>(context, listen: false)
              .verificationStatus;

      // Consumer<VerifyEmailProvider>(builder: (context, data, _) {
      //   final result = data.resultData;
      // });
      controller.isPhoneVerify.value = result.isVerified;
      // controller.isPhoneVerify.value == true
      //     ? Navigator.of(context).pop()
      //     : showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             title: Consumer<VerifyPhoneProvider>(
      //               builder: (context, value, child) {
      //                 if (value.verificationStatus.isLoding) {
      //                   return Text('Loding');
      //                 } else if (value.verificationStatus.isVerified == true) {
      //                   // Navigator.pop(context);
      //                   // Navigator.pop(context);
      //                   return Text('Successs');
      //                 } else {
      //                   return Text('Error');
      //                 }
      //               },
      //             ),
      //           );
      //         });

      // if (controller.isPhoneVerify.value == true) {
      //   Future.delayed(Duration.zero);
      //   Navigator.of(context).pop();
      // } else {
      //   if (result.isLoding == true) {
      //     Future.delayed(Duration.zero);
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return Consumer<VerifyPhoneProvider>(
      //           builder: (context, data, _) {
      //             final result = data.verificationStatus;
      //             log(result.isVerified.toString());

      //             // Show loading dialog when data is still loading
      //             return AlertDialog(
      //               content: SizedBox(
      //                   height: 20.h,
      //                   width: 20.w,
      //                   child: Center(
      //                     child: CircularProgressIndicator(),
      //                   )),
      //             );
      //           },
      //         );
      //       },
      //     );
      //   } else {
      //     if (result.isVerified == true) {
      //       Navigator.of(context).pop();
      //     } else if (result.isError) {
      //       // OTP is incorrect, show an error message
      //       Future.delayed(Duration.zero);
      //       showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return Consumer<VerifyPhoneProvider>(
      //               builder: (context, data, _) {
      //   return AlertDialog(
      //     title: Text('Error'),
      //     content: Text('Invalid OTP. Please try again.'),
      //     actions: <Widget>[
      //       TextButton(
      //         child: Text('OK'),
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //       ),
      //     ],
      //   );
      // }
      // );
      //         },
      //       );
      //     }
      //   }
      // }

      // String enteredOtp = otpController.text.trim();
    }

    TextEditingController otpController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Email OTP Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OtpFieldsCustom(
                context: context,
                numberOfFields: 6,
                onCodeChanged: (otp) {
                  controller.otp.value = otp;

                  ///handle otp
                }),
            SizedBox(height: 20.0),
            Consumer<VerifyPhoneProvider>(
              builder: (context, value, child) {
                if (value.verificationStatus.isVerified == true) {
                  _navigateToNextScreen();
                }
                return ElevatedButton(
                  onPressed: () {
                    verifyOtp(otp: controller.otp.value);
                  },
                  child: Text('Verify OTP'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
