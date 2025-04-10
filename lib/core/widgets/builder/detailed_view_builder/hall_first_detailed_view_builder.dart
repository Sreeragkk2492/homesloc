// ignore_for_file: file_names, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/hall_search_controller.dart';
import 'package:homesloc/core/colors/colors.dart';

class HallFirstDetailedViewBuilder extends StatelessWidget {
  final dynamic hall;

  const HallFirstDetailedViewBuilder({super.key, this.hall});

  @override
  Widget build(BuildContext context) {
    final hallSearchController = Get.find<HallSearchController>();
    
    return Obx(() {
      // Check if we have event details with images
      if (hallSearchController.selectedEventDetails.value != null) {
        final eventDetails = hallSearchController.selectedEventDetails.value!;
        
        // Collect all images from the event details
        List<String> allImages = [];
        
        // Add hall's cover image if available
        if (eventDetails.hallDetails?.coverImageUrl != null) {
          allImages.add(eventDetails.hallDetails!.coverImageUrl!);
        }
        
        // Add gallery images if available
        if (eventDetails.hallDetails?.galleryImages != null && 
            eventDetails.hallDetails!.galleryImages!.isNotEmpty) {
          allImages.addAll(eventDetails.hallDetails!.galleryImages!);
        }
        
        // Add event images if available
        if (eventDetails.images != null && eventDetails.images!.isNotEmpty) {
          allImages.addAll(eventDetails.images!);
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
      
      // Fallback to hall's cover image if no event details
      if (hall == null || hall.coverImage == null) {
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
      
      // Display just the cover image
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            height: 98.h,
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              image: DecorationImage(
                image: NetworkImage(hall.coverImage),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      );
    });
  }
} 