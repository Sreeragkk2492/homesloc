import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/freshup/freshup_booking_details_model.dart';

class FreshupPayNow extends StatelessWidget {
  final FreshupBookingDetails bookingDetails;
  final VoidCallback onPayNow;

  const FreshupPayNow({
    super.key,
    required this.bookingDetails,
    required this.onPayNow,
  });

  @override
  Widget build(BuildContext context) {
    // print(
    //     '💰 FreshupPayNow: bookingDetails.price=${bookingDetails.price}, bookingDetails.offerPrice=${bookingDetails.offerPrice}');
    // final double grandTotal =
    //     (bookingDetails.offerPrice ?? bookingDetails.price ?? 0).toDouble();
    // print('💰 FreshupPayNow: grandTotal=$grandTotal');

    return Container(
      margin: EdgeInsets.only(top: 15.h, right: 10.w, left: 10.w, bottom: 20.h),
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(23.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
            SizedBox(height: 12.h),

            // // Dynamic Price Summary from API
            // if (bookingDetails.priceSummary != null &&
            //     bookingDetails.priceSummary!.isNotEmpty)
            //   ...bookingDetails.priceSummary!.entries.map((entry) {
            //     final String label = entry.key
            //         .replaceAll('_', ' ')
            //         .split(' ')
            //         .map((s) => s.capitalizeFirst)
            //         .join(' ');

            //     final String value = entry.value.toString().contains('=')
            //         ? entry.value.toString().split('=').last.trim()
            //         : entry.value.toString();

            //     return Padding(
            //       padding: EdgeInsets.only(bottom: 8.h),
            //       child: _buildPriceRow(label, "₹$value"),
            //     );
            //   })
            // else
            //   Padding(
            //     padding: EdgeInsets.only(bottom: 8.h),
            //     child: _buildPriceRow('Base Price', '₹${bookingDetails.price}'),
            //   ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Divider(
                color:
                    const Color.fromARGB(255, 190, 190, 190).withOpacity(0.3),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Grand Total',
                  style: TextStyle(
                      color: white.withOpacity(0.8),
                      fontFamily: 'Poppins',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "₹${bookingDetails.offerPrice?.toStringAsFixed(0)}",
                  style: TextStyle(
                      color: white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            InkWell(
              onTap: onPayNow,
              child: Container(
                width: double.infinity,
                height: 52.h,
                decoration: BoxDecoration(
                  color: yellow,
                  borderRadius: BorderRadius.circular(28.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
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
            SizedBox(height: 15.h),
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
              fontWeight: FontWeight.w400),
        ),
        Text(
          value,
          style: TextStyle(
              color: white.withOpacity(0.9),
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
