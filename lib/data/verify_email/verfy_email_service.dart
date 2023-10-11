
import 'dart:developer';

import 'package:ahbas/data/api_urls/api_urls.dart';
import 'package:ahbas/data/failures/main_failure.dart';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class VerifyEmailService {
  Future<Either<MainFailure, bool>> sentVerificationMail(String email) async {
    try {
      const url = '$kBaseUrl$verifyEmailEndpoint';
      final uri = Uri.parse(url);
      final data = {'email': email};

      

      final newbody = data.keys
          .map((key) =>
              '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(data[key]!)}')
          .join('&');
      final response = await http.post(uri, body: newbody, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      });
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }
}
