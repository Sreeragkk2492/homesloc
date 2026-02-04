import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/splash/splash_controller.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/Frame 427320661.png",
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
