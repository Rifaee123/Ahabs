import 'dart:developer';

import 'package:ahbas/controller/getx/follow_controller.dart';
import 'package:ahbas/data/follow_following/follow_following_service.dart';
import 'package:ahbas/data/services/jwt_converter/jwt_converter.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/data/services/socket_io/socket_io.dart';
import 'package:ahbas/model/follow_following/followers_list/follower.dart';
import 'package:ahbas/model/follow_following/following_list/following.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;

class FollowFollowingProvider extends ChangeNotifier {
  final FolloControlller controller = Get.put(FolloControlller());
  bool isFollowRequestSent = false;
  bool isUnFollowRequestSent = false;
  String followStatus = '';
  ResultFollowerList followersListData =
      ResultFollowerList(followerList: [], isError: false, isLoading: true);
  ResultFollowingList followingListData =
      ResultFollowingList(followingList: [], isError: false, isLoading: true);
  Future sentFollowRequest(
      {required String visitingUserId,
      required socketio.Socket socket,
      required String userName}) async {
    final authToken = await StorageService.instance.readSecureData('AuthToken');
    final currentUserId = convertTokenToId(authToken!);
    final result =
        await FollowFollowingService().sentFollowRequest(visitingUserId);
    isFollowRequestSent = result.fold((l) => false, (r) => true);
    if (isFollowRequestSent) {
      SocketIoService.instance.sendFollowNotification(
          socket,
          visitingUserId,
          currentUserId,
          userName,
          "https://shahidbucketsample.s3.ap-south-1.amazonaws.com/profile-pictures/appstore.png");
    }
    // controller.isFollow.value = isFollowRequestSent;
    notifyListeners();
  }

  Future sentUnFollowRequest({required String visitingUserId}) async {
    final result =
        await FollowFollowingService().sentUnFollowRequest(visitingUserId);
    isUnFollowRequestSent = result.fold((l) => false, (r) => true);
    // controller.isUnFollow.value = isUnFollowRequestSent;

    notifyListeners();
  }

  Future checkFollowStatus({required String visitingUserId}) async {
    controller.checkresult.value = followStatus;
    final result =
        await FollowFollowingService().checkFollowStatus(visitingUserId);
    followStatus = result.fold((l) => 'Failure', (r) => r);
    if (followStatus == 'Neither') {
      log('CheckFollow:isNeither');
      controller.isNeither.value = true;
      controller.isFollower.value = false;
      controller.isFollowing.value = false;
      controller.isBoth.value = false;
      controller.isUnFollow.value = true;
    } else if (followStatus == 'following') {
      log('CheckFollow:isfollowing');
      controller.isNeither.value = false;
      controller.isFollower.value = false;
      controller.isFollowing.value = true;
      controller.isBoth.value = false;
      controller.isUnFollow.value = true;
    } else if (followStatus == "follower") {
      log('CheckFollow:isFollower');
      controller.isNeither.value = false;
      controller.isFollower.value = true;
      controller.isFollowing.value = false;
      controller.isBoth.value = false;
      controller.isUnFollow.value = false;
    } else if (followStatus == 'Both') {
      log('CheckFollow:isBoth');
      controller.isNeither.value = false;
      controller.isFollower.value = false;
      controller.isFollowing.value = false;
      controller.isBoth.value = true;
      controller.isUnFollow.value = false;
    }
    log(followStatus);
    notifyListeners();
  }

  Future getFollowersList({required String visitingUserId}) async {
    final result =
        await FollowFollowingService().getFollowersList(visitingUserId);
    followersListData = result.fold(
        (l) => ResultFollowerList(
            followerList: [], isError: true, isLoading: false),
        (r) => ResultFollowerList(
            followerList: r, isError: false, isLoading: false));
    final FolloControlller controller = Get.put(FolloControlller());
    controller.followerList.value = followersListData.followerList;

// Updating isLoading and isError
    controller.isLoading.value = followersListData.isLoading;
    controller.isError.value = followersListData.isError;
    log("Ierror:${followersListData.isError.toString()}");
    log("IsLoding:${followersListData.isLoading.toString()}");
    log(followersListData.followerList.length.toString());
    log("controllerFollower:${controller.followerList.length.toString()}");

    notifyListeners();
  }

  Future getFollowingList({required String visitingUserId}) async {
    final result =
        await FollowFollowingService().getFollowingList(visitingUserId);
    followingListData = result.fold(
        (l) => ResultFollowingList(
            followingList: [], isError: true, isLoading: false),
        (r) => ResultFollowingList(
            followingList: r, isError: false, isLoading: false));
    controller.followingList.value = followingListData.followingList;
    notifyListeners();
  }
}

class ResultFollowerList {
  final List<Follower> followerList;
  final bool isLoading;
  final bool isError;

  ResultFollowerList(
      {required this.followerList,
      required this.isLoading,
      required this.isError});
}

class ResultFollowingList {
  final List<Following> followingList;
  final bool isLoading;
  final bool isError;

  ResultFollowingList(
      {required this.followingList,
      required this.isLoading,
      required this.isError});
}
