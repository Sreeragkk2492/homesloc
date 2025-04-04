import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/myBooking/my_booking_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/booking/booking_model.dart';
import 'package:homesloc/screens/payment_screen/booking_successful/booking_successful.dart';

class PayNow extends StatelessWidget {
  PayNow({super.key});

  final screenController = Get.put(TripController());

  @override
  Widget build(BuildContext context) {
    // Logical data
    final double nightlyRate = 120.0;
    final int numberOfNights = 30;
    final double discount = 50.0;
    final double taxesAndFees = 15.0;

    // Calculations
    final double subtotal = nightlyRate * numberOfNights;
    final double totalDiscount = discount;
    final double totalTaxesAndFees = taxesAndFees;
    final double grandTotal = subtotal - totalDiscount + totalTaxesAndFees;

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
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Price Details',
              style: TextStyle(
                  color: const Color.fromARGB(255, 190, 190, 190),
                  fontFamily: 'Poppins',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹$nightlyRate x $numberOfNights Nights',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 190, 190, 190),
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w100),
                ),
                Text(
                  '₹${subtotal.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 190, 190, 190),
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
            SizedBox(
              height: 6.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discount',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 190, 190, 190),
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w100),
                ),
                Text(
                  '-₹${totalDiscount.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 190, 190, 190),
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
            SizedBox(
              height: 6.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Occupancy taxes and fees',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 190, 190, 190),
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w100),
                ),
                Text(
                  '₹${totalTaxesAndFees.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 190, 190, 190),
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Divider(
                color: const Color.fromARGB(255, 190, 190, 190),
              ),
            ),
            Column(
              children: [
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
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: InkWell(
                    onTap: () {
                      final booking = BookingModel(
                        hotelName:
                            'Issacs Residency', // Replace with actual hotel name
                        totalAmount: grandTotal,
                        numberOfNights: numberOfNights,
                        checkInDate:
                            DateTime.now(), // Replace with actual check-in date
                        checkOutDate:
                            DateTime.now().add(Duration(days: numberOfNights)),
                      );
                      screenController.addBooking(booking);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BookingSuccessful();
                      }));
                    },
                    child: Container(
                      width: 300.w,
                      height: 43.h,
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
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
