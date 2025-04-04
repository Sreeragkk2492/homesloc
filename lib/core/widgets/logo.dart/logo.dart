import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Row(
            children: [
              Container(
                height: 20.h,
                width: 139.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/Frame 427320661.png',
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(5.sp),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
