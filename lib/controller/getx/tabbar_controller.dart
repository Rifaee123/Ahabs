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
