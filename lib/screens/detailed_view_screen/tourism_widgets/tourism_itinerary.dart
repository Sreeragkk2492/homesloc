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
        children: List.generate(itinerary!.length, (index) {
          final item = itinerary![index];
          final isLast = index == itinerary!.length - 1;

          final dayNum = "${index + 1}";

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline left part
                SizedBox(
                  width: 30.w,
                  child: Column(
                    children: [
                      Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                          color: blue,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            dayNum,
                            style: TextStyle(
                              color: white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 2.w,
                            color: blue.withOpacity(0.3),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 15.w),
                // Card right part
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25.h),
                    child: Container(
                      padding: EdgeInsets.all(15.r),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(color: border, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.day ?? 'Day $dayNum',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            item.description ?? '',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: black.withOpacity(0.8),
                              fontSize: 12.sp,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
