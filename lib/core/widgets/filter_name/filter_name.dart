// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class FilterName extends StatelessWidget {
  final String name;
  const FilterName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
                fontFamily: 'Poppins',
                color: blue,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
          ),
          Icon(
            Icons.remove_circle_outline_sharp,
            color: fontColor,
          )
        ],
      ),
    );
  }
}
