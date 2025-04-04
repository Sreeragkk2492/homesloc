// ignore_for_file: file_names, avoid_print, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class AuthButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  const AuthButton({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 320.w,
        height: 48.h,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(blue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.sp),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            name,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11.sp,
                // fontSize: 12,
                fontWeight: FontWeight.bold,
                color: white),
          ),
        ),
      ),
    );
  }
}
