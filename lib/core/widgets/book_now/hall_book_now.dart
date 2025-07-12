// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/payment_screen/payment_screen.dart';
import 'package:homesloc/controller/search/hall_search_controller.dart';

class HallBookNow extends StatelessWidget {
  final dynamic hall;
  final dynamic selectedEvent;
  final String? price;
  const HallBookNow({super.key, this.hall, this.selectedEvent, this.price});

  @override
  Widget build(BuildContext context) {
    // Get the hall search controller
    final hallSearchController = Get.find<HallSearchController>();
    
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
            'Book Your Event Now',
            style: TextStyle(
                color: const Color.fromARGB(255, 190, 190, 190),
                fontFamily: 'Poppins',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Your dream event is just a click away! Book\nnow for a seamless and unforgettable\nexperience.',
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
          // If a custom price is provided, use it
          if (price != null)
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
                        "+ ₹${(double.parse(price ?? '0') * 0.18).round()} taxes & fees",
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
                GestureDetector(
                  onTap: () {
                    // Navigate to payment screen with hall data
                    Get.to(() => PaymentSreen(), arguments: {
                      'bookingType': 'hall',
                      'hall': hall,
                      'price': price,
                      'startDate': hallSearchController.checkInDate.value,
                      'endDate': hallSearchController.checkOutDate.value,
                    });
                  },
                  child: Container(
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
                ),
              ],
            ),
          // Otherwise, use the event details if available
          if (price == null)
            Obx(() {
              final eventDetails = hallSearchController.selectedEventDetails.value;
              if (eventDetails == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Calculate discount percentage if offer price is available
              int discountPercentage = 0;
              if (eventDetails.price != null && eventDetails.offerPrice != null) {
                try {
                  final price = double.parse(eventDetails.price!);
                  final offerPrice = double.parse(eventDetails.offerPrice!);
                  if (price > 0) {
                    discountPercentage = ((price - offerPrice) / price * 100).round();
                  }
                } catch (e) {
                  print('Error calculating discount: $e');
                }
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "₹${eventDetails.offerPrice ?? eventDetails.price ?? '0'}",
                              style: TextStyle(
                                color: white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp
                              ),
                            ),
                            if (eventDetails.price != null && eventDetails.offerPrice != null)
                              Padding(
                                padding: EdgeInsets.only(left: 4.w),
                                child: Row(
                                  children: [
                                    Text(
                                      "₹${eventDetails.price}",
                                      style: TextStyle(
                                        color: const Color.fromARGB(255, 190, 190, 190),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: white,
                                        fontSize: 10.sp
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      "$discountPercentage% OFF",
                                      style: TextStyle(
                                        color: green,
                                        fontFamily: 'Poppins',
                                        fontSize: 10.sp
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        Text(
                          "+ ₹${(double.parse(eventDetails.offerPrice ?? eventDetails.price ?? '0') * 0.18).round()} taxes & fees",
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
                  GestureDetector(
                    onTap: () {
                      // Navigate to payment screen with hall data
                      Get.to(() => PaymentSreen(), arguments: {
                        'bookingType': 'hall',
                        'hall': hall,
                        'selectedEvent': eventDetails,
                        'price': eventDetails.offerPrice ?? eventDetails.price ?? '0',
                        'startDate': hallSearchController.checkInDate.value,
                        'endDate': hallSearchController.checkOutDate.value,
                      });
                    },
                    child: Container(
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
                  ),
                ],
              );
            }),
        ],
      ),
    );
  }
} 