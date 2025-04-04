// ignore_for_file: file_names, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class NewNavigation extends StatelessWidget {
  final String name;
  final String icon;
  final Color iconColor;
  final Color nameColor;
  const NewNavigation(
      {super.key,
      required this.name,
      required this.icon,
      required this.iconColor,
      required this.nameColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage(icon),
          width: 25,
          height: 25.h,
          color: iconColor,
        ),
        Text(
          name,
          style: TextStyle(
            color: nameColor,
            fontFamily: 'Poppins',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
