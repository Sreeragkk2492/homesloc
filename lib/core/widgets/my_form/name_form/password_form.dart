// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class PasswordForm extends StatefulWidget {
  final String? Function(String?)? validator;
  final String name;
  final String hintText;
  final TextEditingController? controller;

  const PasswordForm({
    required this.name,
    super.key,
    required this.controller,
    this.validator,
    required Null Function(dynamic value) onSaved,
    required this.hintText,
  });

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 8.h,
              left: 2.w,
            ),
            child: Text(
              widget.name,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: black),
            ),
          ),
          SizedBox(
            width: 320.w,
            child: TextFormField(
              validator: widget.validator,
              obscureText: _isObscured,
              controller: widget.controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                  icon: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                    color: grey,
                    size: 20.sp,
                  ),
                ),
                hintText: widget.hintText,
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
