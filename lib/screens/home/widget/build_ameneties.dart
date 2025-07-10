import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

Widget buildAmenities(dynamic accommodation) {
    // Check if the accommodation has amenities directly (new model structure)
    if (accommodation.amenities != null && accommodation.amenities.isNotEmpty) {
      final amenities = accommodation.amenities;
      
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Show only first amenity
          Flexible(
            child: _buildAmenityChip(_truncateAmenityName(amenities[0].name ?? "Amenity")),
          ),
          SizedBox(width: 4.w),
          // Show count if more than 1 amenity
          if (amenities.length > 1)
            Flexible(
              child: _buildAmenityChip("+${amenities.length - 1} more"),
            ),
        ],
      );
    } else {
      // Return empty container if no amenities
      return Container();
    }
  }

Widget _buildAmenityChip(String amenityName) {
  return Container(
    constraints: BoxConstraints(maxWidth: 60.w), // Reduced max width
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
    decoration: BoxDecoration(
      color: gwhite,
      borderRadius: BorderRadius.circular(4.sp),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 10.sp,
          color: ogBlue,
        ),
        SizedBox(width: 3.w),
        Flexible(
          child: Text(
            amenityName,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: fontColor,
              fontSize: 10.sp,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    ),
  );
}

String _truncateAmenityName(String name) {
  if (name.length > 8) { // Reduced truncation length
    return name.substring(0, 8) + "...";
  }
  return name;
}