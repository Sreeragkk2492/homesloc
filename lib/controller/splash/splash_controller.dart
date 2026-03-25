import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homesloc/core/common/global_variables.dart';
import 'package:homesloc/screens/auth/sign_in.dart';
import 'package:homesloc/screens/bottom_bar_screen/bottom_bar_screen.dart';

class SplashController extends GetxController {
  final storage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void checkLogin() async {
    // Add a small delay for splash effect
    await Future.delayed(const Duration(seconds: 3));

    String? token = await storage.read(key: "access_token");
    String? storedUserId = await storage.read(key: "user_id");
    String? storedUserName = await storage.read(key: "user_name");

    if (token != null && token.isNotEmpty) {
      // Restore global variables
      accessToken = token;
      if (storedUserId != null) {
        userId = storedUserId;
      }
      if (storedUserName != null) {
        userName = storedUserName;
      }

      Get.offAll(() => BottomBarScreen());
    } else {
      Get.offAll(() => const SignIn());
    }
  }
}
