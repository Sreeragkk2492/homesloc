import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/controller/search/search_hotel_full_properties_controller.dart';

class PropertyRating extends StatelessWidget {
  const PropertyRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullPropertyController = Get.find<SearchHotelFullPropertiesController>();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 18.h, left: 10.w, bottom: 10.h),
          child: Text(
            'Rating & Reviews',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: blue,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 42.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.circular(3.sp),
                ),
                child: Obx(() {
                  final hotelDetails = fullPropertyController.fullPropertyDetails.value?.hotelDetails;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${hotelDetails?.starRating ?? 0}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: white,
                          fontSize: 11.sp
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Icon(
                        Icons.star,
                        color: yellow,
                        size: 14.sp,
                      )
                    ],
                  );
                }),
              ),
              Obx(() {
                final hotelDetails = fullPropertyController.fullPropertyDetails.value?.hotelDetails;
                return Padding(
                  padding: EdgeInsets.only(right: 128.w),
                  child: Text(
                    "${hotelDetails?.totalRooms ?? 0} Reviews",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: const Color.fromARGB(255, 190, 190, 190),
                      fontSize: 11.sp
                    ),
                  ),
                );
              }),
              Container(
                width: 80.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: gwhite,
                  borderRadius: BorderRadius.circular(21.sp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/Vector (7).png'),
                      width: 11.w,
                      height: 11.h,
                      color: blue,
                    ),
                    SizedBox(width: 5.w),
                    Obx(() {
                      final hotelDetails = fullPropertyController.fullPropertyDetails.value?.hotelDetails;
                      final rating = hotelDetails?.starRating ?? 0;
                      String ratingText = 'Poor';
                      if (rating >= 4) {
                        ratingText = 'Excellent';
                      } else if (rating >= 3) {
                        ratingText = 'Good';
                      } else if (rating >= 2) {
                        ratingText = 'Average';
                      }
                      return Text(
                        ratingText,
                        style: TextStyle(
                          color: black,
                          fontFamily: 'Poppins',
                          fontSize: 10.sp
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 