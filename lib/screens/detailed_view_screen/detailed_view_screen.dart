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
import 'package:homesloc/core/utils/bottom_sheet_utils.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/core/widgets/book_now/book_now.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/first_detailed_view_builder.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/second_detailed_view_builder.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/models/home/homescreen_model.dart';
import 'package:homesloc/models/home/hotel_detail_model.dart';
import 'package:homesloc/apis/home/hotel_detail_service.dart';
import 'package:homesloc/core/widgets/policy_card/policy_card.dart';

import 'package:homesloc/core/widgets/loader/app_loader.dart';
import 'package:homesloc/core/widgets/gallery/full_screen_image_viewer.dart';

import 'package:homesloc/models/search/search_hotel_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
  HotelRoom? _selectedRoom;
  bool _isRoomLoading = false; // Add loading state for room selection

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

  Widget _buildRoomCard(HotelRoom room, dynamic hotelData) {
    final bool isSelected = _selectedRoom?.id == room.id;
    bool isFull = false;
    if (hotelData is HotelDetailModel) {
      isFull = hotelData.isFullProperty == true;
    } else {
      try {
        isFull = hotelData.accommodationType == "FULL_PROPERTY";
      } catch (e) {}
    }

    return GestureDetector(
      onTap: () {
        if (isFull) {
          return;
        }
        setState(() {
          _isRoomLoading = true;
          _selectedRoom = isSelected ? null : room;
          _carouselIndex = 0;
          if (_pageController.hasClients) {
            _pageController.jumpToPage(0);
          }
        });

        // Small delay to show user that data is changing
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) {
            setState(() {
              _isRoomLoading = false;
            });
          }
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? blue : border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room Image Carousel/Single Image
            if (room.images != null && room.images!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(isSelected ? 14.r : 15.r)),
                child: SizedBox(
                  height: 160.h,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Image.network(
                        room.images!.first,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 160.h,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/images/l1.png',
                                fit: BoxFit.cover),
                      ),
                      if (isSelected &&
                          !((hotelData is HotelDetailModel &&
                                  hotelData.isFullProperty == true) ||
                              (hotelData.runtimeType.toString() == 'Hotel' &&
                                  hotelData.accommodationType ==
                                      'FULL_PROPERTY')))
                        Positioned(
                          top: 10.h,
                          right: 10.w,
                          child: Icon(Icons.check_circle,
                              color: blue, size: 24.sp),
                        ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          room.name ?? "Room",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: blue,
                          ),
                        ),
                      ),
                      if (!isFull)
                        Text(
                          "₹${room.offerPrice ?? room.price ?? '0'}",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: black,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      if (!isFull) ...[
                        Icon(Icons.person_outline,
                            size: 14.sp, color: fontColor),
                        SizedBox(width: 4.w),
                        Text(
                          "Max ${room.maxPerson ?? 0} Persons",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.sp,
                              color: fontColor),
                        ),
                        SizedBox(width: 12.w),
                      ],
                      Icon(Icons.king_bed_outlined,
                          size: 14.sp, color: fontColor),
                      SizedBox(width: 4.w),
                      Text(
                        room.bedType ?? "Bed Type",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            color: fontColor),
                      ),
                    ],
                  ),
                  if (room.mealOption != null) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.restaurant_menu, size: 14.sp, color: green),
                        SizedBox(width: 4.w),
                        Text(
                          room.mealOption!,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.sp,
                              color: green),
                        ),
                      ],
                    ),
                  ],
                  if (room.amenities != null && room.amenities!.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 4.h,
                      children: room.amenities!.take(3).map((amenity) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: gwhite,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            amenity,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10.sp,
                                color: blue),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

  Future<void> _launchMap(dynamic hotel) async {
    try {
      final lat = hotel.latitude;
      final lng = hotel.longitude;
      if (lat != null &&
          lng != null &&
          lat.toString().isNotEmpty &&
          lng.toString().isNotEmpty) {
        final uri = Uri.parse(
            "https://www.google.com/maps/search/?api=1&query=$lat,$lng");
        if (!await launchUrl(uri)) {
          debugPrint('Could not launch map');
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location coordinates not available')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location coordinates not available')),
        );
      }
    }
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
      body: Stack(
        children: [
          SingleChildScrollView(
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
                /* Positioned(
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
                ), */
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
                          _getHotelName(hotelData),
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: blue,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        if (_getRoomName(hotelData).isNotEmpty)
                          Text(
                            _getRoomName(hotelData),
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: blue.withOpacity(0.7),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
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
                  GestureDetector(
                    onTap: () => _launchMap(hotelData),
                    child: Container(
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
            AmenitieRow(hotel: hotelData),
            SizedBox(height: 15.h),
            // Billing Details Section
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            //   child: Text(
            //     'Billing Details',
            //     style: TextStyle(
            //         fontFamily: 'Poppins',
            //         color: blue,
            //         fontSize: 17.sp,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: border, width: 1),
              ),
              child: Column(
                children: [
                  _buildBillingItem(
                    context: context,
                    icon: Icons.calendar_month_rounded,
                    title: "Stay Dates",
                    onTap: () =>
                        BottomSheetUtils.showCalendarBottomSheet(context),
                    subtitle: Obx(() {
                      final calendarController = Get.find<CalendarController>();
                      return Text(
                        calendarController.checkInDate.value != null &&
                                calendarController.checkOutDate.value != null
                            ? "${calendarController.formatDate(calendarController.checkInDate.value)} - ${calendarController.formatDate(calendarController.checkOutDate.value)}"
                            : "Select Dates",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp),
                      );
                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Divider(color: border.withOpacity(0.5), height: 1),
                  ),
                  _buildBillingItem(
                    context: context,
                    icon: Icons.people_alt_rounded,
                    title: "Guests & Rooms",
                    onTap: () => BottomSheetUtils.showGuestBottomSheet(context),
                    subtitle: Obx(() {
                      final calendarController = Get.find<CalendarController>();
                      return Text(
                        "${calendarController.guestCount.value} Guests | ${calendarController.roomCount.value} Rooms",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp),
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            BookNow(
              hotel: hotelData,
              isFullProperty: _isFullProperty,
              selectedRoom: _selectedRoom,
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

            if (hotelData is HotelDetailModel &&
                hotelData.rooms != null &&
                hotelData.rooms!.isNotEmpty) ...[
              NameView(
                name: (hotelData.isFullProperty == true)
                    ? "Rooms in Full Property"
                    : "Rooms Available",
                color: blue,
                secondName: '',
                secondColor: blue,
              ),
              SizedBox(height: 10.h),
              ...hotelData.rooms!
                  .map((room) => _buildRoomCard(room, hotelData)),
              const HomeDivider(),
            ],

            if (hotelData is HotelDetailModel)
              _buildNearbyAttractions(hotelData),

            Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
              child: Text(
                'About ${_getHotelName(hotelData)}',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getDescription(hotelData),
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        height: 1.5,
                        fontSize: 13.sp),
                  ),
                  if (hotelData is HotelDetailModel &&
                      (hotelData.yearBuild != null ||
                          hotelData.yearRenovated != null)) ...[
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        if (hotelData.yearBuild != null) ...[
                          Icon(Icons.build_circle_outlined,
                              size: 16.sp, color: blue),
                          SizedBox(width: 4.w),
                          Text(
                            "Built in ${hotelData.yearBuild}",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: fontColor),
                          ),
                          if (hotelData.yearRenovated != null) ...[
                            SizedBox(width: 16.w),
                            Icon(Icons.auto_awesome_outlined,
                                size: 16.sp, color: blue),
                            SizedBox(width: 4.w),
                            Text(
                              "Renovated in ${hotelData.yearRenovated}",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: fontColor),
                            ),
                          ],
                        ] else if (hotelData.yearRenovated != null) ...[
                          Icon(Icons.auto_awesome_outlined,
                              size: 16.sp, color: blue),
                          SizedBox(width: 4.w),
                          Text(
                            "Renovated in ${hotelData.yearRenovated}",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: fontColor),
                          ),
                        ],
                      ],
                    ),
                  ],
                  // if (hotelData is HotelDetailModel &&
                  //     hotelData.phoneNumber != null) ...[
                  //   SizedBox(height: 8.h),
                  //   Row(
                  //     children: [
                  //       Icon(Icons.phone_outlined, size: 16.sp, color: blue),
                  //       SizedBox(width: 4.w),
                  //       Text(
                  //         hotelData.phoneNumber!,
                  //         style: TextStyle(
                  //             fontFamily: 'Poppins',
                  //             fontSize: 12.sp,
                  //             fontWeight: FontWeight.w500,
                  //             color: fontColor),
                  //       ),
                  //     ],
                  //   ),
                  // ],
                  // if (hotelData is HotelDetailModel &&
                  //     hotelData.location != null) ...[
                  //   SizedBox(height: 8.h),
                  //   Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Icon(Icons.location_on_outlined,
                  //           size: 16.sp, color: blue),
                  //       SizedBox(width: 4.w),
                  //       Expanded(
                  //         child: Text(
                  //           hotelData.location!,
                  //           style: TextStyle(
                  //               fontFamily: 'Poppins',
                  //               fontSize: 12.sp,
                  //               fontWeight: FontWeight.w500,
                  //               color: fontColor),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ],
                ],
              ),
            ),
            const HomeDivider(),
            _buildPolicyGrid(hotelData),
            SizedBox(height: 40.h),
          ],
        ),
      ),
      if (_isRoomLoading)
        Positioned.fill(
          child: Container(
            color: Colors.white.withOpacity(0.5),
            child: const Center(
              child: AppLoader(size: 50),
            ),
          ),
        ),
    ],
  ),
);
}

  String _getHotelName(dynamic hotel) {
    if (hotel is HotelDetailModel) return hotel.name ?? 'Hotel Name';
    try {
      return hotel.name ?? 'Hotel Name';
    } catch (e) {
      return 'Hotel Name';
    }
  }

  String _getRoomName(dynamic hotel) {
    if (hotel is HotelDetailModel) {
      return _selectedRoom?.name ?? hotel.roomName ?? "";
    }
    return "";
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

    if (_selectedRoom != null &&
        _selectedRoom!.images != null &&
        _selectedRoom!.images!.isNotEmpty) {
      return _selectedRoom!.images!;
    }

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

  List<String> _getAccommodationPolicies(dynamic hotel) {
    if (hotel is HotelDetailModel) {
      if (hotel.policies?.accommodationPolicies != null &&
          hotel.policies!.accommodationPolicies!.isNotEmpty) {
        return hotel.policies!.accommodationPolicies!;
      }
    }
    // Trying fallback for SearchHotelModel or other payloads
    try {
      if (hotel.propertyrules != null) {
        return hotel.propertyrules
            .toString()
            .split('\n')
            .where((s) => s.trim().isNotEmpty)
            .toList();
      }
    } catch (e) {
      // ignore
    }
    return [];
  }

  Widget _buildPolicyGrid(dynamic hotel) {
    bool isHotelDetail = hotel is HotelDetailModel;
    HotelDetailModel? detailedHotel = isHotelDetail ? hotel : null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Accommodation Policies',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: blue,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PolicyCard(
                  title: 'Check-in/out',
                  icon: Icons.access_time_rounded,
                  headerColor: Colors.indigo.shade50,
                  iconColor: Colors.indigo.shade700,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Check-in',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10.sp,
                                  color: grey)),
                          Text(_getCheckInTime(hotel),
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: black)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Check-out',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10.sp,
                                  color: grey)),
                          Text(_getCheckOutTime(hotel),
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: black)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: PolicyCard(
                  title: 'Cancellation Policy',
                  icon: Icons.calendar_today_outlined,
                  headerColor: Colors.blue.shade50,
                  iconColor: Colors.blue.shade700,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getCancellationPolicy(hotel),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.sp,
                          color: black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PolicyCard(
                  title: 'Acceptable ID Proof',
                  icon: Icons.security_rounded,
                  headerColor: Colors.green.shade50,
                  iconColor: Colors.green.shade700,
                  content: Wrap(
                    spacing: 6.w,
                    runSpacing: 6.h,
                    children: (detailedHotel
                                ?.policies?.acceptableIdentityProof ??
                            ['Passport', 'Aadhar', 'Driving License'])
                        .map((id) => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 3.h),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_circle_outline,
                                      color: Colors.green.shade700,
                                      size: 10.sp),
                                  SizedBox(width: 4.w),
                                  Text(
                                    id,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w500,
                                      color: black,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: PolicyCard(
                  title: 'Extra Bed Policy',
                  icon: Icons.bed_outlined,
                  headerColor: Colors.red.shade50,
                  iconColor: Colors.red.shade700,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3E5F5), // Light purple
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.king_bed_outlined,
                                color: const Color(0xFF7B1FA2), size: 16.sp), // Purple icon
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (detailedHotel?.policies?.extraBedPolicy == 'true' || 
                                   detailedHotel?.policies?.extraBedPolicy == 'Available' ||
                                   detailedHotel?.policies?.extraBedPolicy == 'Yes')
                                      ? 'Extra beds available on request'
                                      : detailedHotel?.policies?.extraBedPolicy ?? 'No',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                    color: black,
                                  ),
                                ),
                                if (detailedHotel?.policies?.extraBedPrice != null && 
                                    detailedHotel?.policies?.extraBedPrice != "null" &&
                                    detailedHotel?.policies?.extraBedPrice != "0") ...[
                                  SizedBox(height: 6.h),
                                  Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF3E5F5),
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      child: Text(
                                        '₹${detailedHotel?.policies?.extraBedPrice} /night',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 11.sp,
                                            
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF7B1FA2)),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_getAccommodationPolicies(hotel).isNotEmpty ||
              (hotel is HotelDetailModel && hotel.smokingAllowed != null)) ...[
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hotel is HotelDetailModel &&
                    hotel.smokingAllowed != null) ...[
                  Expanded(
                    child: PolicyCard(
                      title: 'Smoking Policy',
                      icon: Icons.smoke_free_rounded,
                      headerColor: Colors.orange.shade50,
                      iconColor: Colors.orange.shade700,
                      content: Row(
                        children: [
                          Icon(
                            hotel.smokingAllowed == true
                                ? Icons.smoking_rooms_rounded
                                : Icons.smoke_free_rounded,
                            color: hotel.smokingAllowed == true
                                ? Colors.green
                                : Colors.red,
                            size: 16.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            hotel.smokingAllowed == true
                                ? 'Smoking Allowed'
                                : 'Smoking Prohibited',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_getAccommodationPolicies(hotel).isEmpty)
                    const Expanded(child: SizedBox()),
                ],
                if (_getAccommodationPolicies(hotel).isNotEmpty) ...[
                  if (hotel is HotelDetailModel && hotel.smokingAllowed != null)
                    SizedBox(width: 10.w),
                  Expanded(
                    child: PolicyCard(
                      title: 'Property Rules',
                      icon: Icons.do_not_disturb_on_outlined,
                      headerColor: Colors.purple.shade50,
                      iconColor: Colors.purple.shade700,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _getAccommodationPolicies(hotel)
                            .map((rule) => Padding(
                                  padding: EdgeInsets.only(bottom: 4.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 4.h),
                                        child: Container(
                                          width: 4.w,
                                          height: 4.h,
                                          decoration: const BoxDecoration(
                                              color: grey,
                                              shape: BoxShape.circle),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Text(
                                          rule,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 10.sp,
                                            color: grey.withOpacity(0.8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  if (!(hotel is HotelDetailModel &&
                      hotel.smokingAllowed != null))
                    const Expanded(child: SizedBox()),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNearbyAttractions(HotelDetailModel hotel) {
    if (hotel.nearByAttractions == null || hotel.nearByAttractions!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w, bottom: 10.h, top: 10.h),
          child: Text(
            'Nearby Attractions',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: blue,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 90.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            itemCount: hotel.nearByAttractions!.length,
            itemBuilder: (context, index) {
              final attraction = hotel.nearByAttractions![index];
              return Container(
                width: 180.w,
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: border.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      attraction.name ?? "Attraction",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: blue,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.directions_walk, size: 14.sp, color: grey),
                        SizedBox(width: 4.w),
                        Text(
                          "${attraction.distance ?? '0'} km away",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11.sp,
                            color: const Color.fromARGB(255, 141, 139, 139),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const HomeDivider(),
      ],
    );
  }

  Widget _buildBillingItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Widget subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: blue, size: 20.sp),
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
                      color: fontColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 2.h),
                subtitle,
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded,
              color: grey.withOpacity(0.5), size: 14.sp),
        ],
      ),
    );
  }
}
