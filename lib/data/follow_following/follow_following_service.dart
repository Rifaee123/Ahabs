import 'dart:convert';
import 'dart:developer';

import 'package:ahbas/data/api_urls/api_urls.dart';
import 'package:ahbas/data/failures/main_failure.dart';
import 'package:ahbas/data/services/jwt_converter/jwt_converter.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/model/follow_following/followers_list/follower.dart';
import 'package:ahbas/model/follow_following/followers_list/followers_list.dart';
import 'package:ahbas/model/follow_following/following_list/following.dart';
import 'package:ahbas/model/follow_following/following_list/following_list.dart';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class FollowFollowingService {
  Future<Either<MainFailure, bool>> sentFollowRequest(
      String visitingUserId) async {
    try {
      final authToken =
          await StorageService.instance.readSecureData('AuthToken');
      final userId = convertTokenToId(authToken!);
      final url = '$kBaseUrl$followRequestEndPoint$visitingUserId';
      final uri = Uri.parse(url);
      final data = {'currentUserId': userId};

      final newbody = data.keys
          .map((key) =>
              '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(data[key]!)}')
          .join('&');
      final response = await http.post(uri, body: newbody, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $authToken',
      });
      log("sentfollow:${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }

  Future<Either<MainFailure, bool>> sentUnFollowRequest(
       String visitingUserId) async {
    try {
      final authToken =
          await StorageService.instance.readSecureData('AuthToken');
      final userId = convertTokenToId(authToken!);
      final url = '$kBaseUrl$unFollowRequestEndPoint$visitingUserId';
      final uri = Uri.parse(url);
      final data = {'currentUserId': userId};

      final newbody = data.keys
          .map((key) =>
              '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(data[key]!)}')
          .join('&');
      final response = await http.post(uri, body: newbody, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $authToken',
      });
      log("sentUnfollow:${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }

  Future<Either<MainFailure, String>> checkFollowStatus(
      String visitingUserId) async {
    try {
      final authToken =
          await StorageService.instance.readSecureData('AuthToken');
      final userId = convertTokenToId(authToken!);
      final url = '$kBaseUrl$followStatusEndPoint$visitingUserId';
      final uri = Uri.parse(url);
      final data = {'currentUserId': userId};

      final newbody = data.keys
          .map((key) =>
              '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(data[key]!)}')
          .join('&');
      final response = await http.post(uri, body: newbody, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $authToken',
      });
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        String message = responseBody['message'];
        log(message);
        return Right(message);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }

  Future<Either<MainFailure, List<Follower>>> getFollowersList(
      String userId) async {
    try {
      final authToken =
          await StorageService.instance.readSecureData('AuthToken');
      // final userId = convertTokenToId(authToken!);
      log("userid:$userId");
      final url = '$kBaseUrl$followerListEndPoint$userId';
      final uri = Uri.parse(url);

      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $authToken',
      });
      log("GetFollowerList:${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        List<Follower> followersList = [];
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final result = FollowersList.fromJson(responseBody);
        log(result.followers!.length.toString());
        if (result.followers != null) {
          followersList = result.followers!;
        }
        return Right(followersList);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }

  Future<Either<MainFailure, List<Following>>> getFollowingList(
      String userId) async {
    try {
      final authToken =
          await StorageService.instance.readSecureData('AuthToken');
      // final userId = convertTokenToId(authToken!);
      final url = '$kBaseUrl$followingListEndPoint$userId';
      final uri = Uri.parse(url);

      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $authToken',
      });
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        List<Following> followingList = [];
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final result = FollowingList.fromJson(responseBody);
        if (result.following != null) {
          followingList = result.following!;
        }
        return Right(followingList);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }
}
