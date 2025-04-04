// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';

class CategorieViewBuilder extends StatelessWidget {
  final String image;

  const CategorieViewBuilder({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 340.w,
              height: 155.h,
              decoration: BoxDecoration(
                // color: black,
                borderRadius: BorderRadius.circular(13.sp),
                image: DecorationImage(
                    image: AssetImage(image),
                    // image: AssetImage('assets/images/image (29).png'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "The Pandemic Gateway",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp),
              ),
              Container(
                width: 35.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.circular(3.sp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "4.2",
                      style: TextStyle(
                          fontFamily: 'Poppins', color: white, fontSize: 10.sp),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Icon(
                      Icons.star,
                      color: yellow,
                      size: 13.sp,
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Munnar Hill Station, Munnar ",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: fontColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 11.sp),
              ),
              Text(
                "835 Reviews",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: fontColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 11.sp),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "₹8000",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp),
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                "₹10000",
                style: TextStyle(
                    fontFamily: 'Poppins', color: fontColor, fontSize: 11.sp),
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                "20% OFF",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: green,
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(
                width: 88.w,
              ),
              Text(
                "Amenities : ",
                style: TextStyle(
                    fontFamily: 'Poppins', color: fontColor, fontSize: 11.sp),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, top: 2.h, right: 3.w),
                child: Icon(
                  Icons.ac_unit_rounded,
                  size: 11.sp,
                  color: fontColor,
                ),
              ),
              Text(
                "Ac",
                style: TextStyle(
                    fontFamily: 'Poppins', color: fontColor, fontSize: 11.sp),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "+ ₹150 Taxes & Fees",
                style: TextStyle(
                    fontFamily: 'Poppins', color: fontColor, fontSize: 11.sp),
              ),
              Padding(
                padding: EdgeInsets.only(left: 153.w, top: 2.h, right: 3.w),
                child: Icon(Icons.tv, size: 11.sp, color: fontColor),
              ),
              Text(
                "Tv",
                style: TextStyle(
                    fontFamily: 'Poppins', color: fontColor, fontSize: 11.sp),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Text(
                  "more...",
                  style: TextStyle(
                      fontFamily: 'Poppins', color: ogBlue, fontSize: 11.sp),
                ),
              ),
            ],
          ),
          HomeDivider()
        ],
      ),
    );
  }
}
