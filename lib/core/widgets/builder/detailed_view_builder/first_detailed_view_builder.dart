// ignore_for_file: file_names, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class FirstDetailedViewBuilder extends StatelessWidget {
  final dynamic hotel;

  const FirstDetailedViewBuilder({super.key, this.hotel});

  @override
  Widget build(BuildContext context) {
    // Check if hotel is null
    if (hotel == null) {
      return Center(
        child: Text(
          'No images available',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: fontColor,
            fontSize: 12.sp,
          ),
        ),
      );
    }

    // Collect all room images
    List<String> allImages = [];
    
    // Add hotel's cover image if available
    if (hotel.coverImageUrl != null) {
      allImages.add(hotel.coverImageUrl);
    }
    
    // Add room images if available
    if (hotel.rooms != null) {
      for (var room in hotel.rooms) {
        if (room.roomImages != null && room.roomImages.isNotEmpty) {
          allImages.addAll(room.roomImages);
        }
      }
    }

    // Check if we have any images to display
    if (allImages.isEmpty) {
      return Center(
        child: Text(
          'No images available',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: fontColor,
            fontSize: 12.sp,
          ),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: allImages.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // You can add image preview functionality here
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            height: 98.h,
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              image: DecorationImage(
                image: NetworkImage(allImages[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
