// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class TransportationsFirstRow extends StatelessWidget {
  const TransportationsFirstRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
      child: Row(
        children: [
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
                  image: AssetImage('assets/images/Frame (25).png'),
                  width: 13.w,
                  height: 13.h,
                  color: blue,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Airport - 9.3 km',
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
            width: 142.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: gwhite,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/Frame (26).png'),
                  width: 13.w,
                  height: 13.h,
                  color: blue,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Metro Station - 3.1 km',
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
