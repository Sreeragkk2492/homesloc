import 'package:get/get.dart';

class BottomBarController extends GetxController {
  var selectedPageIndex = 0.obs;

  void updateSelectedPageIndex(int index) {
    selectedPageIndex.value = index;
  }
}
