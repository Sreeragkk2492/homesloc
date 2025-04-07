import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/controller/search/search_hotel_full_properties_controller.dart';

class FullPropertyBookNow extends StatelessWidget {
  const FullPropertyBookNow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullPropertyController = Get.find<SearchHotelFullPropertiesController>();
    
    return Obx(() {
      final propertyDetails = fullPropertyController.fullPropertyDetails.value;
      final price = propertyDetails?.basePropertyPrice ?? '0';
      
      return Container(
        padding: EdgeInsets.all(12.r),
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.circular(23.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            Text(
              'Book Your Stay Now',
              style: TextStyle(
                  color: const Color.fromARGB(255, 190, 190, 190),
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Your dream stay is just a click away! Book\nnow for a seamless and unforgettable\nexperience.',
              style: TextStyle(
                  color: const Color.fromARGB(255, 190, 190, 190),
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w100),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Divider(
                color: const Color.fromARGB(255, 190, 190, 190),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "₹$price",
                        style: TextStyle(
                          color: white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp
                        ),
                      ),
                      Text(
                        "+ ₹${(double.parse(price) * 0.18).round()} taxes & fees",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 190, 190, 190),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          decorationColor: white,
                          fontSize: 10.sp
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 110.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(28.sp),
                  ),
                  child: Center(
                    child: Text(
                      "BOOK NOW",
                      style: TextStyle(
                        color: black,
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
} 