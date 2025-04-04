// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/auth_button/auth_button.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        leading: IconButton(
          onPressed: () {
            print('Back button');
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: black,
            size: 22.sp,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 63.w),
          child: Text(
            'Checkout',
            style: TextStyle(
                color: black,
                fontFamily: 'Poppins',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.h,
            ),
            Center(
              child: Icon(
                Icons.check_circle,
                size: 250.sp,
                color: blue,
              ),
            ),
            Center(
              child: Text(
                'Payment Successful!',
                style: TextStyle(
                    color: blue,
                    fontFamily: 'Poppins',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            AuthButton(
              name: 'Continue',
              onPressed: () {
                print('Continue button');
              },
            )
          ],
        ),
      ),
    );
  }
}
