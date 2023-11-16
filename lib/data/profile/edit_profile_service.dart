import 'dart:developer';

import 'package:ahbas/data/api_urls/api_urls.dart';
import 'package:ahbas/data/failures/main_failure.dart';
import 'package:ahbas/data/services/jwt_converter/jwt_converter.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/model/profile/edit_profile/edit_profile.dart';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class EditProfileService {
  Future<Either<MainFailure, bool>> editProfile(EditProfile editProfile) async {
    try {
      final authToken =
          await StorageService.instance.readSecureData('AuthToken');
      final userId = convertTokenToId(authToken!);
      final url = '$kBaseUrl$editProfileEndpoint$userId';
      log(url);
      final uri = Uri.parse(url);

      final Map<String, String> data = {
        "email": editProfile.email!,
        "username": editProfile.username!,
        "gender": editProfile.gender!,
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
          'Authorization': 'Bearer $authToken',
        },
      );

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
