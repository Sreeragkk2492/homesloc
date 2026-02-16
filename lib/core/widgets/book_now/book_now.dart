// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/payment_screen/payment_screen.dart';
import 'package:homesloc/models/home/hotel_detail_model.dart';
import 'package:homesloc/models/search/search_hotel_model.dart';
import 'package:homesloc/models/home/hall_detail_model.dart';
import 'package:homesloc/apis/home/hotel_detail_service.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:intl/intl.dart';

class BookNow extends StatelessWidget {
  final dynamic hotel;
  final bool isFullProperty;

  const BookNow({
    super.key,
    this.hotel,
    this.isFullProperty = false,
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
            'Book Your Stay Now',
            style: TextStyle(
                color: const Color.fromARGB(255, 230, 230, 230),
                fontFamily: 'Poppins',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Text(
            'Your dream stay is just a click away! Book now for a seamless experience.',
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
                      if (_getOriginalPrice() != _getPrice()) ...[
                        SizedBox(width: 8.w),
                        Text(
                          "₹${_getOriginalPrice()}",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 190, 190, 190),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: white,
                              fontSize: 12.sp),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    _getTaxInfo(),
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

                  // Get ID (Room ID or Property ID)
                  String? id;
                  if (hotel is HotelDetailModel) {
                    id = hotel.id;
                  } else if (hotel is HallDetailModel) {
                    id = hotel.id;
                  } else if (hotel is Hotel) {
                    // From search model
                    id = hotel.id;
                  }

                  if (id != null) {
                    final dateFormat = DateFormat('yyyy-MM-dd');
                    final checkIn = dateFormat
                        .format(calendarController.checkInDate.value!);
                    final checkOut = dateFormat
                        .format(calendarController.checkOutDate.value!);

                    dynamic result;

                    if (isFullProperty) {
                      // Perform Full Property Availability Check
                      result = await hotelDetailService
                          .checkFullPropertyAvailability(
                        propertyId: id,
                        checkIn: checkIn,
                        checkOut: checkOut,
                        adults: calendarController.guestCount.value,
                        children: 0, // Default 0
                      );
                    } else {
                      // Perform Room Availability Check
                      result = await hotelDetailService.checkRoomAvailability(
                        roomId: id,
                        checkIn: checkIn,
                        checkOut: checkOut,
                        adults: calendarController.guestCount.value,
                        children: 0, // Default 0
                        rooms: calendarController.roomCount.value,
                      );
                    }

                    if (result != null && result.bookingDetails != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PaymentScreen(
                          hotelName: _getName(),
                          location: _getLocation(),
                          price:
                              result.bookingDetails?.price?.toDouble() ?? 0.0,
                          coverImage: _getCoverImage(),
                          bookingDetails: result.bookingDetails,
                          propertyId: id,
                          propertyType:
                              isFullProperty ? "FULL_PROPERTY" : "ROOM",
                        );
                      }));
                    } else {
                      Get.snackbar(
                        "Not Available",
                        "Accommodation is not available for selected dates",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.withOpacity(0.8),
                        colorText: white,
                      );
                    }
                  } else {
                    // Fallback - no property info available
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PaymentScreen(
                        hotelName: _getName(),
                        location: _getLocation(),
                        price: double.tryParse(_getPrice()) ?? 0.0,
                        coverImage: _getCoverImage(),
                        // No propertyId/propertyType - booking won't work
                      );
                    }));
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
    if (hotel is HallDetailModel) {
      return hotel.bestPrice ?? '0';
    }
    if (hotel is HotelDetailModel) {
      final p = hotel.pricing;
      if (p == null) return '0';
      return (p.offerPrice ?? p.bestPrice ?? '0').toString();
    }
    try {
      if (hotel.runtimeType.toString() == 'BestHotel') {
        return (hotel.pricing?.offerPrice ?? hotel.pricing?.bestPrice ?? '0')
            .toString();
      } else {
        return (hotel.priceRange?.min ?? '0').toString();
      }
    } catch (e) {
      return '0';
    }
  }

  String _getOriginalPrice() {
    if (hotel is HallDetailModel) {
      return hotel.bestPrice ??
          '0'; // Halls might not have separate original price
    }
    if (hotel is HotelDetailModel) {
      return (hotel.pricing?.bestPrice ?? '0').toString();
    }
    try {
      if (hotel.runtimeType.toString() == 'BestHotel') {
        return (hotel.pricing?.bestPrice ?? '0').toString();
      } else {
        return (hotel.priceRange?.max ?? '0').toString();
      }
    } catch (e) {
      return '0';
    }
  }

  String _getTaxInfo() {
    if (hotel is HallDetailModel) {
      return "+ Taxes & Fees";
    }
    if (hotel is HotelDetailModel) {
      return hotel.pricing?.taxInfo ?? "+ Taxes & Fees";
    }
    return "+ Taxes & Fees";
  }

  String _getName() {
    try {
      return hotel.name ?? 'Hotel Name';
    } catch (e) {
      return 'Hotel Name';
    }
  }

  String _getLocation() {
    try {
      if (hotel is HotelDetailModel) return hotel.location ?? 'Location';
      if (hotel.runtimeType.toString() == 'BestHotel') {
        return hotel.location ?? 'Location';
      } else {
        return hotel.locationInfo?.city ??
            hotel.locationInfo?.address ??
            'Location';
      }
    } catch (e) {
      return 'Location';
    }
  }

  String _getCoverImage() {
    try {
      return hotel.coverImageUrl ?? 'https://via.placeholder.com/150';
    } catch (e) {
      return 'https://via.placeholder.com/150';
    }
  }
}
