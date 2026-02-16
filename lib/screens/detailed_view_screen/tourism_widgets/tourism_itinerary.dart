import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/tourism/tourism_detail_model.dart';

class ItinerarySection extends StatelessWidget {
  final List<Itinerary>? itinerary;

  const ItinerarySection({super.key, this.itinerary});

  @override
  Widget build(BuildContext context) {
    if (itinerary == null || itinerary!.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: itinerary!
            .map((item) => Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Text(item.day ?? '',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp)),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Day ${item.day?.replaceAll(RegExp(r'[^0-9]'), '')}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(item.description ?? '',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: black,
                                    fontSize: 13.sp,
                                    height: 1.5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
