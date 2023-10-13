import 'package:ahbas/data/verify_phone/verify_phone_service.dart';

import 'package:flutter/material.dart';

class VerifyPhoneProvider extends ChangeNotifier {
  bool isVerificationOtpSent = true;
  VerificationStatus verificationStatus =
      VerificationStatus(isError: false, isVerified: false);
  Future sentVerficationMail({required String phoneNumber}) async {
    final result = await VerifyPhoneService().sendOTP(phoneNumber);
    isVerificationOtpSent = result.fold((l) => false, (r) {
      return true;
    });

    notifyListeners();
  }

  //verifyEmailCode
  Future verifyPhoneOtp(
      {required String phoneNumber, required String otp}) async {
    final result = await VerifyPhoneService().verifyOTP(phoneNumber, otp);
    verificationStatus = result
        .fold((l) => VerificationStatus(isError: true, isVerified: false), (r) {
      if (r == true) {
        return VerificationStatus(isError: false, isVerified: true);
      } else {
        return VerificationStatus(isError: false, isVerified: false);
      }
    });

    notifyListeners();
  }
}

class VerificationStatus {
  final bool isError;
  final bool isVerified;

  VerificationStatus({required this.isError, required this.isVerified});
}
