// ignore_for_file: file_names, avoid_print, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/book_now/book_now.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/pay_now/pay_now.dart';
import 'package:homesloc/core/utils/bottom_sheet_utils.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/calender_controller.dart';

import 'package:homesloc/models/booking/room_availability_model.dart';

class PaymentScreen extends StatelessWidget {
  final String hotelName;
  final String location;
  final double price;
  final String coverImage;
  final BookingDetails? bookingDetails;

  PaymentScreen({
    super.key,
    this.hotelName = "Hotel Name",
    this.location = "Location",
    this.price = 0.0,
    this.coverImage = "https://via.placeholder.com/150",
    this.bookingDetails,
  });

  final calendarController = Get.find<CalendarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.sp,
            color: blue,
          ),
        ),
        title: Text(
          "Confirm & Pay",
          style: TextStyle(
              fontFamily: 'Poppins',
              color: blue,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel Summary Card
            Container(
              margin: EdgeInsets.all(12.r),
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.04),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Hero(
                    tag: 'hotel_image',
                    child: Container(
                      width: 120.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        image: DecorationImage(
                          image: coverImage.startsWith('http')
                              ? NetworkImage(coverImage)
                              : AssetImage(coverImage) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotelName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded,
                                color: yellow, size: 14.sp),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: fontColor,
                                    fontSize: 11.sp),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "4.2",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp),
                                  ),
                                  SizedBox(width: 2.w),
                                  Icon(Icons.star_rounded,
                                      color: yellow, size: 12.sp),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "835 Reviews",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: fontColor,
                                  fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Billing Details Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Text(
                'Billing Details',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: blue,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.04),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildBillingItem(
                    icon: Icons.calendar_month_rounded,
                    title: "Stay Dates",
                    onTap: () =>
                        BottomSheetUtils.showCalendarBottomSheet(context),
                    subtitle: Obx(() => Text(
                          calendarController.checkInDate.value != null &&
                                  calendarController.checkOutDate.value != null
                              ? "${calendarController.formatDate(calendarController.checkInDate.value)} - ${calendarController.formatDate(calendarController.checkOutDate.value)}"
                              : "Select Dates",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Divider(color: border.withOpacity(0.5), height: 1),
                  ),
                  _buildBillingItem(
                    icon: Icons.people_alt_rounded,
                    title: "Guests & Rooms",
                    onTap: () => BottomSheetUtils.showGuestBottomSheet(context),
                    subtitle: Obx(() => Text(
                          "${calendarController.guestCount.value} Guests | ${calendarController.roomCount.value} Rooms",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp),
                        )),
                  ),
                  if (bookingDetails?.dateDetails != null &&
                      bookingDetails!.dateDetails!.any((d) =>
                          d.checkinTime != null && d.checkoutTime != null))
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Divider(
                              color: border.withOpacity(0.5), height: 1),
                        ),
                        _buildBillingItem(
                          icon: Icons.access_time_filled_rounded,
                          title: "Stay Slots",
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: bookingDetails!.dateDetails!
                                .where((d) =>
                                    d.checkinTime != null &&
                                    d.checkoutTime != null)
                                .map((d) => Text(
                                      "${d.checkinTime} - ${d.checkoutTime}",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13.sp),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  if (bookingDetails?.priceSummary != null)
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Divider(
                              color: border.withOpacity(0.5), height: 1),
                        ),
                        _buildBillingItem(
                          icon: Icons.receipt_long_rounded,
                          title: "Price Details",
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: bookingDetails!.priceSummary!.entries
                                .map((e) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e.key
                                                .replaceAll('_', ' ')
                                                .capitalizeFirst!,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: fontColor,
                                                fontSize: 11.sp),
                                          ),
                                          SizedBox(width: 20.w),
                                          Text(
                                            "₹${e.value}",
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: blue,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // Payment Option Section
            Padding(
              padding: EdgeInsets.only(
                  top: 20.h, left: 16.w, right: 16.w, bottom: 8.h),
              child: Text(
                'Payment Method',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: blue,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.04),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPaymentType(
                    title: "Pay In Full",
                    description: "Pay the total now for a faster check-in",
                    isSelected: true,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Preferred Methods",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: fontColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        _buildMethodIcon('assets/images/Picture.png'),
                        _buildMethodIcon('assets/images/Picture (1).png'),
                        _buildMethodIcon('assets/images/Picture (2).png'),
                        _buildMethodIcon('assets/images/Picture (3).png'),
                        _buildMethodIcon('assets/images/Picture (4).png'),
                        Container(
                          margin: EdgeInsets.only(left: 8.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: gwhite,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: blue.withOpacity(0.1)),
                          ),
                          child: Text(
                            '+ Add',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: blue,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Obx(() => PayNow(
                  price: price,
                  hotelName: hotelName,
                  location: location,
                  coverImage: coverImage,
                  checkInDate: calendarController.checkInDate.value != null
                      ? calendarController
                          .formatDate(calendarController.checkInDate.value)
                      : "N/A",
                  checkOutDate: calendarController.checkOutDate.value != null
                      ? calendarController
                          .formatDate(calendarController.checkOutDate.value)
                      : "N/A",
                  bookingDetails: bookingDetails,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingItem(
      {required IconData icon,
      required String title,
      required Widget subtitle,
      VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.sp),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: yellow.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: yellow, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: fontColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500),
                ),
                subtitle,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentType(
      {required String title,
      required String description,
      required bool isSelected}) {
    return Row(
      children: [
        Container(
          width: 20.r,
          height: 20.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: isSelected ? blue : fontColor, width: 2),
          ),
          child: isSelected
              ? Center(
                  child: Container(
                      width: 10.r,
                      height: 10.r,
                      decoration: const BoxDecoration(
                          color: blue, shape: BoxShape.circle)))
              : null,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                style: TextStyle(
                    fontFamily: 'Poppins', color: fontColor, fontSize: 11.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMethodIcon(String asset) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      width: 50.w,
      height: 32.h,
      decoration: BoxDecoration(
        color: gwhite,
        borderRadius: BorderRadius.circular(6.r),
        image: DecorationImage(image: AssetImage(asset), fit: BoxFit.contain),
        border: Border.all(color: border.withOpacity(0.5)),
      ),
    );
  }
}
