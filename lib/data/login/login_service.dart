import 'dart:convert';
import 'dart:developer';
import 'package:ahbas/data/api_urls/api_urls.dart';
import 'package:ahbas/data/failures/main_failure.dart';
import 'package:ahbas/model/login/login/login.dart';
import 'package:ahbas/model/login/login_response/login_response.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<Either<MainFailure, LoginResponse>> login(Login loginBody) async {
    try {
      const url = '$kBaseUrl$loginEndPoint';
      log(url);
      final uri = Uri.parse(url);
      log(loginBody.identifier.toString());
      final Map<String, String> data = {
        "identifier": loginBody.identifier!,
        "password": loginBody.password!
      };
      final newbody = data.keys
          .map((key) =>
              '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(data[key]!)}')
          .join('&');
      final response = await http.post(
        uri,
        body: newbody,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        // log(response.body);
        final responseBody = jsonDecode(response.body);
        // log(responseBody);
        final result = LoginResponse.fromJson(responseBody);

        return Right(result);
      } else if (response.statusCode == 401) {
        final responseBody = jsonDecode(response.body);
        final result = LoginResponse.fromJson(responseBody);
        return Right(result);
      } else if (response.statusCode == 400) {
        final responseBody = jsonDecode(response.body);
        final result = LoginResponse.fromJson(responseBody);
        return Right(result);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }
}
