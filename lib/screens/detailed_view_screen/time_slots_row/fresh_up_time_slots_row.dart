// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/controller/search/search_fresh_up_controller.dart';
import 'package:homesloc/models/search/fresh_up_room_details_model.dart';
import 'package:intl/intl.dart';

class FreshUpTimeSlotsRow extends StatelessWidget {
  const FreshUpTimeSlotsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final freshUpController = Get.find<SearchFreshUpController>();
    
    return Obx(() {
      final roomDetails = freshUpController.roomDetails.value;
      final pricePerHead = roomDetails?.pricePerHead;
      final slots = pricePerHead?.slots ?? [];
      
      // Print slots data for debugging
      if (slots.isNotEmpty) {
        print('Fresh Up Time Slots: ${slots.length} slots found');
        for (var i = 0; i < slots.length; i++) {
          print('Slot ${i+1}: Check-in: ${slots[i].checkIn}, Check-out: ${slots[i].checkOut}');
        }
      } else {
        print('No time slots available in the API response');
      }
      
      if (slots.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Text(
            'No time slots available',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: black,
              fontSize: 14.sp,
            ),
          ),
        );
      }
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              'Available Time Slots',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: blue,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: slots.map((slot) {
                final checkIn = slot.checkIn != null ? _formatTime(slot.checkIn!) : 'N/A';
                final checkOut = slot.checkOut != null ? _formatTime(slot.checkOut!) : 'N/A';
                
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.sp),
                    border: Border.all(color: blue.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Slot: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: blue,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '$checkIn — $checkOut',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      );
    });
  }
  
  String _formatTime(String timeString) {
    try {
      // Assuming the time is in a format like "HH:mm:ss" or "HH:mm"
      final parts = timeString.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = parts[1];
        
        // Format as 12-hour time with AM/PM
        final period = hour >= 12 ? 'AM' : 'PM';
        final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        
        return '$hour12:$minute $period';
      }
    } catch (e) {
      print('Error formatting time: $e');
    }
    
    return timeString;
  }
} 