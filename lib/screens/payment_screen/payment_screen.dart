// ignore_for_file: file_names, avoid_print, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/book_now/book_now.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/pay_now/pay_now.dart';

class PaymentSreen extends StatelessWidget {
  const PaymentSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: white,
        leading: Icon(
          (Icons.arrow_back_ios_new_rounded),
          size: 20.sp,
          color: blue,
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 40.w),
          child: Text(
            "Confirm & Pay",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: blue,
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
            Container(
              margin: EdgeInsets.only(
                  top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
              width: 339.w,
              height: 130.h,
              decoration: BoxDecoration(
                color: white,
                // border: Border.all(color: border),
                borderRadius: BorderRadius.circular(15.sp),
                boxShadow: [
                  BoxShadow(
                    color: fontColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5.w, top: 1.h),
                    width: 144.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.sp),
                      image: DecorationImage(
                          image: AssetImage('assets/images/image (33).png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 11.h),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.s,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Issacs Residency",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            Image(
                              image: AssetImage('assets/images/Frame (8).png'),
                              width: 15.w,
                              height: 15.h,
                              color: blue,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              "Munnar, Kerala",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 15.h,
                              decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(3.sp),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "4.2",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: white,
                                        fontSize: 10.sp),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: yellow,
                                    size: 12.sp,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "835 Reviews",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: fontColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "2 Adult  |   1 Children",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: black,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 14.h, left: 10.w, bottom: 5.h, right: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Billing Details',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: blue,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Dates",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                  Text(
                    "November 06, 2024 - December 08 2024",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: fontColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    "Guests",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                  Text(
                    "2 Adult   |  1 Child",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: fontColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            HomeDivider(),
            Padding(
              padding: EdgeInsets.only(
                  top: 5.h, left: 10.w, bottom: 5.h, right: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: blue,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Pay In Full",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                  Text(
                    "Pay the total now and you are all set.",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: fontColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Advance / Pay Later",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                  Text(
                    "Pay part now and  your are all set.",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: fontColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Payment Method",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5.w),
                        width: 50.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.sp),
                          image: DecorationImage(
                              image: AssetImage('assets/images/Picture.png'),
                              fit: BoxFit.cover),
                          // color: blue,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5.w),
                        width: 50.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.sp),
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/Picture (1).png'),
                              fit: BoxFit.cover),
                          // color: blue,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5.w),
                        width: 50.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.sp),
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/Picture (2).png'),
                              fit: BoxFit.cover),
                          // color: blue,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5.w),
                        width: 50.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.sp),
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/Picture (3).png'),
                              fit: BoxFit.cover),
                          // color: blue,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20.w),
                        width: 50.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.sp),
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/Picture (4).png'),
                              fit: BoxFit.cover),
                          // color: blue,
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(right: 10.w),
                        width: 50.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: gwhite,
                          borderRadius: BorderRadius.circular(13.sp),
                        ),
                        child: Center(
                          child: Text(
                            'Add',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: blue,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            PayNow(),
          ],
        ),
      ),
    );
  }
}
