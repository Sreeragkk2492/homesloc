// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/payment_screen/payment_screen.dart';
import 'package:homesloc/models/home/hall_detail_model.dart';
import 'package:homesloc/apis/home/hotel_detail_service.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:intl/intl.dart';
import 'package:homesloc/models/booking/room_availability_model.dart'
    as room_model;

class HallBookNow extends StatelessWidget {
  final HallDetailModel hall;

  const HallBookNow({
    super.key,
    required this.hall,
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
            'Book Your Hall Now',
            style: TextStyle(
                color: const Color.fromARGB(255, 230, 230, 230),
                fontFamily: 'Poppins',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Text(
            'Plan your event with ease! Check availability and book now.',
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
                        "₹${_getPrice()}",
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

                  if (calendarController.checkInDate.value == null ||
                      calendarController.checkOutDate.value == null) {
                    Get.snackbar(
                      "Dates Required",
                      "Please select check-in and check-out dates",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.withOpacity(0.8),
                      colorText: white,
                    );
                    return;
                  }

                  if (hall.eventAreas != null && hall.eventAreas!.isNotEmpty) {
                    // Use the first event area for now
                    String eventId = hall.eventAreas!.first.id!;

                    final dateFormat = DateFormat('yyyy-MM-dd');
                    final checkIn = dateFormat
                        .format(calendarController.checkInDate.value!);
                    final checkOut = dateFormat
                        .format(calendarController.checkOutDate.value!);

                    final hallResult =
                        await hotelDetailService.checkHallAvailability(
                      eventId: eventId,
                      checkIn: checkIn,
                      checkOut: checkOut,
                    );

                    if (hallResult != null &&
                        hallResult.isAvailable == true &&
                        hallResult.bookingDetails != null) {
                      // Map Hall BookingDetails to Room BookingDetails
                      final hallBooking = hallResult.bookingDetails!;
                      final roomBookingDetails = room_model.BookingDetails(
                        checkin: hallBooking.startDate,
                        checkout: hallBooking.endDate,
                        nights: hallBooking
                            .days, // Assuming days maps to nights or similar logic
                        days: hallBooking.days,
                        adults: calendarController.guestCount.value,
                        children: 0,
                        roomsRequested: 1, // Halls usually booked as 1 unit
                        price: hallBooking.price,
                        offerPrice: hallBooking.offerPrice,
                        priceSummary: hallBooking.priceSummary?.toJson(),
                        // Map DateDetails if necessary, though PaymentScreen might not use all of it deeply
                      );

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PaymentScreen(
                          hotelName: hallResult.hallDetails?.name ?? hall.name,
                          location:
                              hallResult.hallDetails?.location ?? hall.location,
                          price: hallResult.bookingDetails?.price ?? 0.0,
                          coverImage: hallResult.hallDetails?.coverImageUrl ??
                              hall.coverImageUrl ??
                              "",
                          bookingDetails: roomBookingDetails,
                        );
                      }));
                    } else {
                      Get.snackbar(
                        "Not Available",
                        "Hall is not available for selected dates",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.withOpacity(0.8),
                        colorText: white,
                      );
                    }
                  } else {
                    Get.snackbar(
                      "Error",
                      "No event area found for this hall",
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

  String _getPrice() {
    return hall.bestPrice ?? '0';
  }
}
