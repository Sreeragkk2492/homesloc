// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/login/login_screen_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/loader/app_loader.dart';

import 'package:homesloc/core/widgets/auth_button/auth_button.dart';
import 'package:homesloc/screens/auth/sign_in.dart';
import 'package:homesloc/widgets/custom_snackbar.dart';
import 'package:homesloc/core/widgets/my_form/name_form/name_form.dart';
import 'package:homesloc/core/widgets/my_form/name_form/password_form.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final controller = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          elevation: 0,
          toolbarHeight: 0, // Minimize AppBar height
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      color: black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 28.sp),
                ),
              ),
              SizedBox(height: 20.h),
              Form(
                key: controller.signupFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                NameForm(
                    name: "Username",
                    controller: controller.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                    onSaved: (value) {}),
                NameForm(
                    name: "Email",
                    controller: controller.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    suffix: Obx(() => controller.isEmailVerified.value
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : TextButton(
                            onPressed: () {
                              controller.sendOtp();
                            },
                            child: controller.isOtpLoading.value
                                ? SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: const AppLoader(size: 20))
                                : Text(
                                    'Verify',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        color: blue),
                                  ),
                          )),
                    onSaved: (value) {}),
                NameForm(
                    name: "Phone Number",
                    controller: controller.phoneNumberController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (!value.isNumericOnly) {
                          return 'Please enter valid phone number';
                        }
                      }
                      return null;
                    },
                    prefix: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: controller.countryCode.value,
                            items: controller.countryCodes
                                .map((code) => DropdownMenuItem(
                                      value: code,
                                      child: Text(
                                        code,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14.sp,
                                            color: black),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.countryCode.value = value;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    onSaved: (value) {}),
                SizedBox(
                  height: 8.h,
                ),
                PasswordForm(
                  name: "Password",
                  controller: controller.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {},
                  hintText: '',
                ),
                SizedBox(
                  height: 8.h,
                ),
                PasswordForm(
                  name: "Confirm Password",
                  controller: controller.confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm password';
                    }
                    if (value != controller.passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onSaved: (value) {},
                  hintText: '',
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 30.h),
                  child: Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.isTermsAccepted.value,
                          onChanged: (value) {
                            controller.isTermsAccepted.value = value!;
                          },
                          activeColor: blue,
                          hoverColor: black,
                          // fillColor: WidgetStateProperty.all(blue),
                        ),
                      ),
                      Text(
                        'Agree with ',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Text(
                        'Terms&Condition',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: blue,
                            color: blue),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => controller.isRegisterLoading.value
                      ? const Center(child: AppLoader(size: 40))
                      : AuthButton(
                          name: 'Sign Up',
                          onPressed: () async {
                            if (controller.signupFormKey.currentState!
                                .validate()) {
                              if (!controller.isTermsAccepted.value) {
                                customSnackBar(
                                    "Error", "Please accept Terms & Conditions");
                                return;
                              }
                              await controller.register();
                              if (controller.isRegisterSuccess.value) {
                                customSnackBar(
                                    "Success", controller.registerMessage.value);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignIn();
                                }));
                              } else {
                                customSnackBar(
                                    "Error", controller.registerMessage.value);
                              }
                            }
                          },
                        ),
                ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
