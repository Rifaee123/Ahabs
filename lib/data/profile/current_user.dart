import 'dart:convert';
import 'dart:developer';

import 'package:ahbas/data/api_urls/api_urls.dart';
import 'package:ahbas/data/failures/main_failure.dart';
import 'package:ahbas/data/services/jwt_converter/jwt_converter.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/model/profile/current_user/current_user.dart';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class CurrentUserService {
  Future<Either<MainFailure, CurrentUser>> getCurrentUser() async {
    try {
      final authToken =
          await StorageService.instance.readSecureData('authToken');

      final userId = convertTokenToId(authToken!);
      final url = '$kBaseUrl$getcurrentUserEndpoint$userId';
      log(url);
      final uri = Uri.parse(url);

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final result = CurrentUser.fromJson(responseBody);

        return Right(result);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }
}
