import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/splash/splash_controller.dart';
import 'package:homesloc/core/colors/colors.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: blue,
      body: Center(
        child: Image.asset(
          "assets/images/Group 4.png",
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
