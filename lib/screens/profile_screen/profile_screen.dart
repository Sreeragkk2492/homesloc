import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/profile_screen/my_bookings/my_bookings_screen.dart';
import 'package:homesloc/screens/profile_screen/personal_details/personal_details_screen.dart';
import 'package:homesloc/core/common/global_variables.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homesloc/screens/auth/sign_in.dart';

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
          'Hi, $userName',
          style: TextStyle(fontSize: 18.sp, color: white),
        ),
        actions: [
          // IconButton(
          //   icon: Icon(
          //     Icons.search,
          //     size: 24.sp,
          //     color: white,
          //   ),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.h),
              _buildModernMenuItem(
                icon: Icons.person_outline,
                title: 'Personal details',
                subtitle: 'Manage your profile and info',
                onTap: () {
                  Get.to(() => PersonalDetailsScreen());
                },
              ),
              _buildModernMenuItem(
                icon: Icons.book_online,
                title: 'My Bookings',
                subtitle: 'View your upcoming stays',
                onTap: () {
                  Get.to(() => TripScreen());
                },
              ),
              SizedBox(height: 24.h),
              Center(
                child: TextButton.icon(
                  onPressed: () async {
                    const storage = FlutterSecureStorage();
                    await storage.deleteAll();

                    // Clear globals
                    accessToken = "";
                    refreshToken = "";
                    userId = "";
                    userName = "";

                    Get.offAll(() => const SignIn());
                  },
                  icon: Icon(Icons.logout,
                      color: Colors.red.shade600, size: 20.sp),
                  label: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      color: Colors.red.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    backgroundColor: Colors.red.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: blue.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: blue, size: 24.sp),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Poppins',
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    color: Colors.grey.shade400, size: 16.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
