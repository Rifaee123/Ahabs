import 'package:ahbas/data/verify_email/verfy_email_service.dart';
import 'package:ahbas/model/verify_email/verify_email/verify_email.dart';

import 'package:flutter/material.dart';

class VerifyEmailProvider extends ChangeNotifier {
  bool isVerificationMailSent = true;
  VerificationStatus verificationStatus =
      VerificationStatus(isError: false, isVerified: false);
  Future sentVerficationMail({required String email}) async {
    final result = await VerifyEmailService().sentVerificationMail(email);
    isVerificationMailSent = result.fold((l) => false, (r) {
      return true;
    });

    notifyListeners();
  }

  //verifyEmailCode
  Future verifyEmailCode({required String email, required String code}) async {
    final result = await VerifyEmailService().verifyEmailCode(VerifyEmail(
      email: email,
      code: code,
    ));
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
