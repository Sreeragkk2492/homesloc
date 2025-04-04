// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class YellowStar extends StatelessWidget {
  const YellowStar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 33.h,
      right: 31.w,
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: yellow,
            size: 18.sp,
          ),
          Icon(
            Icons.star,
            color: yellow,
            size: 18.sp,
          ),
          Icon(
            Icons.star,
            color: yellow,
            size: 18.sp,
          ),
          Icon(
            Icons.star,
            color: yellow,
            size: 18.sp,
          ),
          Icon(
            Icons.star,
            color: grey,
            size: 18.sp,
          )
        ],
      ),
    );
  }
}
