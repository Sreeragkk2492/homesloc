import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/search_hotel_room_details_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';

class RoomPoliciesRow extends StatefulWidget {
  const RoomPoliciesRow({super.key});

  @override
  State<RoomPoliciesRow> createState() => _RoomPoliciesRowState();
}

class _RoomPoliciesRowState extends State<RoomPoliciesRow> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final roomDetails = Get.find<SearchHotelRoomDetailsController>()
          .roomDetails
          .value;

      if (roomDetails == null) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NameView(
            name: 'Room Policies',
            color: blue,
            secondName: isExpanded ? 'Show Less' : 'View All',
            secondColor: blue,
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPolicyCard(
                  icon: Icons.king_bed_rounded,
                  title: 'Room Type',
                  content: roomDetails.roomType ?? 'Not specified',
                ),
                _buildPolicyCard(
                  icon: Icons.bed_rounded,
                  title: 'Bed Type',
                  content: roomDetails.bedType ?? 'Not specified',
                ),
                _buildPolicyCard(
                  icon: Icons.aspect_ratio_rounded,
                  title: 'Room Size',
                  content: '${roomDetails.roomSize ?? 0} sq.ft',
                ),
                _buildPolicyCard(
                  icon: Icons.people_rounded,
                  title: 'Maximum Occupancy',
                  content: '${roomDetails.maxPerson ?? 0} persons',
                ),
                if (roomDetails.mealOption != null)
                  _buildPolicyCard(
                    icon: Icons.restaurant_rounded,
                    title: 'Meal Option',
                    content: roomDetails.mealOption!,
                  ),
                if (roomDetails.smokingAllowed != null)
                  _buildPolicyCard(
                    icon: roomDetails.smokingAllowed! 
                        ? Icons.smoking_rooms_rounded 
                        : Icons.smoke_free_rounded,
                    title: 'Smoking Policy',
                    content: roomDetails.smokingAllowed! ? 'Allowed' : 'Not Allowed',
                    iconColor: roomDetails.smokingAllowed! ? green : Colors.red,
                  ),
                if (isExpanded && roomDetails.amenities != null && roomDetails.amenities!.isNotEmpty)
                  _buildPolicyCard(
                    icon: Icons.room_service_rounded,
                    title: 'Room Amenities',
                    content: roomDetails.amenities!.map((a) => a.name ?? '').join(', '),
                  ),
                if (isExpanded && roomDetails.description != null)
                  _buildPolicyCard(
                    icon: Icons.description_rounded,
                    title: 'Description',
                    content: roomDetails.description!,
                  ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
        ],
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