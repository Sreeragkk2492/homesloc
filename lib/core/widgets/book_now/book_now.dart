// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/payment_screen/payment_screen.dart';
import 'package:homesloc/controller/search/search_hotel_room_details_controller.dart';

class BookNow extends StatelessWidget {
  final dynamic hotel;
  final dynamic selectedRoom;
  final String? price;
  const BookNow({super.key, this.hotel, this.selectedRoom, this.price});

  @override
  Widget build(BuildContext context) {
    // Try to find the controller, but don't throw an error if it's not found
    SearchHotelRoomDetailsController? roomDetailsController;
    try {
      roomDetailsController = Get.find<SearchHotelRoomDetailsController>();
    } catch (e) {
      print('RoomDetailsController not found: $e');
    }
    
    return Container(
      padding: EdgeInsets.all(12.r),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      //width: 340.w,
      // height: 180.h,
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
          // If a custom price is provided (for full properties), use it
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
          // Otherwise, use the room details controller if available
          if (price == null && roomDetailsController != null)
            Obx(() {
              final roomDetails = roomDetailsController!.roomDetails.value;
              if (roomDetails == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Calculate discount percentage if offer price is available
              int discountPercentage = 0;
              if (roomDetails.price != null && roomDetails.offerPrice != null) {
                try {
                  final price = double.parse(roomDetails.price!);
                  final offerPrice = double.parse(roomDetails.offerPrice!);
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
                              "₹${roomDetails.offerPrice ?? roomDetails.price ?? '0'}",
                              style: TextStyle(
                                color: white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp
                              ),
                            ),
                            if (roomDetails.price != null && roomDetails.offerPrice != null)
                              Padding(
                                padding: EdgeInsets.only(left: 4.w),
                                child: Row(
                                  children: [
                                    Text(
                                      "₹${roomDetails.price}",
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
                          "+ ₹${(double.parse(roomDetails.offerPrice ?? roomDetails.price ?? '0') * 0.18).round()} taxes & fees",
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
          // Fallback if neither price nor roomDetailsController is available
          if (price == null && roomDetailsController == null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "₹0",
                        style: TextStyle(
                          color: white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp
                        ),
                      ),
                      Text(
                        "+ ₹0 taxes & fees",
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
  }
}


