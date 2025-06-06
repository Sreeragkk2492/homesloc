// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/payment_screen/payment_screen.dart';
import 'package:homesloc/controller/search/search_fresh_up_controller.dart';

class FreshUpBookNow extends StatelessWidget {
  final dynamic freshUp;
  final String? price;
  const FreshUpBookNow({super.key, this.freshUp, this.price});

  @override
  Widget build(BuildContext context) {
    // Get the fresh up controller
    final freshUpController = Get.find<SearchFreshUpController>();
    
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
            'Book Your Fresh Up Now',
            style: TextStyle(
                color: const Color.fromARGB(255, 190, 190, 190),
                fontFamily: 'Poppins',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Your refreshing stay is just a click away! Book\nnow for a comfortable and relaxing experience.',
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
          // Otherwise, use the room details if available
          if (price == null)
            Obx(() {
              final roomDetails = freshUpController.roomDetails.value;
              if (roomDetails == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final pricePerHead = roomDetails.pricePerHead;
              
              // Calculate discount percentage if offer price is available
              int discountPercentage = 0;
              if (pricePerHead?.perHeadPrice != null && pricePerHead?.offerPrice != null) {
                try {
                  final price = pricePerHead!.perHeadPrice!;
                  final offerPrice = pricePerHead.offerPrice!;
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
                              "₹${pricePerHead?.offerPrice ?? pricePerHead?.perHeadPrice ?? '0'}",
                              style: TextStyle(
                                color: white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp
                              ),
                            ),
                            if (pricePerHead?.perHeadPrice != null && pricePerHead?.offerPrice != null)
                              Padding(
                                padding: EdgeInsets.only(left: 4.w),
                                child: Row(
                                  children: [
                                    Text(
                                      "₹${pricePerHead?.perHeadPrice}",
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
                          "+ ₹${(double.parse((pricePerHead?.offerPrice ?? pricePerHead?.perHeadPrice ?? '0').toString()) * 0.18).round()} taxes & fees",
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
              );
            }),
        ],
      ),
    );
  }
} 