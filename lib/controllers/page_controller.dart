// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class isPageController extends GetxController {
  RxInt liveIndex = 0.obs;
  PageController pageController = PageController();

  int get getIndex {
    return liveIndex.value;
  }

  void changeIndex({required int index}) {
    liveIndex(index);

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }
}
