import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/login/login_screen_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/auth_button/auth_button.dart';
import 'package:homesloc/screens/auth/sign_in.dart';
import 'package:pinput/pinput.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final focusNode = FocusNode();

  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  Timer? _timer;
  int _start = 600; // 10 minutes in seconds

  void startTimer() {
    _timer?.cancel();
    _start = 600;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginScreenController>();

    final defaultPinTheme = PinTheme(
      width: 45.w,
      height: 45.h,
      textStyle:
          TextStyle(fontSize: 18.sp, color: black, fontFamily: 'Poppins'),
      decoration: BoxDecoration(
        color: const Color(0xffF5F2F2),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: controller.resetPasswordFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Change Password',
                  style: TextStyle(
                      color: black,
                      fontSize: 24.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5.h),
              Center(
                child: Text(
                  'Enter the 6-digit code and your new password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'Poppins',
                      color: Colors.grey[600]),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'Code sent to ${controller.forgotEmailController.text}',
                style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: black),
              ),
              SizedBox(height: 15.h),
              Center(
                child: Pinput(
                  length: 6,
                  controller: controller.resetOtpController,
                  focusNode: focusNode,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => SizedBox(width: 8.w),
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Please enter 6-digit OTP';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 25.h),
              _buildLabel("New Password"),
              _buildPasswordField(
                controller: controller.resetNewPasswordController,
                hint: "Enter new password",
                isVisible: isNewPasswordVisible,
                onToggle: () => setState(
                    () => isNewPasswordVisible = !isNewPasswordVisible),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.h),
              _buildLabel("Confirm New Password"),
              _buildPasswordField(
                controller: controller.resetConfirmPasswordController,
                hint: "Confirm new password",
                isVisible: isConfirmPasswordVisible,
                onToggle: () => setState(
                    () => isConfirmPasswordVisible = !isConfirmPasswordVisible),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != controller.resetNewPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.h),
              Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : AuthButton(
                        name: 'Change Password',
                        onPressed: () async {
                          if (controller.resetPasswordFormKey.currentState!
                              .validate()) {
                            bool success =
                                await controller.resetPasswordWithToken(
                              otp: controller.resetOtpController.text,
                              newPassword:
                                  controller.resetNewPasswordController.text,
                              confirmPassword: controller
                                  .resetConfirmPasswordController.text,
                            );
                            if (success && context.mounted) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const SignIn();
                              }));
                            }
                          }
                        },
                      ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: const Color(0xff003D4C),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Change email',
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _start > 0
                              ? "Resend in ${formatTime(_start)}"
                              : "Resend code",
                          style: TextStyle(
                              color: _start > 0 ? Colors.grey : blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: RichText(
        text: TextSpan(
          text: '* ',
          style:
              const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: text,
              style: TextStyle(
                  color: black,
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF5F2F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: !isVisible,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: grey, fontSize: 13.sp),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
          suffixIcon: IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: grey,
              size: 20.sp,
            ),
            onPressed: onToggle,
          ),
        ),
      ),
    );
  }
}
