// ignore_for_file: file_names, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Search Icon');
      },
      child: Container(
        decoration: BoxDecoration(
          color: yellow,
          borderRadius: BorderRadius.circular(5.sp),
        ),
        height: 38.h,
        width: 48.w,
        // color: yellow,
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/Frame (3).png'),
              width: 25,
              height: 25.h,
              color: blue,
            ),
            Text(
              'Search',
              style: TextStyle(
                color: blue,
                fontFamily: 'Poppins',
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
