// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/login/login_screen_controller.dart';
import 'package:homesloc/screens/auth/forgot_password.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/loader/app_loader.dart';

import 'package:homesloc/core/widgets/auth_button/auth_button.dart';
import 'package:homesloc/core/widgets/my_form/name_form/name_form.dart';
import 'package:homesloc/core/widgets/my_form/name_form/password_form.dart';
import 'package:homesloc/screens/auth/sign_up.dart';
import 'package:homesloc/screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginScreenController());

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          toolbarHeight: 150.h,
          title: Center(
            child: Text(
              'Sign In',
              style: TextStyle(
                  color: black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 35.sp),
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NameForm(
                    name: "Username",
                    controller:
                        controller.usernameController, // Bind to controller
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                    onSaved: (value) {}),
                PasswordForm(
                  name: "Password",
                  controller: controller.passwordController, // Bind to controller
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  onSaved: (value) {},
                  hintText: '',
                ),
                Padding(
                  padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 3.h, bottom: 80.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          final Uri url = Uri.parse('https://master.d2fzbvgha1hgjd.amplifyapp.com/');
                          if (!await launchUrl(url)) {
                            Get.snackbar(
                              "Error",
                              "Could not launch the link",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        child: Text(
                          "Provider Login",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: black,
                              color: black),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const ForgotPassword());
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: black,
                              color: black),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => controller.isLoading.value
                      ? const Center(child: AppLoader(size: 40))
                      : AuthButton(
                          name: 'Sign In',
                          onPressed: () async {
                            if (controller.loginFormKey.currentState!
                                .validate()) {
                              await controller.login();
                              if (!controller.isAuthFailed.value) {
                                // Assuming login() successful if isAuthFailed is false
                                // Can verify specific message if needed, but isAuthFailed is cleaner
                                Get.off(() => BottomBarScreen());
                              } else {
                                // Error is handled in controller and message updated
                                // Could show snackbar here too if not in controller
                              }
                            }
                          },
                        ),
                ),
                SizedBox(
                  height: 28.h,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 23.w),
                    child: Obx(
                      () => controller.isGoogleLoading.value
                          ? const Center(child: AppLoader(size: 40))
                          : OutlinedButton(
                              onPressed: () => controller.signInWithGoogle(),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: white,
                                side: BorderSide(color: black.withOpacity(0.1)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                minimumSize: Size(double.infinity, 48.h),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/logos/google_g.png',
                                    height: 20.h,
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    'Continue With Google',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?  ',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUp();
                        }));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: blue,
                            color: blue),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
