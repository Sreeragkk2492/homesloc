// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/home/hotel_detail_model.dart';

class AmenitieRow extends StatelessWidget {
  final dynamic hotel;
  const AmenitieRow({super.key, this.hotel});

  @override
  Widget build(BuildContext context) {
    List<String> amenities = [];

    if (hotel is HotelDetailModel) {
      amenities = hotel.amenities ?? [];
    } else if (hotel != null) {
      try {
        // Handle other model types if necessary, e.g., BestHotel
        if (hotel.runtimeType.toString() == 'BestHotel') {
          amenities = List<String>.from(hotel.amenities ?? []);
        }
      } catch (e) {
        print('Error extracting amenities: $e');
      }
    }

    if (amenities.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Text(
          'No amenities listed',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: fontColor,
            fontSize: 12.sp,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: amenities.map((amenity) {
            return Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: gwhite,
                borderRadius: BorderRadius.circular(4.sp),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getAmenityIcon(amenity),
                    size: 13.sp,
                    color: black,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    amenity,
                    style: TextStyle(
                      color: black,
                      fontFamily: 'Poppins',
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  IconData _getAmenityIcon(String amenity) {
    final a = amenity.toLowerCase();
    if (a.contains('wifi')) return Icons.wifi;
    if (a.contains('tv')) return Icons.tv;
    if (a.contains('ac') || a.contains('air conditioning'))
      return Icons.ac_unit;
    if (a.contains('power') || a.contains('backup')) return Icons.power;
    if (a.contains('parking')) return Icons.local_parking;
    if (a.contains('pool')) return Icons.pool;
    if (a.contains('gym') || a.contains('fitness')) return Icons.fitness_center;
    if (a.contains('restaurant') || a.contains('food')) return Icons.restaurant;
    return Icons.check_circle_outline;
  }
}
