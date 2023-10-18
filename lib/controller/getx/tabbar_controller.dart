import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController {
  List<int> tabindex = [
    0,
    1,
    2,
    3,
    4,
  ].obs;
  RxList<String> genderList = <String>[
    'male',
    'female',
    'unspecified',
  ].obs;

  // Rx variable to hold the selected dropdown value
  RxString selectedGender = 'male'.obs;
  RxString dob = 'YYYY MM DD'.obs;

  // Method to update the selected gender
  void setSelectedGender(String gender) {
    selectedGender.value = gender;
  }

  final registerPhoneemailvalidate = RxBool(false);
  final registerPhonedobvalidate = RxBool(false);
  final registerPhonenamevalidate = RxBool(false);
  final registerPhonepasswordvalidate = RxBool(false);
  final registerPhonerepasswordvalidate = RxBool(false);
  final registerPhonedateformatvalidate = RxBool(false);
  final loginphonepasswordvalidate = RxBool(false);
  final loginemailpasswordvalidate = RxBool(false);
  final loginphonevalidate = RxBool(false);
  final loginEmailvalidate = RxBool(false);
  final registerEmaildateformatvalidate = RxBool(false);
  final registerEmailemailvalidate = RxBool(false);
  final registerEmaildobvalidate = RxBool(false);
  final registerEmailnamevalidate = RxBool(false);
  final registerEmailpasswordvalidate = RxBool(false);
  final registerEmailrepasswordvalidate = RxBool(false);

  var currentindex = 3.obs;
  void updatePage(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 3),
      curve: Curves.easeInOut,
    );
    currentindex.value = index;
    print(currentindex.value);
  }

  PageController pageController = PageController(initialPage: 3);
}
