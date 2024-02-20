import 'dart:io';

import 'package:ahbas/data/profile/add_profile_pic_service.dart';

import 'package:flutter/material.dart';

class AddProfilePicProvider extends ChangeNotifier {
    bool isAddedProfilePic=false;
  Future updateImage({required File profilePic}) async {
    final result = await AddProfilePicService().addProfilePic(profilePic);
    isAddedProfilePic = result.fold((l) => false, (r) => true);

    notifyListeners();
  }
}
