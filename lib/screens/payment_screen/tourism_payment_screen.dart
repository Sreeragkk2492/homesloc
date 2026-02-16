import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/tourism/tourism_availability_model.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/tourism/tourism_detail_controller.dart';
import 'package:homesloc/core/widgets/pay_now/tourism_pay_now.dart';

class TourismPaymentScreen extends StatelessWidget {
  final String packageName;
  final String destination;
  final double price;
  final String coverImage;
  final BookingDetails? bookingDetails;

  const TourismPaymentScreen({
    super.key,
    required this.packageName,
    required this.destination,
    required this.price,
    required this.coverImage,
    this.bookingDetails,
  });

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
            // Summary Card
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
                  Container(
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
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          packageName,
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
                                destination,
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
                'Booking Details',
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
                    title: "Travel Date",
                    subtitle: Text(
                      bookingDetails?.checkin ?? "N/A",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp),
                    ),
                  ),
                  if (bookingDetails?.priceSummary?.packagePrice != null) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Divider(color: border.withOpacity(0.5), height: 1),
                    ),
                    _buildBillingItem(
                      icon: Icons.receipt_long_rounded,
                      title: "Price Breakdown",
                      subtitle: Text(
                        bookingDetails!.priceSummary!.packagePrice!,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp),
                      ),
                    ),
                  ],
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
                    description: "Secure your booking instantly",
                    isSelected: true,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      _buildMethodIcon('assets/images/Picture.png'),
                      _buildMethodIcon('assets/images/Picture (1).png'),
                      _buildMethodIcon('assets/images/Picture (2).png'),
                    ],
                  ),
                ],
              ),
            ),

            TourismPayNow(
              price: price,
              packageName: packageName,
              destination: destination,
              checkInDate: bookingDetails?.checkin ?? "",
              coverImage: coverImage,
              bookingDetails: bookingDetails,
              onPayNow: () {
                // Get controller and call booking method
                final controller = Get.find<TourismDetailController>();
                controller.confirmTourismBooking(
                  packageName: packageName,
                  destination: destination,
                  coverImage: coverImage,
                  totalAmount: bookingDetails?.offerPrice ??
                      bookingDetails?.price ??
                      price,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingItem(
      {required IconData icon,
      required String title,
      required Widget subtitle}) {
    return Padding(
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
