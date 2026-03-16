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
import 'package:homesloc/models/home/hotel_detail_model.dart';
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

  List<String> _getGalleryImages({HotelRoom? selectedRoom}) {
    // Priority: selected room images > freshup room images > gallery images > cover
    if (selectedRoom != null &&
        selectedRoom.images != null &&
        selectedRoom.images!.isNotEmpty) {
      return selectedRoom.images!;
    }
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
    final hotelData = widget.freshup;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: white,
        body: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    final selectedRoom = controller.selectedFreshupRoom.value;
                    final images = _getGalleryImages(selectedRoom: selectedRoom);
                    return Stack(
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
                                onTap: () =>
                                    _openFullScreenPreview(images, index),
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
                );
              }),
              Obx(() {
                final selectedRoom = controller.selectedFreshupRoom.value;
                final isRoomSelected = selectedRoom != null;
      
                // Extract values based on whether a room is selected or not
                final displaySubTitle = isRoomSelected
                    ? selectedRoom.name
                    : (hotelData.freshupDetails?.freshupName ??
                        hotelData.freshupDetails?.freshupType);
                final displayBedType = isRoomSelected
                    ? selectedRoom.bedType
                    : hotelData.freshupDetails?.bedType;
                final displayRoomSize = isRoomSelected
                    ? (selectedRoom.roomSize != null
                        ? "${selectedRoom.roomSize} sqft"
                        : null)
                    : hotelData.freshupDetails?.roomSize;
      
                return Padding(
                  padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hotel Name
                      Text(
                        hotelData.name ?? 'Hotel Name',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: blue,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Room Name - Highlighted if selected
                      if (displaySubTitle != null)
                        Text(
                          displaySubTitle,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: blue.withOpacity(0.7),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      SizedBox(height: 5.h),
                      // Rating Row relocated to top
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => Icon(Icons.star_rounded,
                                color: index <
                                        (() {
                                          final r = num.tryParse(
                                              (controller.availabilityModel.value
                                                          ?.rawDetails?.starRating ??
                                                      hotelData.rating ??
                                                      0)
                                                  .toString());
                                          return r ?? 0;
                                        }())
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
                      SizedBox(height: 10.h),
                      if (displayBedType != null)
                        Text("Bed Type: $displayBedType",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13.sp,
                                color: Colors.grey.shade700)),
                      if (displayRoomSize != null)
                        Text("Room size: $displayRoomSize",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13.sp,
                                color: Colors.grey.shade700)),
                      SizedBox(height: 10.h),
                      // Row(
                      //   children: [
                      //     // if (displayOriginalPrice != null &&
                      //     //     displayOriginalPrice != displayOfferPrice)
                      //     //   Text(
                      //     //     "₹$displayOriginalPrice",
                      //     //     style: TextStyle(
                      //     //         fontFamily: 'Poppins',
                      //     //         decoration: TextDecoration.lineThrough,
                      //     //         color: Colors.grey,
                      //     //         fontSize: 14.sp),
                      //     //   ),
                      //     if (displayOriginalPrice != null) SizedBox(width: 8.w),
                      //     Text(
                      //       "₹${displayOfferPrice ?? displayOriginalPrice ?? '0'}",
                      //       style: TextStyle(
                      //           fontFamily: 'Poppins',
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.black,
                      //           fontSize: 18.sp),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                );
              }),
      
              // Property details (relocated to top)
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
              SizedBox(height: 5.h),
              NameView(
                name: "Available Slots",
                color: blue,
                secondName: '',
                secondColor: blue,
              ),
              Obx(
                () => controller.isSlotsLoading.value
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: AppLoader(
                              size: 30, color: blue.withOpacity(0.5)),
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
                        BottomSheetUtils.showSingleDatePicker(context);
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
              Obx(() {
                final selectedRoom = controller.selectedFreshupRoom.value;
                return FreshupBookNow(
                  freshup: hotelData,
                  selectedSlotIds: controller.selectedSlotIds.toList(),
                  selectedRoomPrice:
                      selectedRoom?.offerPrice?.toString() ?? selectedRoom?.price,
                  selectedRoomOriginalPrice: selectedRoom?.price,
                );
              }),
              const HomeDivider(),
              NameView(
                name: "Highlights",
                color: blue,
                secondName: 'View All',
                secondColor: blue,
              ),
              SizedBox(height: 10.h),
              Obx(
                () => controller.isSlotsLoading.value
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: AppLoader(
                              size: 30, color: blue.withOpacity(0.5)),
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
              // Available Rooms Section
              Obx(() {
                final detailData =
                    controller.availabilityModel.value?.rawDetails ??
                        hotelData.freshupDetails;
                final rooms = detailData?.rooms;
                if (rooms == null || rooms.isEmpty)
                  return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NameView(
                      name: "Available Rooms",
                      color: blue,
                      secondName: '',
                      secondColor: blue,
                    ),
                    SizedBox(height: 10.h),
                    ...rooms.map((room) => _buildRoomCard(room)),
                    const HomeDivider(),
                  ],
                );
              }),
      
              // Nearby Attractions horizontal section
              Obx(() {
                final detailData =
                    controller.availabilityModel.value?.rawDetails ??
                        hotelData.freshupDetails;
                final attractions = detailData?.nearbyAttractionObjects;
                if (attractions == null || attractions.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 10.w, bottom: 10.h, top: 10.h),
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
                        itemCount: attractions.length,
                        itemBuilder: (context, index) {
                          final attraction = attractions[index];
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
                                if ((attraction.distance ?? '').isNotEmpty)
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Row(
                                      children: [
                                        Icon(Icons.near_me_outlined,
                                            color: fontColor, size: 12.sp),
                                        SizedBox(width: 4.w),
                                        Text(
                                          '${attraction.distance} km',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 11.sp,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
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
              }),
      
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detailData?.freshupDescription ?? "",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                height: 1.5,
                                fontSize: 13.sp),
                          ),
                          if (detailData?.yearBuild != null ||
                              detailData?.yearRenovated != null) ...[
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                if (detailData?.yearBuild != null) ...[
                                  Icon(Icons.build_circle_outlined,
                                      size: 16.sp, color: blue),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "Built in ${detailData!.yearBuild}",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: fontColor),
                                  ),
                                  if (detailData.yearRenovated != null) ...[
                                    SizedBox(width: 16.w),
                                    Icon(Icons.auto_awesome_outlined,
                                        size: 16.sp, color: blue),
                                    SizedBox(width: 4.w),
                                    Text(
                                      "Renovated in ${detailData.yearRenovated}",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: fontColor),
                                    ),
                                  ],
                                ] else if (detailData?.yearRenovated != null) ...[
                                  Icon(Icons.auto_awesome_outlined,
                                      size: 16.sp, color: blue),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "Renovated in ${detailData!.yearRenovated}",
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
                          if (detailData?.phoneNumber != null) ...[
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(Icons.phone_outlined,
                                    size: 14.sp, color: blue),
                                SizedBox(width: 6.w),
                                Text(
                                  detailData!.phoneNumber!,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13.sp,
                                      color: black),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
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
        Obx(
          () => controller.isSlotsLoading.value
              ? Positioned.fill(
                  child: Container(
                    color: Colors.white.withOpacity(0.5),
                    child: const Center(
                      child: AppLoader(size: 50),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
        ),
      ),
    );
}

  Widget _buildRoomCard(HotelRoom room) {
    return Obx(() {
      final isSelected = controller.selectedFreshupRoom.value?.id == room.id;
      return GestureDetector(
        onTap: () {
          controller.selectRoom(room);
          if (_pageController.hasClients) {
            _pageController.jumpToPage(0);
          }
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
              // Room Image with Checkmark Overlay
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
                        if (isSelected)
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
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        if (room.roomSize != null) ...[
                          Icon(Icons.square_foot_outlined,
                              size: 14.sp, color: fontColor),
                          SizedBox(width: 4.w),
                          Text(
                            "${room.roomSize} sqft",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                color: fontColor),
                          ),
                          SizedBox(width: 12.w),
                        ],
                        if (room.availableRoomsCount != null) ...[
                          Icon(Icons.meeting_room_outlined,
                              size: 14.sp, color: fontColor),
                          SizedBox(width: 4.w),
                          Text(
                            "${room.availableRoomsCount} Rooms Available",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                color: fontColor),
                          ),
                        ],
                      ],
                    ),
                    if (room.mealOption != null) ...[
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Icon(Icons.restaurant_menu,
                              size: 14.sp, color: green),
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
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // if (room.price != null &&
                            //     room.price != room.offerPrice?.toString())
                            //   Text(
                            //     "₹${room.price}",
                            //     style: TextStyle(
                            //       fontFamily: 'Poppins',
                            //       decoration: TextDecoration.lineThrough,
                            //       color: grey,
                            //       fontSize: 13.sp,
                            //     ),
                            //   ),
                            // if (room.price != null &&
                            //     room.price != room.offerPrice?.toString())
                            //   SizedBox(width: 6.w),
                            // if (room.price != null &&
                            //     room.price != room.offerPrice?.toString())
                            //   Text(
                            //     "Offer Price:",
                            //     style: TextStyle(
                            //       fontFamily: 'Poppins',
                            //       color: blue.withOpacity(0.6),
                            //       fontSize: 13.sp,
                            //     ),
                            //   ),
                          ],
                        ),
                        if (isSelected)
                          Icon(Icons.check_circle, color: blue, size: 20.sp),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
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
                  headerColor: const Color(0xFFF3E5F5),
                  iconColor: const Color(0xFF7B1FA2),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3E5F5),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.king_bed_outlined,
                                color: const Color(0xFF7B1FA2), size: 16.sp),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (data.extraBedPolicy == 'true' ||
                                          data.extraBedPolicy == 'Available' ||
                                          data.extraBedPolicy == 'Yes')
                                      ? 'Extra beds available on request'
                                      : data.extraBedPolicy ?? 'No',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                    color: black,
                                  ),
                                ),
                                if (data.extraBedPrice != null &&
                                    data.extraBedPrice != "null" &&
                                    data.extraBedPrice != "0") ...[
                                  SizedBox(height: 6.h),
                                  Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF3E5F5),
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Text(
                                        '₹${data.extraBedPrice} /night',
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
          if (data.propertyRules != null || data.smokingAllowed != null) ...[
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data.smokingAllowed != null) ...[
                  Expanded(
                    child: PolicyCard(
                      title: 'Smoking Policy',
                      icon: Icons.smoke_free_rounded,
                      headerColor: Colors.orange.shade50,
                      iconColor: Colors.orange.shade700,
                      content: Row(
                        children: [
                          Icon(
                            data.smokingAllowed == true
                                ? Icons.smoking_rooms_rounded
                                : Icons.smoke_free_rounded,
                            color: data.smokingAllowed == true
                                ? Colors.green
                                : Colors.red,
                            size: 16.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            data.smokingAllowed == true
                                ? 'Smoking\nAllowed'
                                : 'Smoking\nProhibited',
                              //  maxLines: 2,
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
                  if (data.propertyRules == null)
                    const Expanded(child: SizedBox()),
                ],
                if (data.propertyRules != null) ...[
                  if (data.smokingAllowed != null) SizedBox(width: 10.w),
                  Expanded(
                    child: PolicyCard(
                      title: 'Property Rules',
                      icon: Icons.do_not_disturb_on_outlined,
                      headerColor: Colors.purple.shade50,
                      iconColor: Colors.purple.shade700,
                      content: Text(
                        data.propertyRules?.join(' ') ?? '',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.sp,
                          color: black,
                        ),
                      ),
                    ),
                  ),
                  if (data.smokingAllowed == null)
                    const Expanded(child: SizedBox()),
                ],
              ],
            ),
          ],
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
