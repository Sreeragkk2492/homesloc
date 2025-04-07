import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

Widget buildAmenities(dynamic hotel) {
    if (hotel.quickInfo?.amenities != null &&
        hotel.quickInfo!.amenities!.isNotEmpty) {
      final amenities = hotel.quickInfo!.amenities!;
      
      return Container(
        margin: EdgeInsets.only(left: 5.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Show only first amenity
            _buildAmenityChip(_truncateAmenityName(amenities[0].name ?? "Amenity")),
            SizedBox(width: 4.w),
            // Show count of remaining amenities
            if (amenities.length > 1) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: gwhite,
                  borderRadius: BorderRadius.circular(4.sp),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "+${amenities.length - 1}",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: ogBlue,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    } else {
      // Default amenities if none are provided
      return _buildAmenityChip("Basic");
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