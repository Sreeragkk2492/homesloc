import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/profile_screen/my_bookings/my_bookings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: blue,
        //  leading: Padding(
        //    padding:  EdgeInsets.only(left: 9.w),
        //    child: CircleAvatar(
        //    // backgroundColor: blue,
        //    ),
        //  ),
        title: Text(
          'Hi, Admin',
          style: TextStyle(fontSize: 18.sp, color: white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 24.sp,
              color: white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.notifications,
              size: 24.sp,
              color: white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Genius Level Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: blue, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Level 1',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.house, color: blue, size: 24.sp),
                            SizedBox(height: 4.h),
                            Text(
                              '10% off stays',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.car_rental, color: blue, size: 24.sp),
                            SizedBox(height: 4.h),
                            Text(
                              '10% off rental cars',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'You\'re 5 bookings away from Genius Level 2',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // Profile Completion Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complete your profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Complete your profile and use this information for your next booking',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                      ),
                      child: Text(
                        'Complete now',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // Menu Items
              _buildMenuItem(Icons.person_outline, 'Personal details', () {}),
              _buildMenuItem(Icons.book_online, 'My Bookings', () {
                Get.to(() => TripScreen());
              }),
              _buildMenuItem(Icons.settings, 'Security settings', () {}),
              _buildMenuItem(Icons.email_outlined, 'Email preferences', () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return SizedBox(
      height: 60.h,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Icon(icon, color: Colors.grey, size: 24.sp),
              SizedBox(width: 16.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                ),
              ),
              const Spacer(),
              Icon(Icons.chevron_right, color: Colors.grey, size: 24.sp),
            ],
          ),
        ),
      ),
    );
  }
}
