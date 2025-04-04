// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/builder_users/builder_user.dart';

class ThirdSearchBuilder extends StatelessWidget {
  const ThirdSearchBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: thirdUser.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: 4.h, top: 15.h, left: 10.w, right: 9.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 170.w,
                height: 120.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  // color: yellow,
                  image: DecorationImage(
                      image: AssetImage(thirdUser[index].img),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 170.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      thirdUser[index].category,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: blue,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    // SizedBox(width: 20.w,),
                    CircleAvatar(
                      backgroundColor: yellow,
                      radius: 23.sp,
                      child: Icon(
                        Icons.arrow_outward_outlined,
                        color: white,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
