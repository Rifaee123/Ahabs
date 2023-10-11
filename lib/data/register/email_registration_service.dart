import 'dart:convert';
import 'dart:developer';

import 'package:ahbas/data/api_urls/api_urls.dart';
import 'package:ahbas/data/failures/main_failure.dart';
import 'package:ahbas/model/register/email_registration/email_registration.dart';

import 'package:ahbas/model/register/register_response/register_response.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class EmailRegistrationService {
  Future<Either<MainFailure, RegisterResponse>> registerUsingEmail(
      EmailRegistration registerBody) async {
    try {
      const url = '$kBaseUrl$registrationEndpoint';
      final uri = Uri.parse(url);

      final data = {
        "email": registerBody.email,
        "password": registerBody.password,
        "gender": registerBody.gender,
        "dateOfBirth": registerBody.dateOfBirth,
        "username": registerBody.username
      };
   
      final newbody = data.keys
          .map((key) =>
              '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(data[key]!)}')
          .join('&');
      final response = await http.post(uri, body: newbody, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      });
      log(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final result = RegisterResponse.fromJson(responseBody);

        return Right(result);
      } else if (response.statusCode == 409) {
        final responseBody = jsonDecode(response.body);
        final result = RegisterResponse.fromJson(responseBody);
        return Right(result);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }
}
