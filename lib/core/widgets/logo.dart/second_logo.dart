// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondLog extends StatelessWidget {
  const SecondLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Row(
            children: [
              Container(
                height: 15.h,
                width: 140.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/Group.png',
                      ),
                      fit: BoxFit.cover),
                  // borderRadius: BorderRadius.circular(5.sp),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
