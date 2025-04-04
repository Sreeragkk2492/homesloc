// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';

import '../../../controller/calender_controller.dart';
import '../../../controller/home/home_screen_controller.dart';
import '../../../core/controller/bottom_navigation_bar/bottom_bar_controller.dart';
import '../../search_screen/search_screen.dart';

class SearchButton extends StatelessWidget {
   SearchButton({super.key});

  // For navigating to search screen

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        width: 230.w,
        height: 60.h,
        decoration: BoxDecoration(
            color: yellow, borderRadius: BorderRadius.circular(22.sp)),
        child: Center(
          child: Text(
            "Search",
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
