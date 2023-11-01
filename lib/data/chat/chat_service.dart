import 'dart:convert';
import 'dart:developer';

import 'package:ahbas/data/api_urls/api_urls.dart';
import 'package:ahbas/data/failures/main_failure.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/model/chat/individual_chats/individual_chats.dart';
import 'package:ahbas/model/chat/primary_chatters/primary_chatters.dart';
import 'package:ahbas/utils/strings.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ChatService {
  Future<Either<MainFailure, bool>> createChatRoom(
      String visitingUserId) async {
    try {
      final authToken =
          await StorageService.instance.readSecureData('AuthToken');

      final url = '$kBaseUrl$createChatRoomEndPoint$visitingUserId';
      final uri = Uri.parse(url);

      final response = await http.post(uri, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $authToken',
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

  Future<Either<MainFailure, PrimaryChatters>> getPrimaryChats() async {
    try {
      final authToken =
          await StorageService.instance.readSecureData('AuthToken');

      const url = '$kBaseUrl$getPrimaryChatsEndPoint';
      final uri = Uri.parse(url);

      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $authToken'
        //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTI3YmZjYTU3N2Y5YzlmMTg5MGM2Y2EiLCJpYXQiOjE2OTgxNDU3ODMsImV4cCI6MTY5ODIzMjE4M30.hngWcSu6DJsFMn3WDJCNTZZkZgo-VdW7zeBEwcWWHQg'
        //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTFmYWU3M2M0ODA5ZDQ1ZDI1ODA3OGYiLCJpYXQiOjE2OTgxMjIxODcsImV4cCI6MTY5ODIwODU4N30.cnAsaA4NOEBEgGLC52RfUEFWOHivRqecXhhHZXsSwME',
      });

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final responsebody = jsonDecode(response.body);
        final result = PrimaryChatters.fromJson(responsebody);
        return Right(result);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }

  Future<Either<MainFailure, IndividualChats>> getIndividualChats(
      String roomId) async {
    try {
      final authToken =
          await StorageService.instance.readSecureData('AuthToken');

      final url = '$kBaseUrl$getIndividualChatsEndPoint$roomId';
      final uri = Uri.parse(url);

      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $authToken'
        //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTI3YmZjYTU3N2Y5YzlmMTg5MGM2Y2EiLCJpYXQiOjE2OTgxNDU3ODMsImV4cCI6MTY5ODIzMjE4M30.hngWcSu6DJsFMn3WDJCNTZZkZgo-VdW7zeBEwcWWHQg'
        //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTFmYWU3M2M0ODA5ZDQ1ZDI1ODA3OGYiLCJpYXQiOjE2OTgxMjIxODcsImV4cCI6MTY5ODIwODU4N30.cnAsaA4NOEBEgGLC52RfUEFWOHivRqecXhhHZXsSwME',
      });

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final responsebody = jsonDecode(response.body);
        final result = IndividualChats.fromJson(responsebody);
        return Right(result);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }
}
