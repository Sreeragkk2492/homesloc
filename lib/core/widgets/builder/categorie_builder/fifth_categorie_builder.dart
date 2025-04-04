// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class FifthCategorieBuilder extends StatelessWidget {
  final String image;
  final String text;
  final String subname;
  const FifthCategorieBuilder(
      {super.key, required this.image, required this.text,required this.subname});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100.h,
            width: 170.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image),
                    // image: AssetImage('assets/images/image (17).png'),
                    fit: BoxFit.cover),
                // color: blue,
                borderRadius: BorderRadius.circular(10.sp)),
          ),
          Text(
            text,
            // "The Pandemic\nGateway",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: black),
          ),
          Text(
            subname,
            style: TextStyle(
                color: fontColor,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}
