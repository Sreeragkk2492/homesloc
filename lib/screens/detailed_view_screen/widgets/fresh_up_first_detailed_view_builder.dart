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
      // Check if freshUp is null
      if (freshUp == null) {
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

      // Collect all images
      List<String> allImages = [];
      
      // Add freshUp's cover image if available
      if (freshUp.coverImageUrl != null) {
        allImages.add(freshUp.coverImageUrl);
      }
      
      // Add room images if available
      if (freshUp.roomImages != null && freshUp.roomImages.isNotEmpty) {
        allImages.addAll(freshUp.roomImages);
      }
      
      // If we have room details, add those images too
      if (freshUpController.roomDetails.value != null) {
        final roomDetails = freshUpController.roomDetails.value!;
        
        // Add room details images if available
        if (roomDetails.images != null && roomDetails.images!.isNotEmpty) {
          allImages.addAll(roomDetails.images!);
        }
        
        // Add room images from price per head if available
        if (roomDetails.pricePerHead?.roomImages != null && 
            roomDetails.pricePerHead!.roomImages!.isNotEmpty) {
          allImages.addAll(roomDetails.pricePerHead!.roomImages!);
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
    });
  }
} 