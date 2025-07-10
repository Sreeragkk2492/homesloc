import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/hall_search_controller.dart';
import 'package:homesloc/core/colors/colors.dart';

class HallPoliciesRow extends StatelessWidget {
  const HallPoliciesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hallSearchController = Get.find<HallSearchController>();
      final eventDetails = hallSearchController.selectedEventDetails.value;
      final banquetPolicies = eventDetails?.hallDetails?.banquetPolicies;

      if (banquetPolicies == null) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPolicyCard(
              icon: Icons.access_time_rounded,
              title: 'Check-in/Check-out',
              content: 'Check-in: ${banquetPolicies.checkInTime ?? 'Not specified'}\nCheck-out: ${banquetPolicies.checkOutTime ?? 'Not specified'}',
            ),
            if (banquetPolicies.acceptableIdentityProofs != null && banquetPolicies.acceptableIdentityProofs!.isNotEmpty)
              _buildPolicyCard(
                icon: Icons.credit_card_rounded,
                title: 'Acceptable Identity Proof',
                content: banquetPolicies.acceptableIdentityProofs!.join(', '),
              ),
            if (banquetPolicies.cancellationPolicy != null)
              _buildPolicyCard(
                icon: Icons.cancel_rounded,
                title: 'Cancellation Policy',
                content: banquetPolicies.cancellationPolicy!,
               // iconColor: Colors.red,
              ),
            if (banquetPolicies.parkingCapacity != null)
              _buildPolicyCard(
                icon: Icons.local_parking_rounded,
                title: 'Parking Capacity',
                content: '${banquetPolicies.parkingCapacity} vehicles',
               // iconColor: green,
              ),
            if (banquetPolicies.decorationAllowed != null)
              _buildPolicyCard(
                icon: Icons.celebration_rounded,
                title: 'Decoration Policy',
                content: banquetPolicies.decorationAllowed! ? 'Decoration Allowed' : 'Decoration Not Allowed',
               // iconColor: banquetPolicies.decorationAllowed! ? green : Colors.red,
              ),
            if (banquetPolicies.valetParkingAvailable != null)
              _buildPolicyCard(
                icon: Icons.directions_car_rounded,
                title: 'Valet Parking',
                content: banquetPolicies.valetParkingAvailable! ? 'Available' : 'Not Available',
               // iconColor: banquetPolicies.valetParkingAvailable! ? green : Colors.red,
              ),
            if (banquetPolicies.propertyExtraCharges != null)
              _buildPolicyCard(
                icon: Icons.payments_rounded,
                title: 'Extra Charges',
                content: '₹${banquetPolicies.propertyExtraCharges}',
               // iconColor: Colors.orange,
              ),
            if (banquetPolicies.propertyRestrictions != null)
              _buildPolicyCard(
                icon: Icons.gavel_rounded,
                title: 'Property Restrictions',
                content: banquetPolicies.propertyRestrictions!,
               // iconColor: Colors.red,
              ),
          ],
        ),
      );
    });
  }

  Widget _buildPolicyCard({
    required IconData icon,
    required String title,
    required String content,
    Color? iconColor,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: gwhite,
        borderRadius: BorderRadius.circular(8.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.sp),
              ),
              child: Icon(
                icon,
                color: iconColor ?? blue,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    content,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: fontColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 