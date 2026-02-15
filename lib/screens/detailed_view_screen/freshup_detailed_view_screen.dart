// ignore_for_file: file_names, avoid_print, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/book_now/freshup_book_now.dart';
import 'package:homesloc/core/widgets/gallery/full_screen_image_viewer.dart';
import 'package:homesloc/models/search/search_hotel_model.dart';
import 'package:homesloc/apis/home/hotel_detail_service.dart';
import 'package:homesloc/models/freshup/freshup_availability_model.dart';
import 'package:intl/intl.dart';
import 'package:homesloc/screens/detailed_view_screen/amenitie_row/freshup_amenitie_row.dart';
import 'package:homesloc/screens/detailed_view_screen/slot_row/freshup_slot_row.dart';
import 'package:homesloc/screens/detailed_view_screen/transportation_row/transportations_first_row.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/first_detailed_view_builder.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';

class FreshupDetailedViewScreen extends StatefulWidget {
  final Hotel freshup;
  final String? startDate;
  final String? endDate;

  const FreshupDetailedViewScreen({
    super.key,
    required this.freshup,
    this.startDate,
    this.endDate,
  });

  @override
  State<FreshupDetailedViewScreen> createState() =>
      _FreshupDetailedViewScreenState();
}

class _FreshupDetailedViewScreenState extends State<FreshupDetailedViewScreen> {
  late final CalendarController calendarController;
  final PageController _pageController = PageController();
  final HotelDetailService _hotelDetailService = HotelDetailService();
  int _carouselIndex = 0;
  bool _isLoading = false;
  FreshupAvailabilityModel? _availabilityModel;
  List<String> _selectedSlotIds = [];

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<CalendarController>()) {
      calendarController = Get.find<CalendarController>();
    } else {
      calendarController = Get.put(CalendarController());
    }

    if (widget.startDate != null) {
      calendarController.checkInDate.value = DateTime.parse(widget.startDate!);
    }

    _fetchFreshupDetails();
  }

  Future<void> _fetchFreshupDetails() async {
    if (widget.freshup.freshupDetails?.freshupId == null ||
        widget.freshup.freshupDetails?.priceMethod == null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final dateFormat = DateFormat('yyyy-MM-dd');
      final date = dateFormat
          .format(calendarController.checkInDate.value ?? DateTime.now());

      final result = await _hotelDetailService.checkFreshupAvailability(
        freshupRoomId: widget.freshup.freshupDetails!.freshupId!,
        priceMethod: widget.freshup.freshupDetails!.priceMethod!,
        date: date,
      );

      if (mounted) {
        setState(() {
          _availabilityModel = result;
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching freshup details: $e");
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

  List<String> _getGalleryImages() {
    List<String> images = [];
    if (widget.freshup.coverImageUrl != null &&
        widget.freshup.coverImageUrl!.isNotEmpty) {
      images.add(widget.freshup.coverImageUrl!);
    }
    if (widget.freshup.galleryImages != null) {
      images.addAll(widget.freshup.galleryImages!);
    }
    return images.isEmpty ? ['assets/images/l1.png'] : images;
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
    final images = _getGalleryImages();
    final hotelData = widget.freshup;

    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
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
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final imageUrl = images[index];
                      return GestureDetector(
                        onTap: () => _openFullScreenPreview(images, index),
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
                        hotelData.isFavorite == true
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        color: blue,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
                if (images.length > 1)
                  Positioned(
                    bottom: 20.h,
                    left: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
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
                          '${_carouselIndex + 1}/${images.length}',
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
                          hotelData.name ?? 'Freshup Name',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: blue,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        if (hotelData.rating != null)
                          Row(
                            children: [
                              ...List.generate(
                                5, // Defaulting to 5 or mapping rating
                                (index) => Icon(Icons.star_rounded,
                                    color: index <
                                            (num.tryParse(hotelData.rating
                                                        .toString()) ??
                                                    5)
                                                .floor()
                                        ? yellow
                                        : grey,
                                    size: 18.sp),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '(${hotelData.reviewCount ?? 0} Reviews)',
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
                          'Map View',
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
                      hotelData.location ?? "Location",
                      style: TextStyle(
                          fontFamily: 'Poppins', color: black, fontSize: 13.sp),
                    ),
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
            _isLoading
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.r),
                      child: CircularProgressIndicator(color: blue),
                    ),
                  )
                : FreshupAmenitieRow(
                    freshup: hotelData,
                    amenities: (_availabilityModel
                                ?.accommodations?.isNotEmpty ??
                            false)
                        ? _availabilityModel!.accommodations!.first.amenities
                        : null,
                  ),
            SizedBox(height: 15.h),
            NameView(
              name: "Available Slots",
              color: blue,
              secondName: '',
              secondColor: blue,
            ),
            _isLoading
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.r),
                      child: CircularProgressIndicator(color: blue),
                    ),
                  )
                : FreshupSlotRow(
                    slots: (_availabilityModel?.accommodations?.isNotEmpty ??
                            false)
                        ? _availabilityModel!.accommodations!.first.slots
                        : null,
                    initialSelectedSlotIds: _selectedSlotIds,
                    onSlotsSelected: (ids) {
                      setState(() {
                        _selectedSlotIds = ids;
                      });
                    },
                  ),
            SizedBox(height: 15.h),
            FreshupBookNow(
              freshup: hotelData,
              selectedSlotIds: _selectedSlotIds,
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
                'About ${hotelData.name ?? "Freshup"}',
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
                    image: (hotelData.coverImageUrl ?? "").startsWith('http')
                        ? NetworkImage(hotelData.coverImageUrl!)
                        : AssetImage(hotelData.coverImageUrl ??
                            'assets/images/l1.png') as ImageProvider,
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                hotelData.freshupDetails?.freshupDescription ?? "",
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
            if (hotelData.freshupDetails?.smokingAllowed != null)
              _buildPolicyHighlight(
                icon: Icons.smoke_free_rounded,
                title: 'Smoking Policy',
                content: hotelData.freshupDetails!.smokingAllowed!
                    ? "Smoking Allowed"
                    : "Smoking Not Allowed",
              ),
            if (hotelData.freshupDetails?.bathroomAttached != null)
              _buildPolicyHighlight(
                icon: Icons.bathroom_outlined,
                title: 'Bathroom',
                content: hotelData.freshupDetails!.bathroomAttached!
                    ? "Bathroom Attached"
                    : "Shared Bathroom",
              ),
            _buildPolicyHighlight(
              icon: Icons.assignment_return_rounded,
              title: 'Cancellations & Refunds',
              content: 'Standard Freshup cancellation policies apply.',
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
