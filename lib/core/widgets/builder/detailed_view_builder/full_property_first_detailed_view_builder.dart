// ignore_for_file: file_names, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/search_hotel_full_properties_controller.dart';
import 'package:homesloc/controller/search/search_hotel_room_details_controller.dart';
import 'package:homesloc/core/colors/colors.dart';

class FullPropertyFirstDetailedViewBuilder extends StatelessWidget {
  final dynamic hotel;

  const FullPropertyFirstDetailedViewBuilder({super.key, this.hotel});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Try to get controllers
      final fullPropertyController = Get.find<SearchHotelFullPropertiesController>();
      final roomDetailsController = Get.find<SearchHotelRoomDetailsController>();
      
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

      // Collect all images
      List<String> allImages = [];
      
      // Check if this is a full property data structure (has hotelDetails property)
      if (hotel.hotelDetails != null) {
        // This is full property data structure
        // Add hotel's cover image if available (from hotelDetails)
        if (hotel.hotelDetails.coverImageUrl != null) {
          allImages.add(hotel.hotelDetails.coverImageUrl);
        }
        
        // Add gallery images if available (from hotelDetails)
        if (hotel.hotelDetails.galleryImages != null && hotel.hotelDetails.galleryImages.isNotEmpty) {
          allImages.addAll(hotel.hotelDetails.galleryImages);
        }
        
        // Add images from the full property model if available
        if (hotel.images != null && hotel.images.isNotEmpty) {
          allImages.addAll(hotel.images);
        }
        
        // Add room images from full property
        if (hotel.rooms != null) {
          for (var room in hotel.rooms) {
            if (room.roomImages != null && room.roomImages!.isNotEmpty) {
              allImages.addAll(room.roomImages!);
            }
          }
        }
      } else {
        // This could be hotel details data structure or room details structure
        // Check if it has room_images (room details structure)
        if (hotel.roomImages != null && hotel.roomImages.isNotEmpty) {
          allImages.addAll(hotel.roomImages);
        }
        
        // Check if it has images (room details structure)
        if (hotel.images != null && hotel.images.isNotEmpty) {
          allImages.addAll(hotel.images);
        }
        
        // Check if it has coverImageUrl (hotel details structure)
        if (hotel.coverImageUrl != null) {
          allImages.add(hotel.coverImageUrl);
        }
        
        // Check if it has galleryImages (hotel details structure)
        if (hotel.galleryImages != null && hotel.galleryImages.isNotEmpty) {
          allImages.addAll(hotel.galleryImages);
        }
        
        // Check if it has rooms (hotel details structure)
        if (hotel.rooms != null) {
          for (var room in hotel.rooms) {
            if (room.roomImages != null && room.roomImages.isNotEmpty) {
              allImages.addAll(room.roomImages);
            }
          }
        }
      }
      
      // Try to get additional images from room details controller
      final roomDetails = roomDetailsController.roomDetails.value;
      if (roomDetails != null) {
        // Add room images from room details
        if (roomDetails.roomImages != null && roomDetails.roomImages!.isNotEmpty) {
          allImages.addAll(roomDetails.roomImages!);
        }
        
        // Add images from room details
        if (roomDetails.images != null && roomDetails.images!.isNotEmpty) {
          allImages.addAll(roomDetails.images!);
        }
        
        // Add images from room details hotel_details
        if (roomDetails.hotelDetails != null) {
          if (roomDetails.hotelDetails!.coverImageUrl != null) {
            allImages.add(roomDetails.hotelDetails!.coverImageUrl!);
          }
          if (roomDetails.hotelDetails!.galleryImages != null && roomDetails.hotelDetails!.galleryImages!.isNotEmpty) {
            allImages.addAll(roomDetails.hotelDetails!.galleryImages!);
          }
          if (roomDetails.hotelDetails!.rooms != null) {
            for (var room in roomDetails.hotelDetails!.rooms!) {
              if (room.roomImages != null && room.roomImages!.isNotEmpty) {
                allImages.addAll(room.roomImages!);
              }
            }
          }
        }
      }

      // Remove duplicates and check if we have any images to display
      allImages = allImages.toSet().toList();
      
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