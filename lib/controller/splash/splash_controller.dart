import 'package:flutter/foundation.dart';
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

    try {
      String? token = await storage
          .read(key: "access_token")
          .timeout(const Duration(seconds: 5));
      String? storedUserId = await storage
          .read(key: "user_id")
          .timeout(const Duration(seconds: 5));
      String? storedUserName = await storage
          .read(key: "user_name")
          .timeout(const Duration(seconds: 5));

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
    } catch (e) {
      debugPrint("Error reading secure storage: $e");
      // If storage fails/hangs (common on tablets), navigate to sign in
      Get.offAll(() => const SignIn());
    }
  }
}
