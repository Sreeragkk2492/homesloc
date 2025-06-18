import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/controller/search/search_hotel_full_properties_controller.dart';

class PropertyHeader extends StatelessWidget {
  const PropertyHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullPropertyController = Get.find<SearchHotelFullPropertiesController>();
    
    return Obx(() {
      final propertyDetails = fullPropertyController.fullPropertyDetails.value;
      
      if (propertyDetails == null) {
        return SizedBox.shrink();
      }
      
      return Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              propertyDetails.hotelDetails?.name ?? "Property",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              propertyDetails.hotelDetails?.hotelType ?? "Property Type",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: fontColor,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "₹${propertyDetails.basePropertyPrice ?? '0'}",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: black,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "+ ₹${(double.parse(propertyDetails.basePropertyPrice ?? '0') * 0.18).round()} Taxes & Fees",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: fontColor,
                fontSize: 12.sp,
              ),
            ),
            // SizedBox(height: 10.h),
            // Text(
            //   propertyDetails.hotelDetails?.description ?? "",
            //   style: TextStyle(
            //     fontFamily: 'Poppins',
            //     color: black,
            //     fontSize: 14.sp,
            //   ),
            // ),
          ],
        ),
      );
    });
  }
} 