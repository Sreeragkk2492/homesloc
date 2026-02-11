import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/controller/bottom_navigation_bar/bottom_bar_controller.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomBarController = Get.find<BottomBarController>();

    return Container(
      height: 240.h,
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
                  blue, // Solid blue to match App Bar
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
                  "Where to next?",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: black.withOpacity(0.3),
                        offset: const Offset(2, 2),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Discover the most amazing places around the world.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: white.withOpacity(0.9),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                // Glassmorphic Search Pill
                GestureDetector(
                  onTap: () {
                    bottomBarController.updateSelectedPageIndex(1);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.sp),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30.sp),
                          border: Border.all(
                            color: white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: white,
                              size: 20.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Search for hotels, resorts...",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: white.withOpacity(0.8),
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
