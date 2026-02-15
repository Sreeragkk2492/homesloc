import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/apis/home/hotel_detail_service.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/search/search_hotel_model.dart';
import 'package:homesloc/screens/payment_screen/payment_screen.dart';
import 'package:intl/intl.dart';

class FreshupBookNow extends StatelessWidget {
  final Hotel freshup;
  final List<String> selectedSlotIds;
  const FreshupBookNow({
    super.key,
    required this.freshup,
    this.selectedSlotIds = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(23.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Text(
            'Book Short Stay',
            style: TextStyle(
                color: const Color.fromARGB(255, 230, 230, 230),
                fontFamily: 'Poppins',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Text(
            'Refresh and recharge with our short stay options.',
            style: TextStyle(
                color: const Color.fromARGB(255, 200, 200, 200),
                fontFamily: 'Poppins',
                fontSize: 13.sp,
                fontWeight: FontWeight.w300),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Divider(
              color: const Color.fromARGB(255, 150, 150, 150),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹${freshup.originalPrice ?? '0'}",
                        style: TextStyle(
                            color: white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 23.sp),
                      ),
                    ],
                  ),
                  Text(
                    "+ Taxes & Fees",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 190, 190, 190),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp),
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  final calendarController = Get.find<CalendarController>();
                  final HotelDetailService hotelDetailService =
                      HotelDetailService();

                  if (calendarController.checkInDate.value == null) {
                    Get.snackbar(
                      "Date Required",
                      "Please select check-in date",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.withOpacity(0.8),
                      colorText: white,
                    );
                    return;
                  }

                  if (selectedSlotIds.isEmpty) {
                    Get.snackbar(
                      "Slot Required",
                      "Please select at least one stay slot",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.withOpacity(0.8),
                      colorText: white,
                    );
                    return;
                  }

                  final dateFormat = DateFormat('yyyy-MM-dd');
                  final date =
                      dateFormat.format(calendarController.checkInDate.value!);

                  // Show loading dialog
                  Get.dialog(
                    Center(child: CircularProgressIndicator(color: yellow)),
                    barrierDismissible: false,
                  );

                  final result =
                      await hotelDetailService.searchFreshupAvailability(
                    slotIds: selectedSlotIds,
                    roomType: freshup.freshupDetails?.freshupType ?? "Standard",
                    checkIn: date,
                    adults: calendarController.guestCount.value,
                    children: 0, // Children count if available
                  );

                  Get.back(); // Hide loading dialog

                  if (result != null &&
                      result.isAvailable == true &&
                      result.bookingDetails != null) {
                    // Same day checkout for Freshup
                    calendarController.checkOutDate.value =
                        calendarController.checkInDate.value;

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PaymentScreen(
                        hotelName: result.serviceDetails?.name ??
                            freshup.name ??
                            "Property",
                        location: result.serviceDetails?.location ??
                            freshup.location ??
                            "Location",
                        price: result.bookingDetails?.price?.toDouble() ??
                            double.tryParse(freshup.originalPrice ?? '0') ??
                            0.0,
                        coverImage: result.serviceDetails?.coverImageUrl ??
                            freshup.coverImageUrl ??
                            "",
                        bookingDetails: result.bookingDetails,
                      );
                    }));
                  } else {
                    Get.snackbar(
                      "Not Available",
                      "Freshup not available for selected slots/criteria",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.withOpacity(0.8),
                      colorText: white,
                    );
                  }
                },
                child: Container(
                  width: 140.w,
                  height: 43.h,
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(28.sp),
                  ),
                  child: Center(
                    child: Text(
                      "BOOK NOW",
                      style: TextStyle(
                          color: black,
                          fontSize: 15.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
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
