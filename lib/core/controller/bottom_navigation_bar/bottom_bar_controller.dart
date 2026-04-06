import 'package:get/get.dart';

class BottomBarController extends GetxController {
  var selectedPageIndex = 0.obs;
  DateTime? lastBackPressed;

  void updateSelectedPageIndex(int index) {
    selectedPageIndex.value = index;
  }
}
