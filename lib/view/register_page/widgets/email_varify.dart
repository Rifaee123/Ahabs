import 'package:ahbas/controller/getx/tabbar_controller.dart';
import 'package:ahbas/provider/verify_email/verify_email_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_fields/otp_fields.dart';
import 'package:provider/provider.dart';

class EmailVerifyPage extends StatelessWidget {
  const EmailVerifyPage({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final TabBarController controller = Get.put(TabBarController());

    void verifyOtp({String? otp}) async {
      await Provider.of<VerifyEmailProvider>(context, listen: false)
          .verifyEmailCode(email: email, code: otp!);
      final VerificationStatus result =
          Provider.of<VerifyEmailProvider>(context, listen: false)
              .verificationStatus;
      // Consumer<VerifyEmailProvider>(builder: (context, data, _) {
      //   final result = data.resultData;
      // });
      if (result.isLoding == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 100.h,
              child: const AlertDialog(
                content: Center(child: CircularProgressIndicator()),
                // actions: <Widget>[
                //   TextButton(
                //     child: Text('OK'),
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
                //   ),
                // ],
              ),
            );
          },
        );
      } else {
        if (result.isVerified == true) {
          // OTP is correct, navigate to the next screen or perform the desired action
          Navigator.of(context).pop();
          // Replace SuccessScreen with the next screen
        } else if (result.isError) {
          // OTP is incorrect, show an error message
          Future.delayed(Duration.zero);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Invalid OTP. Please try again.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
      // String enteredOtp = otpController.text.trim();
    }

    TextEditingController otpController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                verifyOtp(otp: controller.otp.value);
              },
              child: Text('Verify OTP'),
            )
          ],
        ),
      ),
    );
  }
}
