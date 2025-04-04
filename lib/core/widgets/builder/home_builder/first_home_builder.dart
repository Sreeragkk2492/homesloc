// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/builder_users/builder_user.dart';
import 'package:homesloc/screens/home/hotel_search_screen.dart';

class FirstHomeBuilder extends StatelessWidget {
  const FirstHomeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: firstUser.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => HotelSearchScreen());
                },
                child: Container(
                  height: 80.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    image: DecorationImage(
                        image: AssetImage(firstUser[index].img),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                firstUser[index].category,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: black,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        );
      },
    );
  }
}
