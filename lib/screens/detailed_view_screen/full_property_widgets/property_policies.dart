import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/controller/search/search_hotel_full_properties_controller.dart';
import 'package:homesloc/controller/search/search_hotel_room_details_controller.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';

class PropertyPolicies extends StatelessWidget {
  const PropertyPolicies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NameView(
          name: 'Our Accommodation Policies',
          color: blue,
          secondName: 'View All',
          secondColor: blue
        ),
        SizedBox(height: 10.h),
        Obx(() {
          // Try to get controllers
          final fullPropertyController = Get.find<SearchHotelFullPropertiesController>();
          final roomDetailsController = Get.find<SearchHotelRoomDetailsController>();
          
          // Try to get policies from full property details first
          final fullPropertyPolicies = fullPropertyController.getPolicies();
          final roomDetailsPolicies = roomDetailsController.roomDetails.value?.hotelDetails?.policies;
          
          // Cast to the correct type - both have the same structure
          final policies = fullPropertyPolicies ?? roomDetailsPolicies as dynamic;
          
          if (policies == null) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  'No policy information available',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: fontColor,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            );
          }
          
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPolicyCard(
                  icon: Icons.access_time_rounded,
                  title: 'Check-in/Check-out',
                  content: 'Check-in: ${policies.checkInTime ?? 'Not specified'}\nCheck-out: ${policies.checkOutTime ?? 'Not specified'}',
                ),
                if (policies.acceptableIdentityProof != null && policies.acceptableIdentityProof!.isNotEmpty)
                  _buildPolicyCard(
                    icon: Icons.credit_card_rounded,
                    title: 'Acceptable Identity Proof',
                    content: policies.acceptableIdentityProof!.join(', '),
                  ),
                if (policies.cancellationPolicy != null)
                  _buildPolicyCard(
                    icon: Icons.cancel_rounded,
                    title: 'Cancellation Policy',
                    content: policies.cancellationPolicy!,
                   // iconColor: Colors.red,
                  ),
                if (policies.extraBedPolicy != null)
                  _buildPolicyCard(
                    icon: Icons.bed_rounded,
                    title: 'Extra Bed Policy',
                    content: policies.extraBedPolicy! 
                        ? 'Available${policies.extraBedRate != null ? ' (₹${policies.extraBedRate})' : ''}'
                        : 'Not Available',
                   // iconColor: policies.extraBedPolicy! ? green : Colors.red,
                  ),
                if (policies.mealRates != null)
                  _buildPolicyCard(
                    icon: Icons.restaurant_rounded,
                    title: 'Meal Rates',
                    content: [
                      if (policies.mealRates!.breakfast != null) 'Breakfast: ₹${policies.mealRates!.breakfast}',
                      if (policies.mealRates!.lunch != null) 'Lunch: ₹${policies.mealRates!.lunch}',
                      if (policies.mealRates!.dinner != null) 'Dinner: ₹${policies.mealRates!.dinner}',
                    ].join('\n'),
                  ),
                if (policies.outsideVisitorAllowed != null)
                  _buildPolicyCard(
                    icon: Icons.people_rounded,
                    title: 'Visitors Policy',
                    content: policies.outsideVisitorAllowed! ? 'Visitors Allowed' : 'No Visitors Allowed',
                   // iconColor: policies.outsideVisitorAllowed! ? green : Colors.red,
                  ),
                if (policies.partiesOrEventsAllowed != null)
                  _buildPolicyCard(
                    icon: Icons.celebration_rounded,
                    title: 'Events Policy',
                    content: policies.partiesOrEventsAllowed! ? 'Events Allowed' : 'No Events Allowed',
                   // iconColor: policies.partiesOrEventsAllowed! ? green : Colors.red,
                  ),
              ],
            ),
          );
        }),
      ],
    );
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