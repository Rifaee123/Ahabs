import 'dart:convert';
import 'dart:developer';

import 'package:ahbas/data/api_urls/api_urls.dart';
import 'package:ahbas/data/failures/main_failure.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';

import 'package:ahbas/model/search/all_users/all_users.dart';
import 'package:ahbas/model/search/all_users/datum.dart';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AllUserService {
  Future<Either<MainFailure, List<AllUserData>>> getAllUers() async {
    try {
      const url = '$kBaseUrl$getAllUsersEndpoint';
      log(url);
      final uri = Uri.parse(url);
      // final authToken =
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTFmYWU3M2M0ODA5ZDQ1ZDI1ODA3OGYiLCJpYXQiOjE2OTgxMjc4MTksImV4cCI6MTY5ODIxNDIxOX0.jFcdO5q9Dszp6awXUu16LcNTXDm-znQoxwKi4ILQN8w";
      // // await StorageService.instance.readSecureData('authToken');
      final authToken =
          await StorageService.instance.readSecureData('AuthToken');
      log('Here');
      log(authToken.toString());
      // final userId = convertTokenToId(authToken!);

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final result = AllUsers.fromJson(responseBody);
        List<AllUserData> allUsers = [];
        if (result.data != null) {
          allUsers = result.data!;
        }
        return Right(allUsers);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }
}
