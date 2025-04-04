// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class PasswordForm extends StatelessWidget {
  final String? Function(String?)? validator;
  final String name;
  final String hintText;
  // final IconData? icon;
  // bool obscureText = false;
  // final VoidCallback onPressed;
  final TextEditingController? controller;
  const PasswordForm({
    // required this.obscureText,
    // this.icon,
    required this.name,
    super.key,
    required this.controller,
    this.validator,
    required Null Function(dynamic value) onSaved,
    required this.hintText,
    // required this.onPressed,
    // required this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 8.h,
              // top: 30.h,
              left: 2.w,
            ),
            child: Text(
              name,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.sp,
                  // fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: black),
            ),
          ),
          SizedBox(
            width: 320.w,
            // height: 40.h,
            child: TextFormField(
              validator: validator,
              // obscureText: obscureText,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: grey, fontSize: 13.sp),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: Color(0xffF5F2F2),
                    )),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffF5F2F2),
                    ),
                    borderRadius: BorderRadius.circular(14)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: Color(0xffF5F2F2),
                    )),
                fillColor: Color(0xffF5F2F2),
                filled: true,
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          )
        ],
      ),
    );
  }
}
