import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/myBooking/my_booking_controller.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/booking/booking_model.dart';
import 'package:homesloc/models/booking/room_availability_model.dart';

class PayNow extends StatelessWidget {
  final double price;
  final String hotelName;
  final String location;
  final String coverImage;
  final String checkInDate;
  final String checkOutDate;
  final BookingDetails? bookingDetails;
  final VoidCallback? onPayNow;

  PayNow({
    super.key,
    required this.price,
    required this.hotelName,
    required this.location,
    required this.coverImage,
    required this.checkInDate,
    required this.checkOutDate,
    this.bookingDetails,
    this.onPayNow,
  });

  final calendarController = Get.find<CalendarController>();
  final tripController = Get.put(TripController());

  @override
  Widget build(BuildContext context) {
    // If we have API booking details, use them
    if (bookingDetails != null) {
      debugPrint(
          "PayNow building with bookingDetails: price=${bookingDetails!.price}, offerPrice=${bookingDetails!.offerPrice}, hasSummary=${bookingDetails!.priceSummary != null}");
      if (bookingDetails!.priceSummary != null) {
        debugPrint("Price Summary Keys: ${bookingDetails!.priceSummary!.keys}");
      }

      final double grandTotal =
          (bookingDetails!.offerPrice ?? bookingDetails!.price ?? 0).toDouble();

      return Container(
        margin: EdgeInsets.only(top: 15, right: 10.w, left: 10.w, bottom: 20.h),
        decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.circular(23.sp),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Price Details',
                style: TextStyle(
                    color: const Color.fromARGB(255, 190, 190, 190),
                    fontFamily: 'Poppins',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),

              // Show summary from API if available
              // if (bookingDetails!.priceSummary != null &&
              //     bookingDetails!.priceSummary!.isNotEmpty) ...[
              //   ...bookingDetails!.priceSummary!.entries.map((entry) {
              //     final String label = entry.key
              //         .replaceAll('_', ' ')
              //         .split(' ')
              //         .map((s) => s.capitalizeFirst)
              //         .join(' ');
              //     final String value = entry.value.toString().contains('=')
              //         ? entry.value.toString().split('=').last.trim()
              //         : entry.value.toString();

              //     return Padding(
              //       padding: EdgeInsets.only(bottom: 6.h),
              //       child: _buildPriceRow(label, "₹$value"),
              //     );
              //   }),
              // ] else ...[
              //   _buildPriceRow(
              //     'Total Price',
              //     '₹${bookingDetails!.price}',
              //   ),
              // ],

              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Divider(
                  color: const Color.fromARGB(255, 190, 190, 190),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grand Total',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 190, 190, 190),
                        fontFamily: 'Poppins',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "₹${grandTotal.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 23.sp),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: InkWell(
                  onTap: () {
                    if (onPayNow != null) {
                      onPayNow!();
                    } else {
                      _proceedToPay(context, grandTotal);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.circular(28.sp),
                    ),
                    child: Center(
                      child: Text(
                        "Pay Now",
                        style: TextStyle(
                            color: black,
                            fontSize: 16.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // FALLBACK TO OLD LOGIC
    return Obx(() {
      final int numberOfNights = calendarController.totalDays.value > 0
          ? calendarController.totalDays.value
          : 1;
      final int numberOfRooms = calendarController.roomCount.value;

      // Base calculation
      final double nightlyRate = price;
      final double subtotal = nightlyRate * numberOfNights * numberOfRooms;

      // Placeholder calculations (can be refined with real API data later)
      final double taxesAndFees = subtotal * 0.12; // 12% GST/Fees
      final double discount =
          subtotal > 5000 ? 500.0 : 0.0; // Sample discount logic

      final double grandTotal = subtotal - discount + taxesAndFees;

      return Container(
        margin: EdgeInsets.only(top: 15, right: 10.w, left: 10.w, bottom: 20.h),
        decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.circular(23.sp),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Price Details',
                style: TextStyle(
                    color: const Color.fromARGB(255, 190, 190, 190),
                    fontFamily: 'Poppins',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              _buildPriceRow(
                '₹${nightlyRate.toStringAsFixed(0)} x $numberOfNights Nights (${numberOfRooms} Room)',
                '₹${subtotal.toStringAsFixed(2)}',
              ),
              if (discount > 0) ...[
                SizedBox(height: 6.h),
                _buildPriceRow(
                  'Discount',
                  '-₹${discount.toStringAsFixed(2)}',
                ),
              ],
              SizedBox(height: 6.h),
              _buildPriceRow(
                'Occupancy taxes and fees',
                '₹${taxesAndFees.toStringAsFixed(2)}',
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Divider(
                  color: const Color.fromARGB(255, 190, 190, 190),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grand Total',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 190, 190, 190),
                        fontFamily: 'Poppins',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "₹${grandTotal.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 23.sp),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: InkWell(
                  onTap: () {
                    _proceedToPay(context, grandTotal);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.circular(28.sp),
                    ),
                    child: Center(
                      child: Text(
                        "Pay Now",
                        style: TextStyle(
                            color: black,
                            fontSize: 16.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _proceedToPay(BuildContext context, double grandTotal) {
    final int numberOfNights = bookingDetails?.nights ??
        (calendarController.totalDays.value > 0
            ? calendarController.totalDays.value
            : 1);

    final booking = BookingModel(
      hotelName: hotelName,
      totalAmount: grandTotal,
      numberOfNights: numberOfNights,
      checkInDate: calendarController.checkInDate.value ?? DateTime.now(),
      checkOutDate: calendarController.checkOutDate.value ??
          DateTime.now().add(const Duration(days: 1)),
    );
    tripController.addBooking(booking);

    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return BookingSuccessful(
    //     hotelName: hotelName,
    //     location: location,
    //     price: grandTotal.toStringAsFixed(0),
    //     checkInDate: checkInDate,
    //     checkOutDate: checkOutDate,
    //     coverImage: coverImage,
    //   );
    // }));
  }

  Widget _buildPriceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
              color: const Color.fromARGB(255, 190, 190, 190),
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              fontWeight: FontWeight.w300),
        ),
        Text(
          value,
          style: TextStyle(
              color: const Color.fromARGB(255, 190, 190, 190),
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
