import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/controller/search/search_hotel_full_properties_controller.dart';

class PropertyRoute extends StatelessWidget {
  const PropertyRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullPropertyController = Get.find<SearchHotelFullPropertiesController>();
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 82.h, right: 10.w),
                child: Image(
                  image: AssetImage('assets/images/Frame (10).png'),
                  width: 15.w,
                  height: 15.h,
                  color: blue,
                ),
              ),
              Expanded(
                child: Obx(() {
                  final hotelDetails = fullPropertyController.fullPropertyDetails.value?.hotelDetails;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Route to ${hotelDetails?.name ?? "Property"}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Starting Point: ${hotelDetails?.city ?? "City"} Bus Stand',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '1. Head southeast on Munnar-Udumalpet\nRoad (NH85).  2. Take the Mattupetty Road\nexit. 3. Follow the scenic Mattupetty Road.\nAfter 12km you reach destination.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 