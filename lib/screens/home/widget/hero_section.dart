import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/controller/calender_controller.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onCalendarTap;
  const HeroSection({super.key, this.onCalendarTap});

  @override
  Widget build(BuildContext context) {
    final calendarController = Get.find<CalendarController>();

    return Container(
      height: 250.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.4, 1.0],
                colors: [
                  blue,
                  blue.withOpacity(0.4),
                  black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Explore the beauty",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: white,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Plan your perfect stay with ease.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: white.withOpacity(0.9),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                // Trip Planner Bar
                Obx(() => GestureDetector(
                      onTap: () {
                        if (onCalendarTap != null) {
                          onCalendarTap!();
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            height: 55.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(
                                color: white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                    color: yellow.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.calendar_today_rounded,
                                    color: yellow,
                                    size: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Your Stay Dates",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: white.withOpacity(0.7),
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        calendarController.checkInDate.value !=
                                                    null &&
                                                calendarController
                                                        .checkOutDate.value !=
                                                    null
                                            ? "${calendarController.formatDateShort(calendarController.checkInDate.value)} — ${calendarController.formatDateShort(calendarController.checkOutDate.value)}"
                                            : "Select your dates",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: white,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: white.withOpacity(0.5),
                                  size: 14.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
