// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/builder_users/builder_user.dart';

class SecondSearchBuilder extends StatelessWidget {
  const SecondSearchBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: secondUser.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(left: 10.w, right: 9.w, top: 5.h),
          child: Stack(
            children: [
              Container(
                width: 170.w,
                height: 120.h,
                decoration: BoxDecoration(
                  // color: black,
                  image: DecorationImage(
                      image: AssetImage(secondUser[index].img),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 13.w, top: 18.h),
                  child: Text(
                    secondUser[index].category,
                    style: TextStyle(
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.bold,
                        color: white),
                  ),
                ),
              ),
              Positioned(
                bottom: 20.h,
                right: 18.w,
                child: CircleAvatar(
                  backgroundColor: yellow,
                  radius: 23.sp,
                  child: Icon(
                    Icons.arrow_outward_outlined,
                    color: white,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
