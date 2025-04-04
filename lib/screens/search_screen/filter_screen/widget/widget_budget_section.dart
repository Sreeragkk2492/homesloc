import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/controller/search/filter_controller.dart';
import 'package:homesloc/core/colors/colors.dart';

Widget buildBudgetSection(FilterController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Budget (Per Night)',
            style: TextStyle(
              color: blue,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Center(
              child: Icon(
                Icons.remove,
                size: 16.sp,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 10.h),
      Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Min',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Min',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
      SizedBox(height: 12.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: controller.budgetRanges.map((range) {
          return Text(
            range,
            style: TextStyle(
              color: blue,
              fontSize: 12.sp,
            ),
          );
        }).toList(),
      ),
      SizedBox(height: 10.h),
      Divider(color: Colors.grey.shade300),
    ],
  );
}
