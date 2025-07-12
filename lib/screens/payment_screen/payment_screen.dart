// ignore_for_file: file_names, avoid_print, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/book_now/book_now.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/pay_now/pay_now.dart';
import 'package:get/get.dart';

class PaymentSreen extends StatelessWidget {
  const PaymentSreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final bookingType = args['bookingType'] ?? 'hotel'; // 'hotel', 'hall', 'freshup'
    final hotel = args['hotel'];
    final hall = args['hall'];
    final freshup = args['freshup'];
    final selectedEvent = args['selectedEvent']; // For hall bookings
    final price = args['price'] ?? '0';
    final startDate = args['startDate'] ?? '';
    final endDate = args['endDate'] ?? '';
    
    // Get the appropriate data based on booking type
    final bookingData = _getBookingData(bookingType, hotel, hall, freshup, selectedEvent);

    // Calculate number of nights
    int numberOfNights = 1;
    try {
      if (startDate.isNotEmpty && endDate.isNotEmpty) {
        final start = DateTime.parse(startDate);
        final end = DateTime.parse(endDate);
        numberOfNights = end.difference(start).inDays;
        if (numberOfNights < 1) numberOfNights = 1;
      }
    } catch (_) {
      numberOfNights = 1;
    }

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: white,
        leading: Icon(
          (Icons.arrow_back_ios_new_rounded),
          size: 20.sp,
          color: blue,
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 40.w),
          child: Text(
            "Confirm & Pay",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: blue,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
              width: 339.w,
              height: 130.h,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(15.sp),
                boxShadow: [
                  BoxShadow(
                    color: fontColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5.w, top: 1.h),
                    width: 144.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.sp),
                      image: DecorationImage(
                          image: NetworkImage(bookingData['coverImageUrl'] ?? ''),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 11.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                         Text(
                                          (bookingData['name'] ?? '').length > 20
                                              ? "${(bookingData['name'] ?? '').substring(0, 16)}..."
                                              : bookingData['name'] ?? '',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                        // Text(
                        //   hotel != null && hotel.name != null ? hotel.name : "Hotel Name",
                        //   style: TextStyle(
                        //       fontFamily: 'Poppins',
                        //       color: black,
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 16.sp),
                        // ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            Image(
                              image: AssetImage('assets/images/Frame (8).png'),
                              width: 15.w,
                              height: 15.h,
                              color: blue,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              bookingData['city'] ?? "Location",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 15.h,
                              decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(3.sp),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (bookingData['starRating'] ?? 0).toString(),
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: white,
                                        fontSize: 10.sp),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: yellow,
                                    size: 12.sp,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "835 Reviews",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: fontColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "2 Adult  |   1 Children",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: black,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 14.h, left: 10.w, bottom: 5.h, right: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Billing Details',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: blue,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    bookingType == 'freshup' ? "Service Date" : "Dates",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                  Text(
                    bookingType == 'freshup' 
                        ? "Same day service" 
                        : (startDate != '' && endDate != '' ? "$startDate - $endDate" : "Select Dates"),
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: fontColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    bookingType == 'freshup' ? "Service Type" : "Guests",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                  Text(
                    bookingType == 'freshup' 
                        ? _getFreshupServiceType(freshup)
                        : "2 Adult   |  1 Child",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: fontColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            HomeDivider(),
            Padding(
              padding: EdgeInsets.only(
                  top: 5.h, left: 10.w, bottom: 5.h, right: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: blue,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Pay In Full",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                  Text(
                    "Pay the total now and you are all set.",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: fontColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                   Text(
                    "Advance / Pay Later",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                  Text(
                    "Pay part now and  your are all set.",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: fontColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Payment Method",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                   Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5.w),
                        width: 50.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.sp),
                          image: DecorationImage(
                              image: AssetImage('assets/images/Picture.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5.w),
                        width: 50.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.sp),
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/Picture (1).png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5.w),
                        width: 50.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.sp),
                          image: DecorationImage(
                              image: AssetImage('assets/images/Picture (2).png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                        Container(
                        margin: EdgeInsets.only(right: 5.w),
                        width: 50.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.sp),
                          image: DecorationImage(
                              image: AssetImage('assets/images/Picture (3).png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20.w),
                        width: 50.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.sp),
                          image: DecorationImage(
                              image: AssetImage('assets/images/Picture (4).png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        width: 50.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: gwhite,
                          borderRadius: BorderRadius.circular(13.sp),
                        ),
                        child: Center(
                          child: Text(
                            'Add',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: blue,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Builder(
                builder: (context) {
                  final priceValue = double.tryParse(price) ?? 0.0;
                  final tax = (priceValue * 0.18).round();
                  
                  // For freshup, it's a single service, not multiple nights
                  final isFreshup = bookingType == 'freshup';
                  final basePrice = isFreshup ? priceValue : priceValue * numberOfNights;
                  final total = basePrice + tax;
                  final displayNights = isFreshup ? 1 : numberOfNights;
                  
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     PayNow(
                        basePrice: basePrice,
                        tax: tax.toDouble(),
                        total: total,
                        numberOfNights: displayNights,
                      ),
                      // Pass values to PayNow
                     
                    ],
                  );
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  // Helper method to get booking data based on type
  Map<String, dynamic> _getBookingData(String bookingType, dynamic hotel, dynamic hall, dynamic freshup, dynamic selectedEvent) {
    switch (bookingType) {
      case 'hotel':
        return {
          'name': hotel?.name ?? 'Hotel',
          'coverImageUrl': hotel?.coverImageUrl ?? '',
          'city': hotel?.city ?? 'Location',
          'starRating': hotel?.starRating ?? 0,
        };
      case 'hall':
        // If we have selectedEvent (which contains hall details), use that
        if (selectedEvent != null && selectedEvent.hallDetails != null) {
          return {
            'name': selectedEvent.hallDetails?.name ?? hall?.name ?? 'Hall',
            'coverImageUrl': selectedEvent.hallDetails?.coverImageUrl ?? hall?.coverImage ?? '',
            'city': selectedEvent.hallDetails?.city ?? hall?.locationInfo?.city ?? 'Location',
            //'starRating': selectedEvent.hallDetails?.startingRange ?? hall?.startingRange ?? 0,
          };
        }
        // Otherwise use the hall object directly
        return {
          'name': hall?.name ?? 'Hall',
          'coverImageUrl': hall?.coverImage ?? '',
          'city': hall?.locationInfo?.city ?? 'Location',
          'starRating': hall?.startingRange ?? 0,
        };
      case 'freshup':
        // Extract data from FreshUpRoomDetailsModel
        final propertyDetails = freshup?.propertyDetails;
        final pricePerRoom = freshup?.pricePerRoom;
        final pricePerHead = freshup?.pricePerHead;
        
        // Get the appropriate price details based on price method
        final isPerRoom = freshup?.priceMethod == "PER_ROOM";
        final priceDetails = isPerRoom ? pricePerRoom : pricePerHead;
        
        return {
          'name': propertyDetails?.name ?? priceDetails?.freshupName ?? 'Freshup',
          'coverImageUrl': propertyDetails?.coverImageUrl ?? freshup?.images?.firstOrNull ?? '',
          'city': propertyDetails?.city ?? 'Location',
          'starRating': propertyDetails?.starRating?.toInt() ?? 0,
        };
      default:
        return {
          'name': 'Property',
          'coverImageUrl': '',
          'city': 'Location',
          'starRating': 0,
        };
    }
  }

  // Helper method to get freshup service type
  String _getFreshupServiceType(dynamic freshup) {
    if (freshup == null) return "Freshup Service";
    
    final pricePerRoom = freshup.pricePerRoom;
    final pricePerHead = freshup.pricePerHead;
    final isPerRoom = freshup.priceMethod == "PER_ROOM";
    
    if (isPerRoom && pricePerRoom != null) {
      return "${pricePerRoom.freshupType ?? 'Room'} - ${pricePerRoom.freshupName ?? 'Service'}";
    } else if (pricePerHead != null) {
      return "${pricePerHead.freshupType ?? 'Per Head'} - ${pricePerHead.freshupName ?? 'Service'}";
    }
    
    return "Freshup Service";
  }
}
