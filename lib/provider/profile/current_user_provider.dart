import 'package:ahbas/data/profile/current_user.dart';
import 'package:ahbas/model/profile/current_user/user.dart';
import 'package:flutter/material.dart';

class CurrentUserProvider extends ChangeNotifier {
  CurrentUserResult currentUserResult = CurrentUserResult(
    isLoading: true,
    isError: false,
  );
  Future getCurrentUser() async {
    final result = await CurrentUserService().getCurrentUser();
    currentUserResult = result.fold(
        (l) => CurrentUserResult(
              isLoading: false,
              isError: true,
            ), (r) {
      if (r.status == 'true' && r.user != null) {
        return CurrentUserResult(
            isLoading: false, isError: false, currentUser: r.user);
      } else {
        return CurrentUserResult(
          isLoading: false,
          isError: true,
        );
      }
    });

    notifyListeners();
  }
}

class CurrentUserResult {
  final bool isLoading;
  final bool isError;
  final User? currentUser;

  CurrentUserResult(
      {required this.isLoading, required this.isError, this.currentUser});
}
