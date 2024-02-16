import 'dart:developer';

import 'package:ahbas/controller/getx/follow_controller.dart';
import 'package:ahbas/data/profile/current_user.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/model/profile/current_user/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentUserProvider extends ChangeNotifier {
  FolloControlller controlller = Get.put(FolloControlller());
  CurrentUserResult currentUserResult = CurrentUserResult(
    isLoading: true,
    isError: false,
  );
  ///addddd
  Future getCurrentUser() async {
    controlller.authToken.value =
        (await StorageService.instance.readSecureData('AuthToken'))!;
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
    controlller.currentusername.value =
        currentUserResult.currentUser!.username!;
    controlller.currentuserid.value = currentUserResult.currentUser!.id!;
    log("Profile: ${currentUserResult.currentUser!.profilepicture!}");
    log(controlller.currentuserid.value);
    log(controlller.authToken.value);
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
