// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/auth_button/auth_button.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

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
            size: 26.sp,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 30.w),
          child: Text(
            'Payment Method',
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.w),
                    width: 300.w,
                    height: 160.h,
                    decoration: BoxDecoration(
                      color: blue,
                      image: DecorationImage(
                          image: AssetImage('assets/images/visaHomesloc.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.w, right: 10.w),
                    width: 300.w,
                    height: 160.h,
                    decoration: BoxDecoration(
                      color: blue,
                      image: DecorationImage(
                          image: AssetImage('assets/images/visaHomesloc2.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      print('Add new card');
                    },
                    child: Icon(
                      Icons.add_circle_outline_outlined,
                      color: black,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  InkWell(
                    onTap: () {
                      print('Add new card');
                    },
                    child: Text(
                      'Add New Card',
                      style: TextStyle(
                          color: black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.h, left: 20.w),
              child: Text(
                'Other Ways To Pay',
                style: TextStyle(
                    color: black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.w, top: 5.h, bottom: 8.h),
              width: 315.w,
              height: 42.h,
              decoration: BoxDecoration(
                border: Border.all(width: 1.w, color: border),
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: AssetImage('assets/images/Gpay.png'),
                      width: 25.w,
                      height: 25.h,
                    ),
                    Text(
                      'Google Pay',
                      style: TextStyle(
                          color: Color(0xff9D9B9B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp),
                    ),
                    CircleAvatar(
                      radius: 8.sp,
                      backgroundColor: blue,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.w, top: 5.h, bottom: 8.h),
              width: 315.w,
              height: 42.h,
              decoration: BoxDecoration(
                border: Border.all(width: 1.w, color: border),
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: AssetImage('assets/images/Phone pay.png'),
                      width: 25.w,
                      height: 25.h,
                    ),
                    Text(
                      'Phone Pay',
                      style: TextStyle(
                          color: Color(0xff9D9B9B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp),
                    ),
                    CircleAvatar(
                      radius: 8.sp,
                      backgroundColor: grey,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.w, top: 5.h, bottom: 8.h),
              width: 315.w,
              height: 42.h,
              decoration: BoxDecoration(
                border: Border.all(width: 1.w, color: border),
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: AssetImage('assets/images/Paytm.png'),
                      width: 25.w,
                      height: 25.h,
                    ),
                    Text(
                      'Paytm',
                      style: TextStyle(
                          color: Color(0xff9D9B9B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp),
                    ),
                    CircleAvatar(
                      radius: 8.sp,
                      backgroundColor: grey,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 110.h,
            ),
            Center(
              child: Text(
                'Amount To Pay ₹8500',
                style: TextStyle(
                    color: black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            AuthButton(
                name: 'Proceed to Pay',
                onPressed: () {
                  print('Proceed to Pay');
                })
          ],
        ),
      ),
    );
  }
}
