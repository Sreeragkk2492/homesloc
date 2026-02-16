import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/tourism/tourism_availability_model.dart';

class TourismPayNow extends StatelessWidget {
  final double price;
  final String packageName;
  final String destination;
  final String checkInDate;
  final String coverImage;
  final BookingDetails? bookingDetails;
  final VoidCallback onPayNow;

  const TourismPayNow({
    super.key,
    required this.price,
    required this.packageName,
    required this.destination,
    required this.checkInDate,
    required this.coverImage,
    this.bookingDetails,
    required this.onPayNow,
  });

  @override
  Widget build(BuildContext context) {
    final double grandTotal =
        (bookingDetails?.offerPrice ?? bookingDetails?.price ?? price)
            .toDouble();

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
            if (bookingDetails?.priceSummary?.packagePrice != null) ...[
              _buildPriceRow("Package Price", "₹${bookingDetails!.price}"),
            ] else ...[
              _buildPriceRow('Total Price', '₹${price.toStringAsFixed(2)}'),
            ],
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: const Divider(
                color: Color.fromARGB(255, 190, 190, 190),
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
                onTap: onPayNow,
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
