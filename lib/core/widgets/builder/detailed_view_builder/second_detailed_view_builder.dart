// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/yellow_star/yellow_star.dart';
import 'package:homesloc/core/widgets/builder_users/detailed_view_user/detailed_view_user.dart';

class SecondDetailedViewBuilder extends StatelessWidget {
  const SecondDetailedViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: secondDetailedViewUser.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(left: 10.w,top: 12.h,right: 5.w),
          child: Row(
            children: [
              Container(
                width: 180.w,
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sp),
                  border: Border.all(width: 1.w, color: grey),
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5.w, top: 5.h),
                      height: 40.h,
                      width: 48.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.sp),
                        image: DecorationImage(
                            image:
                                AssetImage(secondDetailedViewUser[index].img),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      right: 33.w,
                      top: 4.h,
                      child: Text(
                        'Dasamoolam\nDamu',
                        style: TextStyle(
                            color: black,
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    YellowStar(),
                    Positioned(
                      bottom: 10.h,
                      left: 5.w,
                      child: Text(
                        "The room, cleanliness, and\nstaff experience at this hotel\nwere just fantastic.",
                        style: TextStyle(
                            color: fontColor,
                            fontFamily: 'Poppins',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
