// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/auth_button/auth_button.dart';
import 'package:homesloc/core/widgets/my_form/name_form/password_form.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _newPasswordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
          onPressed: () {
            print('Back button');
          },
          icon: Icon(
            Icons.arrow_back,
            color: black,
            size: 30.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.h, bottom: 55.h),
              child: Center(
                child: Text(
                  'Create New Password ',
                  style: TextStyle(
                      color: black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 28.sp),
                ),
              ),
            ),
            PasswordForm(
              name: "New Password",
              controller: _newPasswordController,
              onSaved: (value) {},
              hintText: 'Enter a new password',
            ),
            SizedBox(
              height: 25.h,
            ),
            PasswordForm(
              name: "Confirm Password",
              controller: _confirmPasswordController,
              onSaved: (value) {},
              hintText: 'Confirm your new password',
            ),
            SizedBox(
              height: 20.h,
            ),
            AuthButton(
              name: 'Submit',
              onPressed: () {
                print('Submit');
              },
            ),
          ],
        ),
      ),
    );
  }
}
