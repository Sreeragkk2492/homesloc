// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class RatingSecondRow extends StatelessWidget {
  const RatingSecondRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 8.h),
      child: Row(
        children: [
          Container(
            width: 92.w,
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
                  'Location',
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
                      '6.9',
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
            width: 93.w,
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
                  'Dealings',
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
          SizedBox(
            width: 6.w,
          ),
          Container(
            width: 59.w,
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
                  'Food',
                  style: TextStyle(
                      color: black, fontFamily: 'Poppins', fontSize: 11.sp),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  width: 16.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 98, 165, 194).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Center(
                    child: Text(
                      '8',
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
