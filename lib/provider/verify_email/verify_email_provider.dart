import 'package:ahbas/data/verify_email/verfy_email_service.dart';

import 'package:flutter/material.dart';

class VerifyEmailProvider extends ChangeNotifier {
  bool isVerificationMailSent = true;
  Future sentVerficationMail({required String email}) async {
    final result = await VerifyEmailService().sentVerificationMail(email);
    isVerificationMailSent = result.fold((l) => false, (r) {
      return true;
    });

    notifyListeners();
  }
}
