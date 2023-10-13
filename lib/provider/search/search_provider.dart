import 'package:ahbas/data/search/all_user_service.dart';
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
      return SearchResult(isError: false, isLoading: false, allUsersList: r);
    });

    notifyListeners();
  }
}

class SearchResult {
  final List<AllUserData> allUsersList;
  final bool isError;
  final bool isLoading;

  SearchResult(
      {required this.allUsersList,
      required this.isError,
      required this.isLoading});
}
