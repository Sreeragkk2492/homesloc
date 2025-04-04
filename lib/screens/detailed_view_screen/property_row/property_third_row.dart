// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class ProperyThirdRow extends StatelessWidget {
  const ProperyThirdRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
      child: Row(
        children: [
          Container(
            width: 70.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/Frame (17).png'),
                  width: 11.w,
                  height: 11.h,
                  color: blue,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Grilling',
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
            width: 72.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/Frame (18).png'),
                  width: 12.w,
                  height: 12.h,
                  color: blue,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Medical',
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
            width: 88.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/Frame (19).png'),
                  width: 13.w,
                  height: 13.h,
                  color: blue,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Breakfast',
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
