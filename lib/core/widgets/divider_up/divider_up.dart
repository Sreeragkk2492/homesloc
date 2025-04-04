// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class DividerUp extends StatelessWidget {
  final String name;
  const DividerUp({
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            indent: 18.h,
            endIndent: 8.h,
            color: grey,
            thickness: 1.sp,

          ),
        ),
        Text(
          name,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 9.sp,
              // fontSize: 12,
              fontWeight: FontWeight.bold,
              color: black),
        ),
        Expanded(
          child: Divider(
            indent: 8.h,
            endIndent: 18.h,
            thickness: 1.sp,
            color: grey,
          ),
        ),
      ],
    );
  }
}
