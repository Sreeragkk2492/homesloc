// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class NameForm extends StatelessWidget {
  final String? Function(String?)? validator;
  final String name;
  // final IconData? icon;
  // bool obscureText = false;
  // final VoidCallback onPressed;
  final TextEditingController? controller;
  const NameForm({
    // required this.obscureText,
    // this.icon,
    required this.name,
    super.key,
    required this.controller,
    this.validator,
    required Null Function(dynamic value) onSaved,
    // required this.onPressed,
    // required this.obscureText
    this.suffix,
    this.prefix,
  });

  final Widget? suffix;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 8.h,
              top: 10.h,
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
            // height: 8.h,
            child: TextFormField(
              validator: validator,
              // obscureText: obscureText,
              controller: controller,
              decoration: InputDecoration(
                helperText: '',
                suffixIcon: suffix,
                prefixIcon: prefix,
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
