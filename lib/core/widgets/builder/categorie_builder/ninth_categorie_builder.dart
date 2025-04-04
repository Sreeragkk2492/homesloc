// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class NinthCategorieBuilder extends StatelessWidget {
  final String image;
  final String location;
  const NinthCategorieBuilder(
      {super.key, required this.image, required this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140.h,
            width: 138.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(image),
                  // image: AssetImage('assets/images/image (17).png'),
                  fit: BoxFit.cover),
              // color: blue,
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 110.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: white,
                    size: 22.sp,
                  ),
                  Text(
                    // 'Wayanad',
                    location,
                    style: TextStyle(
                        color: white, fontFamily: 'Poppins', fontSize: 16.sp),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          // Text(
          //   // 'text',
          //   "Goa is a nice\nplace to chill",
          //   style: TextStyle(
          //       fontFamily: 'Poppins',
          //       fontSize: 15.sp,
          //       fontWeight: FontWeight.w400,
          //       color: black),
          // ),
          // Text(
          //   "Lorance",
          //   style: TextStyle(
          //       color: fontColor,
          //       fontFamily: 'Poppins',
          //       fontWeight: FontWeight.w300,
          //       fontSize: 11.sp),
          // )
        ],
      ),
    );
  }
}
