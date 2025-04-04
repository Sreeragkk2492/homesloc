// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/auth_button/auth_button.dart';
import 'package:homesloc/core/widgets/my_form/name_form/name_form.dart';
import 'package:homesloc/core/widgets/my_form/name_form/password_form.dart';
import 'package:homesloc/screens/auth/otp_varification.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _phnController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        toolbarHeight: 70.h,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Create Account',
            style: TextStyle(
                color: black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 28.sp),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NameForm(
                name: "Name", controller: _nameController, onSaved: (value) {}),
            NameForm(
                name: "Email",
                controller: _emailController,
                onSaved: (value) {}),
            NameForm(
                name: "Phone Number",
                controller: _phnController,
                onSaved: (value) {}),
            SizedBox(
              height: 8.h,
            ),
            PasswordForm(
              name: "Password",
              controller: _passwordController,
              onSaved: (value) {},
              hintText: '',
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 30.h),
              child: Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    activeColor: blue,
                    hoverColor: black,
                    // fillColor: WidgetStateProperty.all(blue),
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
            AuthButton(
              name: 'Sign Up',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OtpVarification();
                }));
                print('Sign Up');
              },
            ),
          ],
        ),
      ),
    );
  }
}
