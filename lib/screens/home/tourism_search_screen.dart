import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/animations/animated_content.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/controller/home/home_screen_controller.dart';
import 'package:homesloc/controller/search/tourist_search_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/logo.dart/logo.dart';
import 'package:homesloc/core/widgets/search_form/search_form.dart';
import 'package:homesloc/models/search/search_tourist_package_model.dart';
import 'package:homesloc/screens/detailed_view_screen/detail_view_tourism_screen.dart';
import 'package:homesloc/screens/home/widget/calendar_bottom_sheet.dart';
import 'package:homesloc/screens/home/widget/guest_dialog.dart';
import 'package:homesloc/screens/home/widget/search_button.dart';
import 'package:lottie/lottie.dart';

class TourismPackageSearchScreen extends StatelessWidget {
  TourismPackageSearchScreen({super.key});

  final calendarController = Get.put(CalendarController());
  final screenController = Get.put(HomeScreenController());
  final toouristcontroller = Get.put(TouristSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: blue,
            automaticallyImplyLeading: false,
            pinned: false,
            floating: true,
            snap: true,
            title: Logo(),
            actions: [
              Container(
                color: blue,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 15.w, top: 10.h),
                    width: 21.w,
                    height: 21.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/notifications-outline.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  color: blue,
                  width: double.infinity,
                  height: 52.h,
                  child: Column(
                    children: [
                      AnimatedContent(
                          show: true,
                          leftToRight: 0.0,
                          topToBottom: 5.0,
                          time: 1500,
                          child: SearchForm()),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 47.h,
                        width: MediaQuery.of(context).size.width,
                        color: blue,
                        child: Padding(
                          padding: EdgeInsets.only(left: 14.w, bottom: 9.h),
                          child: Row(
                            children: [
                              AnimatedContent(
                                leftToRight: 5.5,
                                topToBottom: 0.0,
                                time: 1500,
                                show: true,
                                child: Container(
                                  height: 30.h,
                                  width: 221.w,
                                  decoration: BoxDecoration(
                                    color: gblue,
                                    borderRadius: BorderRadius.circular(6.sp),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                        builder: (context) =>
                                            const CalendarBottomSheet(),
                                      );
                                    },
                                    child: Obx(() => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'assets/images/Vector.png'),
                                              width: 15.w,
                                              height: 15.h,
                                            ),
                                            Text(
                                              calendarController
                                                          .checkInDate.value !=
                                                      null
                                                  ? calendarController
                                                      .formatDateShort(
                                                          calendarController
                                                              .checkInDate
                                                              .value)
                                                  : "Check in",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: poppinsFont,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w100,
                                              ),
                                            ),
                                            Text(
                                              "|",
                                              style: TextStyle(
                                                color: poppinsFont,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              calendarController
                                                          .checkOutDate.value !=
                                                      null
                                                  ? calendarController
                                                      .formatDateShort(
                                                          calendarController
                                                              .checkOutDate
                                                              .value)
                                                  : "Checkout",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: poppinsFont,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w100,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: BookingDialog(),
                                    ),
                                  );
                                },
                                child: AnimatedContent(
                                  leftToRight: 0.0,
                                  time: 1500,
                                  topToBottom: 5.0,
                                  show: true,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    width: 100.w,
                                    height: 30.h,
                                    decoration: BoxDecoration(
                                      color: gblue,
                                      borderRadius: BorderRadius.circular(6.sp),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/images/Vector (1).png'),
                                          width: 16.w,
                                          height: 16.h,
                                        ),
                                        SizedBox(
                                          width: 6.w,
                                        ),
                                        Text(
                                          "Guests",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: poppinsFont,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 67.h,
                        width: MediaQuery.of(context).size.width,
                        color: blue,
                        child: Padding(
                            padding: EdgeInsets.only(left: 14.w, bottom: 9.h),
                            child: GestureDetector(
                                onTap: () {
                                  // Only proceed if dates are selected
                                  if (calendarController.checkInDate.value !=
                                          null &&
                                      calendarController.checkOutDate.value !=
                                          null) {
                                    // Set the dates in the hall search controller
                                    toouristcontroller.setCheckInDate(
                                        calendarController.formatDateForApi(
                                            calendarController
                                                .checkInDate.value));
                                    toouristcontroller.setCheckOutDate(
                                        calendarController.formatDateForApi(
                                            calendarController
                                                .checkOutDate.value));

                                    // Perform the search
                                    toouristcontroller.searchtourism(
                                        refresh: true);
                                  } else {
                                    // Show a snackbar if dates are not selected
                                    Get.snackbar(
                                      'Date Selection Required',
                                      'Please select check-in and check-out dates',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor:
                                          Colors.red.withOpacity(0.8),
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                                child: SearchButton())),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Display search results
          Obx(() {
            if (toouristcontroller.isLoading.value) {
              return SliverFillRemaining(
                child: Center(child:  Container(
                        width: 50.w,
                        height: 50.h,
                        child: Lottie.asset(
                          'assets/images/loading.json',
                          // controller: _checkmarkController,
                          repeat: true,
                        ),
                      ),),
              );
            } else if (toouristcontroller.tourism.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                            width: 150.w,
                            height: 150.h,
                            child: Lottie.asset(
                              'assets/images/search_animation.json', 
                             // controller: _checkmarkController,
                              repeat:true, 
                            ),
                          ),
                      // Icon(Icons.search_off, size: 64.sp, color: Colors.grey),
                      // SizedBox(height: 16.h),
                      // Text('No tourism packages found',
                      //     style: TextStyle(
                      //         fontSize: 18.sp,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.grey)),
                      // SizedBox(height: 8.h),
                      // Text('Try adjusting your search criteria',
                      //     style:
                      //         TextStyle(fontSize: 14.sp, color: Colors.grey)),
                    ],
                  ),
                ),
              );
            } else {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == 0) {
                      // Heading
                      return Container(
                        margin: EdgeInsets.only(
                            top: 10.h, bottom: 10.h, left: 16.w, right: 16.w),
                        child: Text(
                          "${toouristcontroller.totalCount.value} Tourism Packages Found",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      );
                    } else {
                      final package = toouristcontroller.tourism[index - 1];
                      return _buildTourismPackageCard(package);
                    }
                  },
                  childCount: toouristcontroller.tourism.length + 1,
                ),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildTourismPackageCard(Package package) {
    String? imageUrl =
        (package.galleryImages != null && package.galleryImages!.isNotEmpty)
            ? package.galleryImages!.first
            : null;

    return GestureDetector(
      onTap: () {
        // Only proceed if dates are selected
        if (calendarController.checkInDate.value != null) {
          // Navigate to detail view with required parameters
          Get.to(() => TourismDetailViewScreen(
                packageId: package.id ?? '',
                startDate: calendarController.formatDateForApi(
                    calendarController
                        .checkInDate.value), // Default price method
                endDate: calendarController
                    .formatDateForApi(calendarController.checkOutDate.value),
              ));
        } else {
          // Show a snackbar if date is not selected
          Get.snackbar(
            'Date Selection Required',
            'Please select a check-in date to view details',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w, right: 10.w),
        width: 339.w,
        height: 138.h,
        decoration: BoxDecoration(
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(15.sp),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 5.w, top: 2.h),
              width: 144.w,
              height: 160.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.sp),
                image: DecorationImage(
                  image: NetworkImage(
                      imageUrl ?? 'https://via.placeholder.com/150'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, top: 11.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (package.packageName ?? "Tourism Package").length > 20
                        ? "${(package.packageName ?? "Tourism Package").substring(0, 20)}..."
                        : package.packageName ?? "Tourism Package",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    package.packageType ?? "Destination",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: fontColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Text(
                        "₹${package.priceWithoutFlight ?? '0'}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      if (package.offerPrice != null) ...[
                        SizedBox(width: 5.w),
                        Text(
                          "₹${package.offerPrice}",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: fontColor,
                            fontSize: 9.sp,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        // Text(
                        //   "${_calculateDiscountPercentage(package. ?? '0', package.discountedPrice ?? '0')}% OFF",
                        //   style: TextStyle(
                        //     fontFamily: 'Poppins',
                        //     color: green,
                        //     fontSize: 11.sp,
                        //   ),
                        // ),
                      ],
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Text(
                        "Duration: ",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: fontColor,
                          fontSize: 11.sp,
                        ),
                      ),
                      Text(
                        "${package.durationDays ?? 'N/A'} days, ${package.durationNights ?? 'N/A'} nights",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Text(
                        "Start: ${package.startLocation ?? 'N/A'}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: fontColor,
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      // Text(
                      //   "End: ${package.endDate ?? 'N/A'}",
                      //   style: TextStyle(
                      //     fontFamily: 'Poppins',
                      //     color: fontColor,
                      //     fontSize: 10.sp,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Active: ",
                  //       style: TextStyle(
                  //         fontFamily: 'Poppins',
                  //         color: fontColor,
                  //         fontSize: 11.sp,
                  //       ),
                  //     ),
                  //     Text(
                  //       package.isActive == true ? "Yes" : "No",
                  //       style: TextStyle(
                  //         fontFamily: 'Poppins',
                  //         color: black,
                  //         fontSize: 11.sp,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateDiscountPercentage(String price, String offerPrice) {
    try {
      final double originalPrice = double.parse(price);
      final double discountedPrice = double.parse(offerPrice);
      if (originalPrice > 0) {
        return ((originalPrice - discountedPrice) / originalPrice * 100)
            .round();
      }
    } catch (e) {
      print('Error calculating discount: $e');
    }
    return 0;
  }
}

int? parseJsonToInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}
