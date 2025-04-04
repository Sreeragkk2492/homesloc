import 'package:get/get.dart';

class BottomBarController extends GetxController {
  var selectedPageIndex = 2.obs;

  void updateSelectedPageIndex(int index) {
    selectedPageIndex.value = index;
  }
}
