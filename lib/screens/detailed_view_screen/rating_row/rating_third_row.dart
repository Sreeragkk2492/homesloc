// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class RatingThirdRow extends StatelessWidget {
  const RatingThirdRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
      child: Row(
        children: [
          Container(
            width: 133.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 7.w,
                ),
                Text(
                  'Value Of Money',
                  style: TextStyle(
                      color: black, fontFamily: 'Poppins', fontSize: 11.sp),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  width: 28.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 98, 165, 194).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Center(
                    child: Text(
                      '8.9',
                      style: TextStyle(
                          color: blue, fontFamily: 'Poppins', fontSize: 10.sp),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 6.w,
          ),
          Container(
            width: 90.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 7.w,
                ),
                Text(
                  'Comfort',
                  style: TextStyle(
                      color: black, fontFamily: 'Poppins', fontSize: 11.sp),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  width: 28.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 98, 165, 194).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Center(
                    child: Text(
                      '7.3',
                      style: TextStyle(
                          color: blue, fontFamily: 'Poppins', fontSize: 10.sp),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
