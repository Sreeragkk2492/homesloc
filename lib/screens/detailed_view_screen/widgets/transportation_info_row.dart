import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';

class TransportationInfoRow extends StatelessWidget {
  const TransportationInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NameView(
          name: 'Transportation Info',
          color: blue,
          secondName: 'View All',
          secondColor: blue,
        ),
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            children: [
              _buildTransportItem(
                icon: Icons.train,
                title: 'Railway Station',
                distance: '2.5 km',
                description: 'Nearest Railway Station',
              ),
              SizedBox(height: 10.h),
              _buildTransportItem(
                icon: Icons.flight,
                title: 'Airport',
                distance: '15 km',
                description: 'Nearest Airport',
              ),
              SizedBox(height: 10.h),
              _buildTransportItem(
                icon: Icons.directions_bus,
                title: 'Bus Stand',
                distance: '1.8 km',
                description: 'Nearest Bus Stand',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransportItem({
    required IconData icon,
    required String title,
    required String distance,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: gwhite,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: Icon(
              icon,
              color: blue,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: fontColor,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Text(
              distance,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: blue,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 