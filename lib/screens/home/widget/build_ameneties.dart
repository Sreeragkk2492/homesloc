 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

Widget buildAmenities(dynamic hotel) {
    if (hotel.quickInfo?.amenities != null &&
        hotel.quickInfo!.amenities!.isNotEmpty) {
      // Character limit for displaying amenities
      final int characterLimit = 16;
      final amenities = hotel.quickInfo!.amenities!;

      // Initialize variables to track displayed text and count
      String displayText = "";
      int displayedCount = 0;
      List<Widget> amenityWidgets = [];

      // Build amenity widgets while respecting character limit
      for (int i = 0; i < amenities.length; i++) {
        final amenityName = amenities[i].name ?? "Amenity";

        // Check if adding this amenity would exceed the character limit
        if (displayText.length + amenityName.length <= characterLimit) {
          // Add separator if not the first item
          if (displayedCount > 0) {
            displayText += ", ";
            amenityWidgets.add(SizedBox(width: 5.w));
          }

          // Add icon and text
          amenityWidgets.add(Icon(
            Icons.local_activity,
            size: 11.sp,
            color: fontColor,
          ));

          amenityWidgets.add(SizedBox(width: 2.w));

          amenityWidgets.add(Text(
            amenityName,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: fontColor,
              fontSize: 11.sp,
            ),
          ));

          // Update tracking variables
          displayText += amenityName;
          displayedCount++;
        } else {
          // We've hit the character limit, add "more..." and break
          amenityWidgets.add(SizedBox(width: 5.w));
          amenityWidgets.add(Text(
            "more...",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: ogBlue,
              fontSize: 11.sp,
            ),
          ));
          break;
        }
      }

      // Return row with the amenity widgets
      return Row(children: amenityWidgets);
    } else {
      // Default amenities if none are provided
      return Row(
        children: [
          Icon(Icons.hotel, size: 11.sp, color: fontColor),
          SizedBox(width: 2.w),
          Text(
            "Basic",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: fontColor,
              fontSize: 11.sp,
            ),
          ),
        ],
      );
    }
  }