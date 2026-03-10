import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/login/login_screen_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/loader/app_loader.dart';
import 'package:homesloc/core/widgets/auth_button/auth_button.dart';
import 'package:homesloc/core/widgets/my_form/name_form/name_form.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginScreenController>();

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        toolbarHeight: 150.h,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
        title: Text(
          'Forgot Password',
          style: TextStyle(
              color: black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 28.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.forgotPasswordFormKey,
          child: Column(
            children: [
              SizedBox(height: 40.h),
              NameForm(
                name: "Email Address",
                controller: controller.forgotEmailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              SizedBox(height: 30.h),
              Obx(
                () => controller.isLoading.value
                    ? const Center(child: AppLoader(size: 40))
                    : AuthButton(
                        name: 'Send Verification Code',
                        onPressed: () {
                          if (controller.forgotPasswordFormKey.currentState!
                              .validate()) {
                            controller.requestPasswordReset();
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
