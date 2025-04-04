// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class CategoriesView extends StatelessWidget {
  final String image;
  final String categories;
  const CategoriesView(
      {super.key, required this.image, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(
        children: [
          Container(
            height: 70.h,
            width: 70.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            categories,
            style: TextStyle(
                fontFamily: 'Poppins',
                color: black,
                fontSize: 8.sp,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
