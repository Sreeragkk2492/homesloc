// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class ViewAllButton extends StatelessWidget {
  const ViewAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        width: 230.w,
        height: 40.h,
        decoration: BoxDecoration(
            color: yellow, borderRadius: BorderRadius.circular(22.sp)),
        child: Center(
          child: Text(
            "View More",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: black,
                fontSize: 15.sp,
                fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }
}
