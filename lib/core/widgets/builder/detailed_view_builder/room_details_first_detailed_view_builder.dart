// ignore_for_file: file_names, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/search_hotel_room_details_controller.dart';
import 'package:homesloc/core/colors/colors.dart';

class RoomDetailsFirstDetailedViewBuilder extends StatelessWidget {
  final dynamic roomDetails;

  const RoomDetailsFirstDetailedViewBuilder({super.key, this.roomDetails});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Try to get room details controller
      final roomDetailsController = Get.find<SearchHotelRoomDetailsController>();
      
      // Check if roomDetails is null
      if (roomDetails == null) {
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
      
      // Add room images from the room details (root level)
      if (roomDetails.roomImages != null && roomDetails.roomImages.isNotEmpty) {
        allImages.addAll(roomDetails.roomImages);
      }
      
      // Add general images from room details (root level)
      if (roomDetails.images != null && roomDetails.images.isNotEmpty) {
        allImages.addAll(roomDetails.images);
      }
      
      // Add images from hotel_details if available
      if (roomDetails.hotelDetails != null) {
        // Add hotel cover image
        if (roomDetails.hotelDetails.coverImageUrl != null) {
          allImages.add(roomDetails.hotelDetails.coverImageUrl);
        }
        
        // Add hotel gallery images
        if (roomDetails.hotelDetails.galleryImages != null && roomDetails.hotelDetails.galleryImages.isNotEmpty) {
          allImages.addAll(roomDetails.hotelDetails.galleryImages);
        }
        
        // Add room images from hotel_details.rooms
        if (roomDetails.hotelDetails.rooms != null) {
          for (var room in roomDetails.hotelDetails.rooms) {
            if (room.roomImages != null && room.roomImages.isNotEmpty) {
              allImages.addAll(room.roomImages);
            }
          }
        }
      }
      
      // Also get images from the controller if available
      final controllerRoomDetails = roomDetailsController.roomDetails.value;
      if (controllerRoomDetails != null) {
        // Add room images from controller
        if (controllerRoomDetails.roomImages != null && controllerRoomDetails.roomImages!.isNotEmpty) {
          allImages.addAll(controllerRoomDetails.roomImages!);
        }
        
        // Add general images from controller
        if (controllerRoomDetails.images != null && controllerRoomDetails.images!.isNotEmpty) {
          allImages.addAll(controllerRoomDetails.images!);
        }
        
        // Add images from controller hotel_details
        if (controllerRoomDetails.hotelDetails != null) {
          if (controllerRoomDetails.hotelDetails!.coverImageUrl != null) {
            allImages.add(controllerRoomDetails.hotelDetails!.coverImageUrl!);
          }
          if (controllerRoomDetails.hotelDetails!.galleryImages != null && controllerRoomDetails.hotelDetails!.galleryImages!.isNotEmpty) {
            allImages.addAll(controllerRoomDetails.hotelDetails!.galleryImages!);
          }
          if (controllerRoomDetails.hotelDetails!.rooms != null) {
            for (var room in controllerRoomDetails.hotelDetails!.rooms!) {
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