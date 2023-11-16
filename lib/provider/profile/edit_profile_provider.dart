import 'package:ahbas/data/profile/edit_profile_service.dart';
import 'package:ahbas/model/profile/edit_profile/edit_profile.dart';
import 'package:flutter/material.dart';

class EditProfileProvider extends ChangeNotifier {
  bool isProfileEditted = true;

  Future editProfile(
      {required String email,
      required String gender,
      required String username}) async {
    final EditProfile editProfile =
        EditProfile(email: email, gender: gender, username: username);
    final result = await EditProfileService().editProfile(editProfile);
    print(result.toString());
    isProfileEditted = result.fold((l) => false, (r) {
      return true;
    });

    notifyListeners();
  }
}
