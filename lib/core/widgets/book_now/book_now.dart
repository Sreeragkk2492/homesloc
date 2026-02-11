// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/payment_screen/payment_screen.dart';
import 'package:homesloc/models/home/hotel_detail_model.dart';

class BookNow extends StatelessWidget {
  final dynamic hotel;
  const BookNow({super.key, this.hotel});

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
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PaymentSreen(
                      hotelName: _getName(),
                      location: _getLocation(),
                      price: double.tryParse(_getPrice()) ?? 0.0,
                      coverImage: _getCoverImage(),
                    );
                  }));
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
