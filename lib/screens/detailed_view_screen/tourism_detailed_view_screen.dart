import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/tourism/tourism_detail_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/loader/app_loader.dart';
import 'package:homesloc/core/widgets/gallery/full_screen_image_viewer.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/models/tourism/tourism_detail_model.dart';
import 'package:homesloc/screens/detailed_view_screen/tourism_widgets/tourism_agency.dart';
import 'package:homesloc/screens/detailed_view_screen/tourism_widgets/tourism_amenities.dart';
import 'package:homesloc/screens/detailed_view_screen/tourism_widgets/tourism_highlights.dart';
import 'package:homesloc/screens/detailed_view_screen/tourism_widgets/tourism_itinerary.dart';
import 'package:homesloc/screens/detailed_view_screen/tourism_widgets/tourism_book_now.dart';

class TourismDetailedViewScreen extends StatefulWidget {
  final String packageId;
  final String? startDate;
  final String? endDate;

  const TourismDetailedViewScreen({
    super.key,
    required this.packageId,
    this.startDate,
    this.endDate,
  });

  @override
  State<TourismDetailedViewScreen> createState() =>
      _TourismDetailedViewScreenState();
}

class _TourismDetailedViewScreenState extends State<TourismDetailedViewScreen> {
  final PageController _pageController = PageController();
  late final TourismDetailController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(TourismDetailController(
      packageId: widget.packageId,
      initialStartDate: widget.startDate,
      initialEndDate: widget.endDate,
    ));
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
    return Scaffold(
      backgroundColor: white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppLoader(size: 50));
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value,
                    style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                SizedBox(height: 10.h),
                ElevatedButton(
                  onPressed: () => controller.fetchTourismDetails(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final data = controller.tourismDetails.value;
        if (data == null) return const SizedBox.shrink();

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageHeader(context, data),
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
                            data.packageName ?? '',
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
                                5,
                                (index) => Icon(Icons.star_rounded,
                                    color: yellow, size: 18.sp),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '(0 Reviews)', // Tourism doesn't have reviews in model yet
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
              // We don't have FirstDetailedViewBuilder for Tourism, but we can show duration/type
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Row(
                  children: [
                    _buildInfoChip(Icons.timer_outlined,
                        "${data.durationDays}D / ${data.durationNights}N"),
                    SizedBox(width: 10.w),
                    _buildInfoChip(
                        Icons.category_outlined, data.packageType ?? "Tour"),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Package details',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: blue,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold),
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
                        data.destination ?? 'Destination',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: black,
                            fontSize: 13.sp),
                      ),
                    ),
                  ],
                ),
              ),
              if (data.agencyDetails?.phoneNumber != null) ...[
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
                        data.agencyDetails!.phoneNumber!,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: black,
                            fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
              ],
              const HomeDivider(),
              TourismAmenitiesSection(amenities: data.amenities),
              const HomeDivider(),
              TourismBookNow(data: data),
              const HomeDivider(),
              Padding(
                padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
                child: Text(
                  'Itinerary',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: blue,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ItinerarySection(itinerary: data.itinerary),
              const HomeDivider(),
              Padding(
                padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
                child: Text(
                  'About this package',
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
                      image: NetworkImage(data.images?.first ??
                          data.galleryImages?.first ??
                          data.agencyDetails?.coverImageUrl ??
                          ""),
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  data.description ?? '',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: black,
                      height: 1.5,
                      fontSize: 13.sp),
                ),
              ),
              const HomeDivider(),
              PackageHighlightsSection(
                attractions: data.tripAttractions,
                exclusions: data.tripExclusions,
              ),
              const HomeDivider(),
              NameView(
                  name: 'Package Policies',
                  color: blue,
                  secondName: 'View All',
                  secondColor: blue),
              if (data.agencyDetails?.policies?.cancellationPolicy != null)
                _buildPolicyHighlight(
                  icon: Icons.assignment_return_rounded,
                  title: 'Cancellations & Refunds',
                  content: data.agencyDetails!.policies!.cancellationPolicy!,
                ),
              if (data.agencyDetails?.policies?.paymentPolicy != null)
                _buildPolicyHighlight(
                  icon: Icons.payment_rounded,
                  title: 'Payment Policy',
                  content: data.agencyDetails!.policies!.paymentPolicy!,
                ),
              const HomeDivider(),
              AgencyDetailSection(agency: data.agencyDetails),
              SizedBox(height: 40.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: gwhite,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: blue),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(
                fontFamily: 'Poppins',
                color: blue,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context, TourismDetailModel data) {
    final images = data.images != null && data.images!.isNotEmpty
        ? data.images!
        : (data.galleryImages ?? []);
    if (images.isEmpty) images.add('assets/images/sunrise.jpg');

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
                Icons.favorite_outline_rounded,
                color: blue,
                size: 20.sp,
              ),
            ),
          ),
        ), */
        // Expanding Dots Indicator
        if (images.length > 1)
          Positioned(
            bottom: 20.h,
            left: 20.w,
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      width:
                          controller.carouselIndex.value == index ? 20.w : 6.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: controller.carouselIndex.value == index
                            ? yellow
                            : white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                )),
          ),
        // Glassmorphic Image Count Overlay
        Positioned(
          bottom: 15.h,
          right: 15.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: white.withOpacity(0.2), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.image_outlined, color: white, size: 12.sp),
                SizedBox(width: 5.w),
                Obx(() => Text(
                      '${controller.carouselIndex.value + 1}/${images.length}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
