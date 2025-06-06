import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';

class RatingFirstRow extends StatelessWidget {
  const RatingFirstRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NameView(
          name: 'Ratings & Reviews',
          color: blue,
          secondName: 'View All',
          secondColor: blue,
        ),
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: gwhite,
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '4.5',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16.sp,
                        ),
                      ],
                    ),
                    Text(
                      '23 Reviews',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: fontColor,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  children: [
                    _buildRatingBar(5, 0.8),
                    _buildRatingBar(4, 0.6),
                    _buildRatingBar(3, 0.3),
                    _buildRatingBar(2, 0.2),
                    _buildRatingBar(1, 0.1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBar(int stars, double percentage) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Text(
            '$stars',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: fontColor,
              fontSize: 10.sp,
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
            size: 12.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.sp),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: gwhite,
                valueColor: AlwaysStoppedAnimation<Color>(blue),
                minHeight: 4.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 