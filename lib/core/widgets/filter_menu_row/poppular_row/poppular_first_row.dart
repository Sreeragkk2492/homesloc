// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class PoppularFirstRow extends StatefulWidget {
  const PoppularFirstRow({super.key});

  @override
  State<PoppularFirstRow> createState() => _PoppularFirstRowState();
}

class _PoppularFirstRowState extends State<PoppularFirstRow> {
  bool isResortsChecked = false;
  bool isBarChecked = false;
  bool isFourStarChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 15.w),
            height: 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.sp),
              border: Border.all(width: 1.w, color: grey),
            ),
            child: Row(
              children: [
                Checkbox(
                  activeColor: yellow,
                  value: isResortsChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isResortsChecked = value!;
                    });
                  },
                ),
                Text(
                  'Resorts',
                  style: TextStyle(
                      color: black,
                      fontSize: 12.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.only(right: 10.w),
            height: 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.sp),
              border: Border.all(width: 1.w, color: grey),
            ),
            child: Row(
              children: [
                Checkbox(
                  activeColor: yellow,
                  value: isBarChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isBarChecked = value!;
                    });
                  },
                ),
                Text(
                  'Bar',
                  style: TextStyle(
                      color: black,
                      fontSize: 12.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 5.w),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.only(right: 15.w),
            height: 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.sp),
              border: Border.all(width: 1.w, color: grey),
            ),
            child: Row(
              children: [
                Checkbox(
                  activeColor: yellow,
                  value: isFourStarChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isFourStarChecked = value!;
                    });
                  },
                ),
                Text(
                  '4 Star',
                  style: TextStyle(
                      color: black,
                      fontSize: 12.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
