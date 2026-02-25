// ignore_for_file: file_names, avoid_print, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/detailed_view_screen/amenitie_row/amenitie_row.dart';
import 'package:homesloc/screens/detailed_view_screen/property_row/property_first_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_first_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_second_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_third_row.dart';
import 'package:homesloc/screens/detailed_view_screen/transportation_row/transportations_first_row.dart';
import 'package:homesloc/core/widgets/yellow_star/yellow_star.dart';
import 'package:homesloc/core/widgets/book_now/book_now.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/first_detailed_view_builder.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/second_detailed_view_builder.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/models/home/homescreen_model.dart';
import 'package:homesloc/models/home/hotel_detail_model.dart';
import 'package:homesloc/apis/home/hotel_detail_service.dart';

import 'package:homesloc/core/widgets/loader/app_loader.dart';
import 'package:homesloc/core/widgets/gallery/full_screen_image_viewer.dart';

import 'package:homesloc/models/search/search_hotel_model.dart';
import 'package:intl/intl.dart';

class DetailedViewScreen extends StatefulWidget {
  final dynamic hotel;
  final String? startDate;
  final String? endDate;

  const DetailedViewScreen({
    super.key,
    this.hotel,
    this.startDate,
    this.endDate,
  });

  @override
  State<DetailedViewScreen> createState() => _DetailedViewScreenState();
}

class _DetailedViewScreenState extends State<DetailedViewScreen> {
  final HotelDetailService _hotelDetailService = HotelDetailService();
  HotelDetailModel? _hotelDetails;
  bool _isLoading = true;
  int _carouselIndex = 0;
  final PageController _pageController = PageController();

  bool _isFullProperty = false; // Add this flag

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    try {
      final hotel = widget.hotel;

      // Check if it's a Room type from search results
      if (hotel is Hotel &&
          hotel.accommodationType == "ROOM" &&
          hotel.id != null) {
        // ... (room logic)
        final start =
            widget.startDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
        final end = widget.endDate ??
            DateFormat('yyyy-MM-dd')
                .format(DateTime.now().add(const Duration(days: 1)));

        final details = await _hotelDetailService.fetchRoomDetails(
          roomId: hotel.id!,
          startDate: start,
          endDate: end,
        );

        if (mounted) {
          setState(() {
            _hotelDetails = details;
            _isFullProperty = false; // Explicitly false
            _isLoading = false;
          });
        }
        return;
      }

      // Check if it's a Full Property type from search results
      if (hotel is Hotel &&
          hotel.accommodationType == "FULL_PROPERTY" &&
          hotel.id != null) {
        final start =
            widget.startDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
        final end = widget.endDate ??
            DateFormat('yyyy-MM-dd')
                .format(DateTime.now().add(const Duration(days: 1)));

        final details = await _hotelDetailService.fetchFullPropertyDetails(
          propertyId: hotel.id!,
          startDate: start,
          endDate: end,
        );

        if (mounted) {
          setState(() {
            _hotelDetails = details;
            _isFullProperty = true; // Set to true
            _isLoading = false;
          });
        }
        return;
      }

      final hotelId = hotel is String
          ? hotel
          : (hotel is Hotel
              ? hotel.id
              : (hotel is HotelDetailModel
                  ? hotel.id
                  : (hotel is BestHotel ? hotel.id : null)));

      if (hotelId != null) {
        final details = await _hotelDetailService.fetchHotelDetails(hotelId);
        if (mounted) {
          setState(() {
            _hotelDetails = details;
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching hotel details: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openFullScreenPreview(List<String> images, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImageViewer(
          images: images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  Widget _buildPolicyHighlight({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: border, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: blue, size: 22.sp),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: blue,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  content,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: black,
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: white,
        body: const Center(
          child: AppLoader(size: 50),
        ),
      );
    }

    final hotelData = _hotelDetails ?? widget.hotel;

    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 300.h,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _carouselIndex = index;
                      });
                    },
                    itemCount: _getGalleryImages(hotelData).length,
                    itemBuilder: (context, index) {
                      final imageUrl = _getGalleryImages(hotelData)[index];
                      return GestureDetector(
                        onTap: () => _openFullScreenPreview(
                            _getGalleryImages(hotelData), index),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageUrl.startsWith('http')
                                  ? NetworkImage(imageUrl)
                                  : AssetImage(imageUrl) as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Bottom Gradient Scrim
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 80.h,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                // Floating Back Button
                Positioned(
                  top: 40.h,
                  left: 15.w,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: blue,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ),
                // Floating Favorite Button
                Positioned(
                  top: 40.h,
                  right: 15.w,
                  child: GestureDetector(
                    onTap: () => print('Favorite tapped'),
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        hotelData?.isFavorite == true
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        color: blue,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
                // Expanding Dots Indicator
                if (_getGalleryImages(hotelData).length > 1)
                  Positioned(
                    bottom: 20.h,
                    left: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _getGalleryImages(hotelData).length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          width: _carouselIndex == index ? 20.w : 6.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: _carouselIndex == index
                                ? yellow
                                : white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                // Glassmorphic Image Count Overlay
                Positioned(
                  bottom: 15.h,
                  right: 15.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20.r),
                      border:
                          Border.all(color: white.withOpacity(0.2), width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.image_outlined, color: white, size: 12.sp),
                        SizedBox(width: 5.w),
                        Text(
                          '${_carouselIndex + 1}/${_getGalleryImages(hotelData).length}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 5.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getName(hotelData),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: blue,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            ...List.generate(
                              int.parse(_getStarRating(hotelData)),
                              (index) => Icon(Icons.star_rounded,
                                  color: yellow, size: 18.sp),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '(${_getReviewCount(hotelData)} Reviews)',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: fontColor,
                                fontSize: 12.sp,
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 98.h,
              child: FirstDetailedViewBuilder(
                hotel: hotelData,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Property details',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: blue,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: gwhite,
                      borderRadius: BorderRadius.circular(4.sp),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14.sp,
                          color: blue,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Map View', // More standard label
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: blue,
                              fontSize: 11.sp,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2.h, right: 10.w),
                    child: Icon(Icons.location_on, color: blue, size: 18.sp),
                  ),
                  Expanded(
                    child: Text(
                      _getLocation(hotelData),
                      style: TextStyle(
                          fontFamily: 'Poppins', color: black, fontSize: 13.sp),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Icon(Icons.phone, color: blue, size: 18.sp),
                  ),
                  Text(
                    _getPhoneNumber(hotelData),
                    style: TextStyle(
                        fontFamily: 'Poppins', color: black, fontSize: 13.sp),
                  ),
                ],
              ),
            ),
            const HomeDivider(),
            NameView(
              name: "Highlights",
              color: blue,
              secondName: 'View All',
              secondColor: blue,
            ),
            SizedBox(height: 10.h),
            AmenitieRow(
                hotel:
                    hotelData), // Reusing AmenitieRow as it now handles lists well
            SizedBox(height: 15.h),
            BookNow(
              hotel: hotelData,
              isFullProperty: _isFullProperty,
            ),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(3.sp),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${_getStarRating(hotelData)}",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: white,
                              fontSize: 11.sp),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.star,
                          color: yellow,
                          size: 14.sp,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Text(
                      "${_getReviewCount(hotelData)} Reviews",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: fontColor,
                          fontSize: 11.sp),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: gwhite,
                      borderRadius: BorderRadius.circular(21.sp),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.face, size: 14.sp, color: blue),
                        SizedBox(width: 5.w),
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
            SizedBox(height: 15.h),
            // We can keep these or simplify them if review data is missing
            if (_getReviewCount(hotelData) != "0") ...[
              RatingFirstRow(),
              RatingSecondRow(),
              RatingThirdRow(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 120.h,
                child: SecondDetailedViewBuilder(),
              ),
            ] else
              Padding(
                padding: EdgeInsets.all(20.r),
                child: Center(
                    child: Text("No reviews yet",
                        style: TextStyle(
                            fontFamily: 'Poppins', color: fontColor))),
              ),
            const HomeDivider(),
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
            TransportationsFirstRow(hotel: hotelData),
            const HomeDivider(),
            Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
              child: Text(
                'About ${_getName(hotelData)}',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: blue,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              width: double.infinity,
              height: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                image: DecorationImage(
                    image: _getCoverImage(hotelData).startsWith('http')
                        ? NetworkImage(_getCoverImage(hotelData))
                        : AssetImage(_getCoverImage(hotelData))
                            as ImageProvider,
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                _getDescription(hotelData),
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: black,
                    height: 1.5,
                    fontSize: 13.sp),
              ),
            ),
            const HomeDivider(),
            NameView(
                name: 'Accommodation Policies',
                color: blue,
                secondName: 'View All',
                secondColor: blue),
            _buildPolicyHighlight(
              icon: Icons.access_time_rounded,
              title: 'Check in & Check out',
              content:
                  'Check In: ${_getCheckInTime(hotelData)}\nCheck Out: ${_getCheckOutTime(hotelData)}',
            ),
            _buildPolicyHighlight(
              icon: Icons.assignment_return_rounded,
              title: 'Cancellations & Refunds',
              content: _getCancellationPolicy(hotelData),
            ),
            if (_getPetPolicy(hotelData).isNotEmpty)
              _buildPolicyHighlight(
                icon: Icons.pets_rounded,
                title: 'Pet Policy',
                content: _getPetPolicy(hotelData),
              ),
            if (_getChildPolicy(hotelData).isNotEmpty)
              _buildPolicyHighlight(
                icon: Icons.child_care_rounded,
                title: 'Child Policy',
                content: _getChildPolicy(hotelData),
              ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  String _getName(dynamic hotel) {
    if (hotel is HotelDetailModel) return hotel.name ?? 'Hotel Name';
    try {
      return hotel.name ?? 'Hotel Name';
    } catch (e) {
      return 'Hotel Name';
    }
  }

  String _getLocation(dynamic hotel) {
    if (hotel is HotelDetailModel) return hotel.location ?? 'Location';
    try {
      if (hotel.runtimeType.toString() == 'BestHotel') {
        return hotel.location ?? 'Location';
      } else {
        return hotel.locationInfo?.city ??
            hotel.locationInfo?.address ??
            hotel.location ??
            'Location';
      }
    } catch (e) {
      return 'Location';
    }
  }

  String _getCoverImage(dynamic hotel) {
    if (hotel is HotelDetailModel)
      return hotel.coverImageUrl ?? 'assets/images/l1.png';
    try {
      return hotel.coverImageUrl ?? 'assets/images/l1.png';
    } catch (e) {
      return 'assets/images/l1.png';
    }
  }

  List<String> _getGalleryImages(dynamic hotel) {
    List<String> images = [];
    if (hotel is HotelDetailModel) {
      if (hotel.coverImageUrl != null) images.add(hotel.coverImageUrl!);
      if (hotel.galleryImages != null) images.addAll(hotel.galleryImages!);
    } else {
      try {
        if (hotel.coverImageUrl != null) images.add(hotel.coverImageUrl);
        if (hotel.galleryImages != null) {
          images.addAll(List<String>.from(hotel.galleryImages));
        }
      } catch (e) {
        images.add('assets/images/l1.png');
      }
    }
    return images.isEmpty ? ['assets/images/l1.png'] : images;
  }

  String _getPhoneNumber(dynamic hotel) {
    if (hotel is HotelDetailModel) return hotel.phoneNumber ?? '+91 9876543210';
    try {
      return hotel.phoneNumber ?? '+91 9876543210';
    } catch (e) {
      return '+91 9876543210';
    }
  }

  String _getStarRating(dynamic hotel) {
    if (hotel is HotelDetailModel) return (hotel.starRating ?? 5).toString();
    try {
      final rating = hotel.starRating;
      if (rating == null || rating == 0) return '5';
      return rating.toString();
    } catch (e) {
      return '5';
    }
  }

  String _getReviewCount(dynamic hotel) {
    if (hotel is HotelDetailModel) return (hotel.reviewCount ?? 0).toString();
    try {
      final count = hotel.reviewCount;
      if (count == null) return '0';
      return count.toString();
    } catch (e) {
      return '0';
    }
  }

  String _getDescription(dynamic hotel) {
    if (hotel is HotelDetailModel) return hotel.description ?? '';
    try {
      return hotel.description ?? '';
    } catch (e) {
      return '';
    }
  }

  String _getCheckInTime(dynamic hotel) {
    if (hotel is HotelDetailModel)
      return hotel.policies?.checkInTime ?? '2:00 PM';
    return '2:00 PM';
  }

  String _getCheckOutTime(dynamic hotel) {
    if (hotel is HotelDetailModel)
      return hotel.policies?.checkOutTime ?? '11:00 AM';
    return '11:00 AM';
  }

  String _getCancellationPolicy(dynamic hotel) {
    if (hotel is HotelDetailModel) {
      final policy = hotel.policies?.cancellationPolicy;
      if (policy != null) {
        if (policy.toLowerCase().contains('nonrefundable')) {
          return 'This booking is non-refundable.';
        }
        if (policy.startsWith('freeUpTo:')) {
          final days = policy.split(':')[1];
          return 'Free cancellation up to $days days before check-in.';
        }
        return policy;
      }
    }
    return 'Standard cancellation policies apply.';
  }

  String _getPetPolicy(dynamic hotel) {
    // Note: Pet policy not currently in model, returning empty for now
    return '';
  }

  String _getChildPolicy(dynamic hotel) {
    // Note: Child policy not currently in model, returning empty for now
    return '';
  }
}
