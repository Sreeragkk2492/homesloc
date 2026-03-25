import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/profile/profile_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/profile/user_profile_model.dart';
import 'package:homesloc/screens/profile_screen/personal_details/edit_profile_screen.dart';
import 'package:shimmer/shimmer.dart';

class PersonalDetailsScreen extends StatelessWidget {
  PersonalDetailsScreen({Key? key}) : super(key: key);

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Personal Details',
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: blue,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white, size: 22.sp),
            onPressed: () => Get.to(() => const EditProfileScreen()),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingSkeleton();
        }

        if (controller.userProfile.value == null) {
          return _buildErrorState();
        }

        final profile = controller.userProfile.value!;

        return RefreshIndicator(
          color: blue,
          onRefresh: controller.refreshProfile,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                _buildHeaderSection(profile),
                SizedBox(height: 20.h),
                _buildInfoCard(profile),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeaderSection(UserProfileModel profile) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
        boxShadow: [
          BoxShadow(
            color: blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 30.h, top: 10.h),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: Colors.white,
              child: Text(
                profile.name.isNotEmpty
                    ? profile.name.substring(0, 1).toUpperCase()
                    : 'U',
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  color: blue,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              profile.name,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 5.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                profile.userType,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(UserProfileModel profile) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildInfoRow(
              icon: Icons.email_outlined,
              title: 'Email Address',
              value: profile.primaryEmail.isNotEmpty
                  ? profile.primaryEmail
                  : 'Not provided',
            ),
            Divider(height: 30.h, color: Colors.grey.shade200),
            _buildInfoRow(
              icon: Icons.phone_android_outlined,
              title: 'Mobile Number',
              value: profile.primaryMobile.isNotEmpty
                  ? profile.primaryMobile
                  : 'Not provided',
            ),
            Divider(height: 30.h, color: Colors.grey.shade200),
            _buildInfoRow(
              icon: Icons.card_giftcard,
              title: 'Reward Points',
              value: profile.rewardsPoints.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: blue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: blue, size: 20.sp),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingSkeleton() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Container(
              width: 100.r,
              height: 100.r,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: 150.w,
              height: 20.h,
              color: Colors.white,
            ),
            SizedBox(height: 40.h),
            Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade300, size: 60.sp),
          SizedBox(height: 16.h),
          Text(
            'Failed to load profile',
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: controller.refreshProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: blue,
            ),
            child:
                const Text('Try Again', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
