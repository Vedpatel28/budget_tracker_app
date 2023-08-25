import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxInt currentIndex = (-1).obs;
  RxString currentType = "INCOME".obs;

  selectIndex({required int index}) {
    currentIndex(index);
  }

  changType({required String type}) {
    currentType(type);
  }
}
