// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class AmenitieRow extends StatelessWidget {
  final dynamic hotel;
  const AmenitieRow({super.key,this.hotel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 50.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/Frame (20).png'),
                  width: 11.w,
                  height: 11.h,
                  color: black,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Wifi',
                  style: TextStyle(
                      color: black, fontFamily: 'Poppins', fontSize: 10.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Container(
            width: 42.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/Frame (22).png'),
                  width: 12.w,
                  height: 12.h,
                  color: black,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'TV',
                  style: TextStyle(
                      color: black, fontFamily: 'Poppins', fontSize: 10.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Container(
            width: 50.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/Frame (23).png'),
                  width: 13.w,
                  height: 13.h,
                  color: black,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'AC',
                  style: TextStyle(
                      color: black, fontFamily: 'Poppins', fontSize: 10.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Container(
            width: 108.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/Frame (24).png'),
                  width: 13.w,
                  height: 13.h,
                  color: black,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Power Backup',
                  style: TextStyle(
                      color: black, fontFamily: 'Poppins', fontSize: 10.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
