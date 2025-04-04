// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 334.w,
      // height: 40.h,
      child: TextFormField(
        onChanged: (value) {},
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: white,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: white,
          ),
          hintText: 'search property or location ...',
          hintStyle: TextStyle(
              fontFamily: 'Poppins',
              color: poppinsFont,
              fontSize: 13.sp,
              fontWeight: FontWeight.w100),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(color: gblue),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: gblue),
            borderRadius: BorderRadius.circular(10.sp),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(color: gblue),
          ),
          fillColor: gblue,
          filled: true,
        ),
      ),
    );
  }
}
