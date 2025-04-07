import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/controller/search/search_hotel_full_properties_controller.dart';

class PropertyLocation extends StatelessWidget {
  const PropertyLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullPropertyController = Get.find<SearchHotelFullPropertiesController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h, top: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Property highlights',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: blue,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold),
              ),
              Container(
                width: 67.w,
                height: 22.h,
                decoration: BoxDecoration(
                  color: gwhite,
                  borderRadius: BorderRadius.circular(4.sp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 12.sp,
                      color: blue,
                    ),
                    Text(
                      'Location',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: blue,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 3.h, right: 10.w),
                child: Image(
                  image: AssetImage('assets/images/Frame (8).png'),
                  width: 15.w,
                  height: 15.h,
                  color: blue,
                ),
              ),
              Expanded(
                child: Obx(() {
                  final hotelDetails = fullPropertyController.fullPropertyDetails.value?.hotelDetails;
                  final address = [
                    hotelDetails?.address,
                    hotelDetails?.postcode,
                    hotelDetails?.city,
                    hotelDetails?.state,
                    hotelDetails?.country,
                  ].where((element) => element != null && element.isNotEmpty).join(", ");
                  
                  return Text(
                    address.isNotEmpty ? address : "Address not available",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: black,
                      fontSize: 13.sp,
                      height: 1.5,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  );
                }),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 3.h, right: 10.w),
                child: Image(
                  image: AssetImage('assets/images/Frame (9).png'),
                  width: 15.w,
                  height: 15.h,
                  color: blue,
                ),
              ),
              Expanded(
                child: Obx(() {
                  final hotelDetails = fullPropertyController.fullPropertyDetails.value?.hotelDetails;
                  return Text(
                    hotelDetails?.phoneNumber ?? "Contact number not available",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: black,
                      fontSize: 13.sp,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 