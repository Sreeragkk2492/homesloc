// ignore_for_file: file_names, avoid_print, unused_import
import 'package:flutter/material.dart';
import 'package:homesloc/core/widgets/loader/app_loader.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:homesloc/controller/freshup/freshup_detail_controller.dart';
import 'package:homesloc/screens/detailed_view_screen/amenitie_row/freshup_amenitie_row.dart';
import 'package:homesloc/screens/detailed_view_screen/slot_row/freshup_slot_row.dart';
import 'package:homesloc/models/freshup/freshup_detail_model.dart';
import 'package:homesloc/screens/detailed_view_screen/transportation_row/transportations_first_row.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/first_detailed_view_builder.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/core/utils/bottom_sheet_utils.dart';
import 'package:homesloc/core/widgets/policy_card/policy_card.dart';

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
  late final FreshupDetailController controller;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      FreshupDetailController(
        freshup: widget.freshup,
        initialStartDate: widget.startDate,
      ),
      tag: widget.freshup.id, // Use unique tag if multiple screens can coexist
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    // Get.delete<FreshupDetailController>(tag: widget.freshup.id);
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
    if (widget.freshup.freshupDetails?.roomImages != null &&
        widget.freshup.freshupDetails!.roomImages!.isNotEmpty) {
      images.addAll(widget.freshup.freshupDetails!.roomImages!);
    } else if (widget.freshup.galleryImages != null &&
        widget.freshup.galleryImages!.isNotEmpty) {
      images.addAll(widget.freshup.galleryImages!);
    } else if (widget.freshup.coverImageUrl != null &&
        widget.freshup.coverImageUrl!.isNotEmpty) {
      images.add(widget.freshup.coverImageUrl!);
    }
    return images.isEmpty ? ['assets/images/l1.png'] : images;
  }

  List<String> _getHotelGalleryImages() {
    List<String> images = [];
    if (widget.freshup.galleryImages != null &&
        widget.freshup.galleryImages!.isNotEmpty) {
      images.addAll(widget.freshup.galleryImages!);
    } else if (widget.freshup.coverImageUrl != null &&
        widget.freshup.coverImageUrl!.isNotEmpty) {
      images.add(widget.freshup.coverImageUrl!);
    }
    return images;
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
                      controller.updateCarouselIndex(index);
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
                        hotelData.isFavorite == true
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        color: blue,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ), */
                if (images.length > 1)
                  Positioned(
                    bottom: 20.h,
                    left: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (index) => Obx(
                          () => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                            width: controller.carouselIndex.value == index
                                ? 20.w
                                : 6.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: controller.carouselIndex.value == index
                                  ? yellow
                                  : white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(3.r),
                            ),
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
                        Obx(
                          () => Text(
                            '${controller.carouselIndex.value + 1}/${images.length}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotelData.freshupDetails?.freshupName ??
                        hotelData.name ??
                        'Room Name',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: blue,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  if (hotelData.freshupDetails?.freshupType != null)
                    Text(
                        "Freshup Type: ${hotelData.freshupDetails!.freshupType}",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            color: Colors.grey.shade700)),
                  if (hotelData.freshupDetails?.bedType != null)
                    Text("Bed Type: ${hotelData.freshupDetails!.bedType}",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            color: Colors.grey.shade700)),
                  if (hotelData.freshupDetails?.availableRooms != null)
                    Text(
                        "Available rooms: ${hotelData.freshupDetails!.availableRooms}",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            color: Colors.grey.shade700)),
                  if (hotelData.freshupDetails?.maxPerson != null)
                    Text("Max Person: ${hotelData.freshupDetails!.maxPerson}",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            color: Colors.grey.shade700)),
                  if (hotelData.freshupDetails?.roomSize != null)
                    Text("Room size: ${hotelData.freshupDetails!.roomSize}",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            color: Colors.grey.shade700)),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      if (hotelData.originalPrice != null &&
                          hotelData.originalPrice != hotelData.offerPrice)
                        Text(
                          "₹${hotelData.originalPrice}",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 14.sp),
                        ),
                      if (hotelData.originalPrice != null) SizedBox(width: 8.w),
                      Text(
                        "₹${hotelData.offerPrice ?? hotelData.originalPrice ?? '0'}",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            NameView(
              name: "Available Slots",
              color: blue,
              secondName: '',
              secondColor: blue,
            ),
            Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: AppLoader(size: 50),
                      ),
                    )
                  : FreshupSlotRow(
                      slots: (controller.availabilityModel.value?.accommodations
                                  ?.isNotEmpty ??
                              false)
                          ? controller.availabilityModel.value!.accommodations!
                              .first.slots
                          : null,
                      initialSelectedSlotIds: controller.selectedSlotIds,
                      onSlotsSelected: (ids) {
                        controller.selectedSlotIds.assignAll(ids);
                      },
                    ),
            ),
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
                    title: "Stay Date",
                    onTap: () {
                      BottomSheetUtils.showCalendarBottomSheet(context);
                      // Freshup usually cares about one date, but the calendar handles range.
                      // We can listen to changes and refresh details if needed.
                      // The controller already uses calendarController.checkInDate.
                      fetchOnDateChange();
                    },
                    subtitle: Obx(() {
                      return Text(
                        controller.calendarController.checkInDate.value != null
                            ? controller.calendarController.formatDate(
                                controller.calendarController.checkInDate.value)
                            : "Select Date",
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
                    title: "Guests",
                    onTap: () => BottomSheetUtils.showGuestBottomSheet(context),
                    subtitle: Obx(() {
                      return Text(
                        "${controller.calendarController.guestCount.value} Guests",
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
            Obx(
              () => FreshupBookNow(
                freshup: hotelData,
                selectedSlotIds: controller.selectedSlotIds.toList(),
              ),
            ),
            const HomeDivider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Row(
                children: [
                  Icon(Icons.business_outlined, color: blue, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Hotel Info',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: blue,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 5.h, 15.w, 5.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotelData.name ?? 'Hotel Name',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: blue,
                            fontSize: 18.sp,
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
                                    size: 16.sp),
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
            Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: AppLoader(size: 50),
                      ),
                    )
                  : FreshupAmenitieRow(
                      freshup: hotelData,
                      amenities: (controller.availabilityModel.value
                                  ?.accommodations?.isNotEmpty ??
                              false)
                          ? controller.availabilityModel.value!.accommodations!
                              .first.amenities
                          : null,
                    ),
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
            Obx(() {
              final detailData =
                  controller.availabilityModel.value?.rawDetails ??
                      hotelData.freshupDetails;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                    width: double.infinity,
                    height: 150.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(
                          image:
                              (hotelData.coverImageUrl ?? "").startsWith('http')
                                  ? NetworkImage(hotelData.coverImageUrl!)
                                  : AssetImage(hotelData.coverImageUrl ??
                                      'assets/images/l1.png') as ImageProvider,
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      detailData?.freshupDescription ?? "",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          height: 1.5,
                          fontSize: 13.sp),
                    ),
                  ),
                  if (detailData?.nearbyAttractions != null &&
                      detailData!.nearbyAttractions!.isNotEmpty) ...[
                    const HomeDivider(),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
                      child: Text(
                        "What's Nearby",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: blue,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...detailData.nearbyAttractions!
                        .map((attraction) => Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 4.h),
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                color: gwhite,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.place_outlined,
                                      color: blue, size: 18.sp),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      attraction,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: black,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                  ],
                  const HomeDivider(),
                  NameView(
                      name: 'Accommodation Policies',
                      color: blue,
                      secondName: '',
                      secondColor: blue),
                  SizedBox(height: 10.h),
                  _buildPolicyGrid(detailData),
                  SizedBox(height: 40.h),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyGrid(FreshupDetailModel? data) {
    if (data == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PolicyCard(
                  title: 'Accepted Time Slot',
                  icon: Icons.access_time_rounded,
                  headerColor: Colors.indigo.shade50,
                  iconColor: Colors.indigo.shade700,
                  content: Text(
                    data.acceptedTimeSlots ?? 'N/A',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                      color: black,
                    ),
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
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.calendar_month_outlined,
                                color: Colors.blue.shade700, size: 14.sp),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              data.cancellationPolicy
                                              ?.toLowerCase()
                                              .contains('nonrefundable') ==
                                          true ||
                                      data.cancellationPolicy
                                              ?.toLowerCase()
                                              .contains('non-refundable') ==
                                          true
                                  ? 'Non-refundable'
                                  : 'Cancellation Policy',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                                color: black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        data.cancellationPolicy ??
                            (data.cancellationDays != null
                                ? 'Free cancellation up to ${data.cancellationDays} days before check-in.'
                                : 'Standard cancellation policies apply.'),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.sp,
                          color: grey.withOpacity(0.8),
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
                    children: (data.acceptableIdentityProof ??
                            [
                              'Passport',
                              'Aadhar',
                              'Voter ID',
                              'Driving License'
                            ])
                        .map((id) => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_circle_outline,
                                      color: Colors.green.shade700,
                                      size: 12.sp),
                                  SizedBox(width: 4.w),
                                  Text(
                                    id,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 10.sp,
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
                        children: [
                          Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Icon(Icons.king_bed_outlined,
                                color: Colors.red.shade700, size: 14.sp),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            maxLines: 2,
                            data.extraBedPolicy ?? 'No',
                            style: TextStyle(
                            //  maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: gwhite,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              '₹${data.extraBedPrice ?? '0'}',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                                color: black,
                              ),
                            ),
                            // Text(
                            //   maxLines: 2,
                            //   overflow: TextOverflow.ellipsis,
                            //   '₹${data.extraBedPrice ?? '0'}',
                            //   style: TextStyle(
                            //     fontFamily: 'Poppins',
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 13.sp,
                            //     color: black,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.warning_amber_rounded,
                                    color: Colors.orange.shade700, size: 10.sp),
                                SizedBox(width: 4.w),
                                Text(
                                  'Warning:',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red.shade700,
                                    fontSize: 9.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Extra bed charges and custom policies are set by the hotel owner.',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 8.sp,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          PolicyCard(
            title: 'Property Rules',
            icon: Icons.do_not_disturb_on_outlined,
            headerColor: Colors.purple.shade50,
            iconColor: Colors.purple.shade700,
            content: Text(
              data.propertyRules?.join(' ') ??
                  'Guest must carry ID proof. No refund on cancellation. Extra payment will charge on extra hour.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11.sp,
                color: grey.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void fetchOnDateChange() {
    // We need to trigger fetchFreshupDetails when date changes in the bottom sheet
    // Since showCalendarBottomSheet doesn't have a callback, we might need a listener in the controller
    // or just trigger it manually if the user confirms.
    // For now, let's assume the controller should react to changes.
    controller.fetchFreshupDetails();
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
