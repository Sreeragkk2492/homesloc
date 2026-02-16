import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/tourism/tourism_detail_model.dart';

class AgencyDetailSection extends StatelessWidget {
  final AgencyDetails? agency;

  const AgencyDetailSection({super.key, this.agency});

  @override
  Widget build(BuildContext context) {
    if (agency == null) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Text(
              'Organized by',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: blue,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              if (agency!.coverImageUrl != null)
                Container(
                  width: 50.r,
                  height: 50.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(agency!.coverImageUrl!),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: border, width: 1),
                  ),
                ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(agency!.name ?? '',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: blue,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold)),
                    Text("Serving since ${agency!.startedSince}",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: fontColor,
                            fontSize: 12.sp)),
                  ],
                ),
              ),
              _buildContactButton(Icons.phone),
              SizedBox(width: 10.w),
              _buildContactButton(Icons.email),
            ],
          ),
          SizedBox(height: 15.h),
          Text(agency!.description ?? '',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  color: black,
                  height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildContactButton(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: blue.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: blue, size: 18.sp),
    );
  }
}
