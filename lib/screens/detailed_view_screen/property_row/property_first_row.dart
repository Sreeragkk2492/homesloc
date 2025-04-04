// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class PropertyFirstRow extends StatelessWidget {
  const PropertyFirstRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          Container(
            width: 90.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/Frame (11).png'),
                  width: 11.w,
                  height: 11.h,
                  color: blue,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Garden view',
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
            width: 80.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/Frame (12).png'),
                  width: 13.w,
                  height: 13.h,
                  color: blue,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Terrace',
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
            width: 80.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/Frame (13).png'),
                  width: 13.w,
                  height: 13.h,
                  color: blue,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'River view',
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
