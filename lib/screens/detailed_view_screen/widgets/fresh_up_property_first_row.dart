import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class FreshUpPropertyFirstRow extends StatelessWidget {
  final String? yearBuild;
  final String? starRating;
  final String? yearRenovated;

  const FreshUpPropertyFirstRow({
    super.key,
    this.yearBuild,
    this.starRating,
    this.yearRenovated,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPropertyItem(
            icon: Icons.calendar_today,
            title: 'Year Built',
            value: yearBuild ?? 'N/A',
          ),
          _buildPropertyItem(
            icon: Icons.star,
            title: 'Star Rating',
            value: starRating ?? 'N/A',
          ),
          _buildPropertyItem(
            icon: Icons.construction,
            title: 'Year Renovated',
            value: yearRenovated ?? 'N/A',
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: blue,
          size: 24.sp,
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: fontColor,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
} 