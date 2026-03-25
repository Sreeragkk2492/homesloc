// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/home/hotel_detail_model.dart';

class TransportationsFirstRow extends StatelessWidget {
  final dynamic hotel;
  const TransportationsFirstRow({super.key, this.hotel});

  @override
  Widget build(BuildContext context) {
    List<TransportationInfo> info = [];

    if (hotel is HotelDetailModel) {
      info = hotel.transportationInfo ?? [];
    }

    if (info.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Text(
          'No transportation info available',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: fontColor,
            fontSize: 10.sp,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
      child: Wrap(
        spacing: 12.w,
        runSpacing: 12.h,
        children: info.map((item) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: border, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getTransportIcon(item.type ?? ''),
                    size: 14.sp,
                    color: blue,
                  ),
                ),
                SizedBox(width: 10.w),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.type ?? 'N/A',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                        ),
                      ),
                      Text(
                        '${item.distance} km away',
                        style: TextStyle(
                          color: fontColor,
                          fontFamily: 'Poppins',
                          fontSize: 9.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _getTransportIcon(String type) {
    final t = type.toLowerCase();
    if (t.contains('airport')) return Icons.airplanemode_active;
    if (t.contains('metro') || t.contains('train')) return Icons.train;
    if (t.contains('bus')) return Icons.directions_bus;
    return Icons.location_on_outlined;
  }
}
