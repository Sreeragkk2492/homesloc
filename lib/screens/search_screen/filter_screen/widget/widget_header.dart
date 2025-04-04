import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';

Widget buildHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Filter Search',
        style: TextStyle(
          color: blue,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.close,
          color: blue,
          size: 24.sp,
        ),
      ),
    ],
  );
}
