import 'package:ahbas/data/follow_following/follow_following_service.dart';
import 'package:ahbas/model/follow_following/followers_list/follower.dart';
import 'package:ahbas/model/follow_following/following_list/following.dart';

import 'package:flutter/material.dart';

class FollowFollowingProvider extends ChangeNotifier {
  bool isFollowRequestSent = false;
  bool isUnFollowRequestSent = false;
  String followStatus = '';
  ResultFollowerList followersListData =
      ResultFollowerList(followerList: [], isError: false, isLoading: true);
  ResultFollowingList followingListData =
      ResultFollowingList(followingList: [], isError: false, isLoading: true);
  Future sentFollowRequest({required String visitingUserId}) async {
    final result =
        await FollowFollowingService().sentFollowRequest(visitingUserId);
    isFollowRequestSent = result.fold((l) => false, (r) => true);

    notifyListeners();
  }

  Future sentUnFollowRequest({required String visitingUserId}) async {
    final result =
        await FollowFollowingService().sentUnFollowRequest(visitingUserId);
    isUnFollowRequestSent = result.fold((l) => false, (r) => true);

    notifyListeners();
  }

  Future checkFollowStatus({required String visitingUserId}) async {
    final result =
        await FollowFollowingService().checkFollowStatus(visitingUserId);
    followStatus = result.fold((l) => 'Failure', (r) => r);

    notifyListeners();
  }

  Future getFollowersList({required String visitingUserId}) async {
    final result = await FollowFollowingService().getFollowersList();
    followersListData = result.fold(
        (l) => ResultFollowerList(
            followerList: [], isError: true, isLoading: false),
        (r) => ResultFollowerList(
            followerList: r, isError: false, isLoading: false));

    notifyListeners();
  }

  Future getFollowingList({required String visitingUserId}) async {
    final result = await FollowFollowingService().getFollowingList();
    followingListData = result.fold(
        (l) => ResultFollowingList(
            followingList: [], isError: true, isLoading: false),
        (r) => ResultFollowingList(
            followingList: r, isError: false, isLoading: false));

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
