// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/apis/login/login_api.dart';
import 'package:homesloc/controller/login/login_screen_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/auth_button/auth_button.dart';
import 'package:homesloc/core/widgets/divider_up/divider_up.dart';
import 'package:homesloc/core/widgets/my_form/name_form/name_form.dart';
import 'package:homesloc/core/widgets/my_form/name_form/password_form.dart';
import 'package:homesloc/screens/auth/sign_up.dart';
import 'package:homesloc/screens/bottom_bar_screen/bottom_bar_screen.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    LoginScreenController screenController = LoginScreenController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: EdgeInsets.only(top: 96.h, bottom: 48.h),
            //   child: Center(
            //     child: Text(
            //       'Sign In',
            //       style: TextStyle(
            //           color: black,
            //           fontFamily: 'Poppins',
            //           fontWeight: FontWeight.bold,
            //           fontSize: 35.sp),
            //     ),
            //   ),
            // ),
            NameForm(
                name: "Email",
                controller: _emailController,
                onSaved: (value) {}),
            PasswordForm(
              name: "Password",
              controller: _passwordController,
              onSaved: (value) {},
              hintText: '',
            ),
            Padding(
              padding: EdgeInsets.only(right: 23.w, top: 3.h, bottom: 80.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      print('Forgot Password');
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

            AuthButton(
              name: 'Sign In',
              onPressed: () async {
                screenController.isLoading(true);
                final login = await loginApi(
                    username: _emailController.text,
                    password: _passwordController.text);
                screenController.isLoading(false);
                if (login.message == "Login successful") {
                  Get.off(() => BottomBarScreen());
                } else {
                  screenController.isAuthFailed(true);
                  screenController.message(login.message);
                  print(login.message);
                }
              },
            ),
            SizedBox(
              height: 28.h,
            ),
            DividerUp(name: 'Or sign in with'),
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
    );
  }
}
