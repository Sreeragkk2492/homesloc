import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/filter_controller.dart';
import 'package:homesloc/core/colors/colors.dart';

Widget buildSectionWithToggle(
    String title, RxMap<String, bool> items, FilterController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
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
      Obx(() => Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: items.entries.map((entry) {
              return GestureDetector(
                onTap: () {
                  controller.toggleFilter(title, entry.key);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 18.w,
                        height: 18.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: entry.value ? yellow : Colors.white,
                          border: entry.value
                              ? null
                              : Border.all(color: Colors.grey),
                        ),
                        child: entry.value
                            ? Icon(
                                Icons.check,
                                size: 14.sp,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        entry.key,
                        style: TextStyle(
                          color: const Color(0xFF0B3954),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          )),
      if (title == 'Room Facilities' || title == 'Property Type')
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Row(
            children: [
              Text(
                'Show more',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14.sp,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.blue,
                size: 18.sp,
              ),
            ],
          ),
        ),
      if (title != 'Rating')
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Divider(color: Colors.grey.shade300),
        ),
    ],
  );
}
