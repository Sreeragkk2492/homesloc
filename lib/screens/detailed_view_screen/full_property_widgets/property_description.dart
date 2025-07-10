import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/controller/search/search_hotel_full_properties_controller.dart';
import 'package:homesloc/controller/search/search_hotel_room_details_controller.dart';

class PropertyDescription extends StatelessWidget {
  final String? coverImageUrl;
  
  const PropertyDescription({
    Key? key,
    this.coverImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
          child: Obx(() {
            // Try to get controllers
            final fullPropertyController = Get.find<SearchHotelFullPropertiesController>();
            final roomDetailsController = Get.find<SearchHotelRoomDetailsController>();
            
            // Try to get hotel name from full property details first
            final fullPropertyHotelDetails = fullPropertyController.fullPropertyDetails.value?.hotelDetails;
            String hotelName = '';
            
            if (fullPropertyHotelDetails?.name != null) {
              hotelName = fullPropertyHotelDetails!.name!;
            } else {
              // Try to get hotel name from room details
              final roomDetailsHotelDetails = roomDetailsController.roomDetails.value?.hotelDetails;
              hotelName = roomDetailsHotelDetails?.name ?? "Property";
            }
            
            return Text(
              'About $hotelName', 
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: blue,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold),
            );
          }),
        ),
        Container(
          margin: EdgeInsets.only(
              top: 10.h, left: 10.w, right: 10.w, bottom: 12.h),
          width: 340.w,
          height: 90.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
            image: DecorationImage(
                image: NetworkImage(coverImageUrl ?? 'assets/images/image (33).png'),
                fit: BoxFit.fill ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              Obx(() {
                // Try to get controllers
                final fullPropertyController = Get.find<SearchHotelFullPropertiesController>();
                final roomDetailsController = Get.find<SearchHotelRoomDetailsController>();
                
                // Try to get description from full property details first
                final fullPropertyHotelDetails = fullPropertyController.fullPropertyDetails.value?.hotelDetails;
                String description = '';
                
                if (fullPropertyHotelDetails?.description != null) {
                  description = fullPropertyHotelDetails!.description!;
                } else {
                  // Try to get description from room details
                  final roomDetailsHotelDetails = roomDetailsController.roomDetails.value?.hotelDetails;
                  description = roomDetailsHotelDetails?.description ?? "No description available";
                }
                
                return Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: black,
                    fontSize: 13.sp,
                  ),
                );
              }),
              SizedBox( 
                height: 8.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
} 