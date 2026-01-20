// ignore_for_file: file_names, avoid_print, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/detailed_view_screen/amenitie_row/amenitie_row.dart';
import 'package:homesloc/screens/detailed_view_screen/property_row/property_first_row.dart';
import 'package:homesloc/screens/detailed_view_screen/property_row/property_second_row.dart';
import 'package:homesloc/screens/detailed_view_screen/property_row/property_third_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_first_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_second_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_third_row.dart';
import 'package:homesloc/screens/detailed_view_screen/transportation_row/transportations_first_row.dart';
import 'package:homesloc/screens/detailed_view_screen/transportation_row/transportations_second_row.dart';
import 'package:homesloc/core/widgets/yellow_star/yellow_star.dart';
import 'package:homesloc/core/widgets/book_now/book_now.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/first_detailed_view_builder.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/second_detailed_view_builder.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';

class DetailedViewScreen extends StatelessWidget {
  final dynamic hotel;
  const DetailedViewScreen({super.key, this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            (Icons.arrow_back_ios_new_rounded),
            size: 20.sp,
            color: blue,
          ),
        ),
        title: Center(
          child: Text(
            _getName(),
            style: TextStyle(
                fontFamily: 'Poppins',
                color: blue,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('favorite button');
            },
            icon: Icon(
              Icons.favorite_outline_rounded,
              color: blue,
              size: 25.sp,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: blue,
              height: 180.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _getCoverImage().startsWith('http')
                      ? NetworkImage(_getCoverImage())
                      : AssetImage(_getCoverImage()) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 98.h,
              // color: yellow,
              child: FirstDetailedViewBuilder(
                hotel: hotel,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Property highlights',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: blue,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  Container(
                    width: 67.w,
                    height: 22.h,
                    decoration: BoxDecoration(
                      color: gwhite,
                      borderRadius: BorderRadius.circular(4.sp),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 12.sp,
                          color: blue,
                        ),
                        Text(
                          'Location',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: blue,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.h, right: 10.w),
                    child: Image(
                      image: AssetImage('assets/images/Frame (8).png'),
                      width: 15.w,
                      height: 15.h,
                      color: blue,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _getLocation(),
                      style: TextStyle(
                          fontFamily: 'Poppins', color: black, fontSize: 13.sp),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.h, right: 10.w),
                    child: Image(
                      image: AssetImage('assets/images/Frame (9).png'),
                      width: 15.w,
                      height: 15.h,
                      color: blue,
                    ),
                  ),
                  Text(
                    _getPhoneNumber(),
                    style: TextStyle(
                        fontFamily: 'Poppins', color: black, fontSize: 13.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 82.h, right: 10.w),
                        child: Image(
                          image: AssetImage('assets/images/Frame (10).png'),
                          width: 15.w,
                          height: 15.h,
                          color: blue,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Route to ${_getName()}',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Starting Point: City Center',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Follow main road to destination.',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            HomeDivider(),
            NameView(
              name: "Property highlights",
              color: blue,
              secondName: 'View All',
              secondColor: blue,
            ),
            SizedBox(
              height: 15.h,
            ),
            PropertyFirstRow(),
            PropertySecondRow(),
            ProperyThirdRow(),
            SizedBox(
              height: 15.h,
            ),
            BookNow(hotel: hotel),
            Padding(
              padding: EdgeInsets.only(top: 18.h, left: 10.w, bottom: 10.h),
              child: Text(
                'Rating & Reviews',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: blue,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 42.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(3.sp),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${_getStarRating()}",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: white,
                              fontSize: 11.sp),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Icon(
                          Icons.star,
                          color: yellow,
                          size: 14.sp,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 128.w),
                    child: Text(
                      "${_getReviewCount()} Reviews",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: const Color.fromARGB(255, 190, 190, 190),
                          fontSize: 11.sp),
                    ),
                  ),
                  Container(
                    width: 80.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: gwhite,
                      borderRadius: BorderRadius.circular(21.sp),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/Vector (7).png'),
                          width: 11.w,
                          height: 11.h,
                          color: blue,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'Excellent',
                          style: TextStyle(
                              color: black,
                              fontFamily: 'Poppins',
                              fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            RatingFirstRow(),
            RatingSecondRow(),
            RatingThirdRow(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 120.h,
              // color: yellow,
              child: SecondDetailedViewBuilder(),
            ),
            HomeDivider(),
            NameView(
                name: 'Amenities',
                color: blue,
                secondName: 'View All',
                secondColor: blue),
            AmenitieRow(),
            HomeDivider(),
            Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
              child: Text(
                'Transportations',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: blue,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TransportationsFirstRow(),
            TransportationsSecondRow(),
            HomeDivider(),
            Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
              child: Text(
                'About ${_getName()}',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: blue,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 10.h, left: 10.w, right: 10.w, bottom: 12.h),
              width: 340.w,
              height: 90.h,
              decoration: BoxDecoration(
                // color: blue,
                borderRadius: BorderRadius.circular(5.sp),
                image: DecorationImage(
                    image: NetworkImage(_getCoverImage()), fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  //  Text(
                  //
                  // // "Set in Munnar "
                  //
                  //    style: TextStyle(
                  //        fontFamily: 'Poppins', color: black, fontSize: 13.sp),
                  //  ),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
            HomeDivider(),
            NameView(
                name: 'Our Accommodation Policies',
                color: blue,
                secondName: 'View All',
                secondColor: blue),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Check in & Check out:',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Check In Is Available From [12:00pm] And We\nRequest check out by [11:00am] to Allow\nSmooth transition for incoming guests.',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    '2.Cancellations & Refunds:',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Cancellations made [4 days] in advance are\nEligible for a full refund. For cancellations closer',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  String _getName() {
    try {
      if (hotel.runtimeType.toString() == 'BestHotel') {
        return hotel.name ?? 'Hotel Name';
      } else {
        return hotel.name ?? 'Hotel Name';
      }
    } catch (e) {
      return 'Hotel Name';
    }
  }

  String _getLocation() {
    try {
      if (hotel.runtimeType.toString() == 'BestHotel') {
        return hotel.location ?? 'Location';
      } else {
        try {
          return hotel.locationInfo?.city ??
              hotel.locationInfo?.address ??
              'Location';
        } catch (e) {
          return 'Location';
        }
      }
    } catch (e) {
      return 'Location';
    }
  }

  String _getCoverImage() {
    try {
      return hotel.coverImageUrl ?? 'assets/images/l1.png';
    } catch (e) {
      return 'assets/images/l1.png';
    }
  }

  String _getPhoneNumber() {
    try {
      // BestHotel has phoneNumber, Hotel might not have it directly exposed same way or requires deeper lookup
      if (hotel.runtimeType.toString() == 'BestHotel') {
        return hotel.phoneNumber ?? '+91 9876543210';
      }
      return '+91 9876543210';
    } catch (e) {
      return '+91 9876543210';
    }
  }

  String _getStarRating() {
    try {
      final rating = hotel.starRating;
      if (rating == null || rating == 0) return '4.5';
      return rating.toString();
    } catch (e) {
      return '4.5';
    }
  }

  String _getReviewCount() {
    try {
      if (hotel.runtimeType.toString() == 'BestHotel') {
        final count = hotel.reviewCount;
        if (count == null || count == 0) return '120';
        return count.toString();
      }
      return '120'; // Review count might not be in basic Hotel model search result easily
    } catch (e) {
      return '120';
    }
  }
}
