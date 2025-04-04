// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class PropertySecondRow extends StatelessWidget {
  const PropertySecondRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
      child: Row(
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
                  image: AssetImage('assets/images/Frame (14).png'),
                  width: 11.w,
                  height: 11.h,
                  color: blue,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Bar',
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
            width: 58.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/Frame (15).png'),
                  width: 12.w,
                  height: 12.h,
                  color: blue,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Gym',
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
            width: 115.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/Frame (16).png'),
                  width: 13.w,
                  height: 13.h,
                  color: blue,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Swimming Pool',
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
