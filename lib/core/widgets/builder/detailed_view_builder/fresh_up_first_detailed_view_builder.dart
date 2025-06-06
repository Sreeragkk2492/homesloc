// ignore_for_file: file_names, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/search_fresh_up_controller.dart';
import 'package:homesloc/core/colors/colors.dart';

class FreshUpFirstDetailedViewBuilder extends StatelessWidget {
  final dynamic freshUp;

  const FreshUpFirstDetailedViewBuilder({super.key, this.freshUp});

  @override
  Widget build(BuildContext context) {
    final freshUpController = Get.find<SearchFreshUpController>();
    
    return Obx(() {
      // Check if we have room details with images
      if (freshUpController.roomDetails.value != null) {
        final roomDetails = freshUpController.roomDetails.value!;
        
        // Collect all images from the room details
        List<String> allImages = [];
        
        // Add property's cover image if available
        if (roomDetails.propertyDetails?.coverImageUrl != null) {
          allImages.add(roomDetails.propertyDetails!.coverImageUrl!);
        }
        
        // Add room images if available
        if (roomDetails.images != null && roomDetails.images!.isNotEmpty) {
          allImages.addAll(roomDetails.images!);
        }
        
        // Add price per head room images if available
        if (roomDetails.pricePerHead?.roomImages != null && 
            roomDetails.pricePerHead!.roomImages!.isNotEmpty) {
          allImages.addAll(roomDetails.pricePerHead!.roomImages!);
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
      
      // Fallback to fresh up's cover image if no room details
      if (freshUp == null || freshUp.coverImageUrl == null) {
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
                image: NetworkImage(freshUp.coverImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      );
    });
  }
} 