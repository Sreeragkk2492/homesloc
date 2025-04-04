// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class NameView extends StatelessWidget {
  final String name;
  final String secondName;
  final Color color;
  final Color secondColor;
  const NameView(
      {super.key,
      required this.name,
      required this.color,
      required this.secondName,
      required this.secondColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
                fontFamily: 'Poppins',
                color: color,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold),
          ),
          // SizedBox(
          //   width: 30.w,
          // ),
          Container(
            width: 58.w,
            height: 22.h,
            decoration: BoxDecoration(
                color: gwhite, borderRadius: BorderRadius.circular(4.sp)),
            child: Center(
              child: Text(
                secondName,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: secondColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
