import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/search/search_hotel_model.dart';
import 'package:homesloc/models/freshup/freshup_availability_model.dart';

class FreshupAmenitieRow extends StatelessWidget {
  final Hotel freshup;
  final List<FreshupAmenity>? amenities;
  const FreshupAmenitieRow({super.key, required this.freshup, this.amenities});

  @override
  Widget build(BuildContext context) {
    // Accessing amenities from provided list OR freshupDetails which is a List<FreshupAmenity>
    final List<FreshupAmenity> roomAmenities =
        amenities ?? freshup.freshupDetails?.amenities ?? [];
    final List<FreshupAmenity> propertyAmenities =
        freshup.freshupDetails?.propertyAmenities ?? [];

    // Merge them avoiding duplicates by name
    final Map<String, FreshupAmenity> combined = {};
    for (var a in propertyAmenities) {
      if (a.name != null) combined[a.name!] = a;
    }
    for (var a in roomAmenities) {
      if (a.name != null) combined[a.name!] = a;
    }

    final displayAmenities = combined.values.toList();

    if (displayAmenities.isEmpty) {
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
          children: displayAmenities.map((amenity) {
            String name = amenity.name ?? "";
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
                    _getAmenityIcon(name),
                    size: 13.sp,
                    color: black,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    name,
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
    if (a.contains('bathroom') || a.contains('toilet'))
      return Icons.bathroom_outlined;
    if (a.contains('bed')) return Icons.bed_outlined;
    return Icons.check_circle_outline;
  }
}
