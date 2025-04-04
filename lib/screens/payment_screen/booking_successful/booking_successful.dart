// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:homesloc/screens/home/home_screen.dart';

class BookingSuccessful extends StatelessWidget {
  const BookingSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 215.h,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BottomBarScreen();
              }));
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(20.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                width: 280.w,
                height: 270.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Image(
                        image: AssetImage('assets/images/Vector (8).png'),
                        width: 50.w,
                        height: 50.h,
                        color: green,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Booking Successful',
                      style: TextStyle(
                          color: blue,
                          fontFamily: 'Poppins',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Booking Successful',
                      style: TextStyle(
                          color: blue,
                          fontFamily: 'Poppins',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 5.h, left: 10.w, right: 10.w, bottom: 10.h),
                      width: 260.w,
                      height: 95.h,
                      decoration: BoxDecoration(
                        // color: white,
                        border: Border.all(color: border),
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 5.w, top: 1.h),
                            width: 106.w,
                            height: 85.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13.sp),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/image (33).png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w, top: 8.h),
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
                                      fontSize: 12.sp),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/Frame (8).png'),
                                      width: 12.w,
                                      height: 12.h,
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
                                          fontSize: 9.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  "06 Nov - 08 Dec",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 9.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
