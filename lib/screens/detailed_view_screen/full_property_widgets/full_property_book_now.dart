import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/controller/search/search_hotel_full_properties_controller.dart';
import 'package:homesloc/controller/search/search_hotel_room_details_controller.dart';
import 'package:homesloc/screens/payment_screen/booking_successful/booking_successful.dart';
import 'package:homesloc/screens/payment_screen/payment_screen.dart';

class FullPropertyBookNow extends StatelessWidget {
  final String startDate;
  final String endDate;
  FullPropertyBookNow({required this.startDate, required this.endDate});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final fullPropertyController = Get.find<SearchHotelFullPropertiesController>();
      final roomDetailsController = Get.find<SearchHotelRoomDetailsController>();

      String price = '0';
      dynamic hotelToPass;
      // ROOM type logic
      final roomDetails = roomDetailsController.roomDetails.value;
      final hotelDetails = roomDetails?.hotelDetails;
      final rooms = hotelDetails?.rooms ?? [];
      final selectedIndex = fullPropertyController.selectedRoomIndex.value;

      if (rooms.isNotEmpty && selectedIndex != null && selectedIndex >= 0 && selectedIndex < rooms.length) {
        // Use selected room's price/offerPrice if available
        final selectedRoom = rooms[selectedIndex];
        if (selectedRoom.price != null && selectedRoom.price!.isNotEmpty) {
          price = selectedRoom.price!;
        } else if (selectedRoom.offerPrice != null && selectedRoom.offerPrice!.isNotEmpty) {
          price = selectedRoom.offerPrice!;
        }
        hotelToPass = hotelDetails;
      } else if (roomDetails?.price != null && roomDetails!.price!.isNotEmpty) {
        price = roomDetails.price!;
        hotelToPass = hotelDetails;
      } else if (roomDetails?.offerPrice != null && roomDetails!.offerPrice!.isNotEmpty) {
        price = roomDetails.offerPrice!;
        hotelToPass = hotelDetails;
      } else {
        // For full property, always show basePropertyPrice
        final fullPropertyDetails = fullPropertyController.fullPropertyDetails.value;
        if (fullPropertyDetails?.basePropertyPrice != null && fullPropertyDetails!.basePropertyPrice!.isNotEmpty) {
          price = fullPropertyDetails.basePropertyPrice!;
        }
        hotelToPass = fullPropertyDetails?.hotelDetails;
      }

      // Use the widget's startDate and endDate properties
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
                        "+ ₹${(double.tryParse(price) != null ? (double.parse(price) * 0.18).round() : 0)} taxes & fees",
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
                    Get.to(() => PaymentSreen(), arguments: {
                      'hotel': hotelToPass,
                      'price': price,
                      'startDate': startDate,
                      'endDate': endDate,
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
          ],
        ),
      );
    });
  }
} 