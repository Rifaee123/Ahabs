import 'dart:convert';
import 'dart:developer';

import 'package:ahbas/data/api_urls/api_urls.dart';
import 'package:ahbas/data/failures/main_failure.dart';
import 'package:ahbas/utils/strings.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class VerifyPhoneService {
  Future<Either<MainFailure, bool>> sendOTP(String phoneNumber) async {
    try {
      const accountSid = accountSID;
      const authToken = twilioAuthToken;
      const serviceSid = verifySID; // Obtain from Twilio console
      const url = '$twilioOtpSentingBaseUrl$serviceSid/Verifications';
      log(url);
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}',
        },
        body: {
          'To': phoneNumber,
          'Channel': 'sms',
        },
      );
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }

  Future<Either<MainFailure, bool>> verifyOTP(
      String phoneNumber, String verificationCode) async {
    try {
      const accountSid = accountSID;
      const authToken = twilioAuthToken;
      const serviceSid = verifySID;
      const url =
          'https://verify.twilio.com/v2/Services/$serviceSid/VerificationCheck';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}',
        },
        body: {
          'To': phoneNumber,
          'Code': verificationCode,
        },
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return const Right(true); // OTP is valid
      } else {
        return const Right(false);
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }
}
