import 'package:ahbas/data/search/all_user_service.dart';
import 'package:ahbas/model/follow_following/followers_list/follower.dart';
import 'package:ahbas/model/search/all_users/datum.dart';

import 'package:flutter/material.dart';

class SearchPrvider extends ChangeNotifier {
  SearchResult resultData =
      SearchResult(isError: false, isLoading: true, allUsersList: []);
  Future getAllUsers() async {
    final result = await AllUserService().getAllUers();
    resultData = result.fold(
        (l) => SearchResult(isError: true, isLoading: false, allUsersList: []),
        (r) {
      return SearchResult(
          isError: false,
          isLoading: false,
          allUsersList: convertAllUserToUserDTO(r));
    });

    notifyListeners();
  }
}

class SearchResult {
  final List<UserDTO> allUsersList;
  final bool isError;
  final bool isLoading;

  SearchResult(
      {required this.allUsersList,
      required this.isError,
      required this.isLoading});
}

class UserDTO {
  final String userName;
  final String userId;
  final String profilePic;
  final List<dynamic>? followers;
  final List<dynamic>? following;

  UserDTO(
      {required this.userName,
      required this.userId,
      required this.profilePic,
      required this.followers,
      required this.following});
}

List<UserDTO> convertAllUserToUserDTO(List<AllUserData> allUserList) {
  List<UserDTO> userList = [];
  for (var data in allUserList) {
    userList.add(UserDTO(
      userName: data.username ??= '',
      userId: data.id ??= '',
      profilePic: data.profilepicture ??= '',
      followers: data.followers ??= [],
      following: data.following ??= [],
    ));
  }
  return userList;
}
