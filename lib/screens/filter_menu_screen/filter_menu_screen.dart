// ignore_for_file: file_names, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/filter_name/filter_name.dart';
import 'package:homesloc/core/widgets/filter_menu_row/poppular_row/poppular_first_row.dart';

class FilterMenuScreen extends StatelessWidget {
  const FilterMenuScreen({super.key});

  Widget buildFilterChip(String label) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      height: 30.h,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Row(
        children: [
          SizedBox(width: 15.w),
          Text(
            label,
            style: TextStyle(
              color: black,
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 5.w),
          Icon(Icons.clear, size: 16.sp, color: black),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 210.h,
              color: gwhite,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 44.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter Search',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: blue,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.clear, size: 20.sp, color: black),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Selected Filters',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: blue,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Clear all',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.blue,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      buildFilterChip('Location'),
                      buildFilterChip('3 Star'),
                      buildFilterChip('Balcony'),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      buildFilterChip('Pets Allowed'),
                      buildFilterChip('Meals Included'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            FilterName(name: 'Popular Filters'),
            PoppularFirstRow(),
          ],
        ),
      ),
    );
  }
}
