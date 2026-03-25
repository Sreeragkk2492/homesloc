// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:homesloc/screens/home/home_screen.dart';

class BookingSuccessful extends StatelessWidget {
  final String hotelName;
  final String location;
  final String price;
  final String checkInDate;
  final String checkOutDate;
  final String coverImage;

  const BookingSuccessful({
    super.key,
    this.hotelName = "Grand Luxury Resort",
    this.location = "Maldives",
    this.price = "2500",
    this.checkInDate = "06 Nov",
    this.checkOutDate = "08 Dec",
    this.coverImage = "assets/images/l1.png",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomBarScreen()),
              (route) => false,
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.sp,
            color: blue,
          ),
        ),
        title: Text(
          "Confirmation",
          style: TextStyle(
            color: blue,
            fontFamily: 'Poppins',
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
            ),
            Center(
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
                height: 350.h,
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
                      'Your booking has been confirmed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: blue,
                          fontFamily: 'Poppins',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      width: 260.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: border),
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 5.w),
                            width: 90.w,
                            height: 85.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13.sp),
                              image: DecorationImage(
                                image: coverImage.startsWith('http')
                                    ? NetworkImage(coverImage)
                                    : AssetImage(coverImage) as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w, top: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hotelName,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          size: 12.sp, color: blue),
                                      SizedBox(width: 4.w),
                                      Expanded(
                                        child: Text(
                                          location,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 9.sp),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "$checkInDate - $checkOutDate",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 9.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomBarScreen()),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                        ),
                        child: Text(
                          "Back to Home",
                          style: TextStyle(color: white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
