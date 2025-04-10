import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/animations/animated_content.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/controller/home/home_screen_controller.dart';
import 'package:homesloc/controller/search/search_fresh_up_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/logo.dart/logo.dart';
import 'package:homesloc/core/widgets/search_form/search_form.dart';
import 'package:homesloc/models/search/search_fresh_up_model.dart';
import 'package:homesloc/screens/home/widget/calendar_bottom_sheet.dart';
import 'package:homesloc/screens/home/widget/guest_dialog.dart';
import 'package:homesloc/screens/home/widget/search_button.dart';

class FreshUpSearchScreen extends StatelessWidget {
  FreshUpSearchScreen({super.key});

  final calendarController = Get.put(CalendarController());
  final screenController = Get.put(HomeScreenController());
  final freshUpController = Get.put(SearchFreshUpController());

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
                                        builder: (context) => const CalendarBottomSheet(),
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
                                    // Set the dates in the fresh up controller
                                    freshUpController.setCheckInDate(
                                        calendarController.formatDateForApi(
                                            calendarController
                                                .checkInDate.value));
                                    freshUpController.setCheckOutDate(
                                        calendarController.formatDateForApi(
                                            calendarController
                                                .checkOutDate.value));
                                    
                                    // Perform the search
                                    freshUpController.searchFreshUp(refresh: true);
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
            if (freshUpController.isLoading.value) {
              return SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: blue,
                  ),
                ),
              );
            } else if (freshUpController.services.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64.sp,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No fresh up services found',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Try adjusting your search criteria',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == 0) {
                      // Return the heading for the first item
                      return Container(
                        margin: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 16.w, right: 16.w),
                        child: Text(
                          "Fresh Up ${freshUpController.services.length} Properties Found",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      );
                    } else {
                      // Return service card for other items
                      final service = freshUpController.services[index - 1];
                      return _buildServiceCard(service);
                    }
                  },
                  childCount: freshUpController.services.length + 1, // Add 1 for the heading
                ),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Service service) {
    return Container(
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
            height: 128.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13.sp),
              image: DecorationImage(
                image: NetworkImage(service.coverImageUrl ?? 'https://via.placeholder.com/150'),
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
                  service.name ?? "Service",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  service.location ?? "Location",
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
                      "₹${service.price ?? '0'}",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Text(
                      "Amenities : ",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: fontColor,
                        fontSize: 11.sp,
                      ),
                    ),
                    if (service.amenities != null && service.amenities!.isNotEmpty)
                      _buildAmenities(service.amenities!)
                    else
                      Text(
                        "N/A",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: fontColor,
                          fontSize: 11.sp,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 3.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Service Type: ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: fontColor,
                            fontSize: 10.sp,
                          ),
                        ),
                        Text(
                          "${service.serviceType ?? 'N/A'}",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: black,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          "Availability: ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: fontColor,
                            fontSize: 10.sp,
                          ),
                        ),
                        Text(
                          "${service.availability ?? 'N/A'}",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: black,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenities(List<Amenity> amenities) {
    if (amenities.isEmpty) {
      return Text(
        "N/A",
        style: TextStyle(
          fontFamily: 'Poppins',
          color: fontColor,
          fontSize: 11.sp,
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(left: 5.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Show first amenity
          _buildAmenityChip(_truncateAmenityName(amenities[0].name ?? "Amenity")),
          SizedBox(width: 4.w),
          // Show count of remaining amenities
          if (amenities.length > 1) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: gwhite,
                borderRadius: BorderRadius.circular(4.sp),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "+${amenities.length - 1}",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: ogBlue,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAmenityChip(String amenityName) {
    return Container(
      constraints: BoxConstraints(maxWidth: 60.w),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: gwhite,
        borderRadius: BorderRadius.circular(4.sp),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 10.sp,
            color: ogBlue,
          ),
          SizedBox(width: 3.w),
          Flexible(
            child: Text(
              amenityName,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: fontColor,
                fontSize: 10.sp,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  String _truncateAmenityName(String name) {
    if (name.length > 8) {
      return name.substring(0, 8) + "...";
    }
    return name;
  }
}