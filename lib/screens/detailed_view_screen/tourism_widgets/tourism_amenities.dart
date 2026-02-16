import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/tourism/tourism_detail_model.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';

class TourismAmenitiesSection extends StatelessWidget {
  final List<TourismAmenity>? amenities;

  const TourismAmenitiesSection({super.key, this.amenities});

  @override
  Widget build(BuildContext context) {
    if (amenities == null || amenities!.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NameView(
          name: "Package Amenities",
          color: blue,
          secondName: 'View All',
          secondColor: blue,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: amenities!.map((amenity) {
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
                        _getAmenityIcon(amenity.name ?? ""),
                        size: 13.sp,
                        color: black,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        amenity.name ?? "",
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
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  IconData _getAmenityIcon(String amenity) {
    final a = amenity.toLowerCase();
    if (a.contains('wifi')) return Icons.wifi;
    if (a.contains('tv')) return Icons.tv;
    if (a.contains('ac') || a.contains('air conditioning'))
      return Icons.ac_unit;
    if (a.contains('parking')) return Icons.local_parking;
    if (a.contains('breakfast') || a.contains('meal')) return Icons.restaurant;
    if (a.contains('transport')) return Icons.directions_bus;
    return Icons.check_circle_outline;
  }
}
