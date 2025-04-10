import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/animations/animated_content.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/controller/home/home_screen_controller.dart';
import 'package:homesloc/controller/search/hall_search_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/builder/home_builder/fourth_home_builder.dart';
import 'package:homesloc/core/widgets/logo.dart/logo.dart';
import 'package:homesloc/core/widgets/search_form/search_form.dart';
import 'package:homesloc/models/search/search_hall_model.dart';
import 'package:homesloc/screens/detailed_view_screen/detail_view_hall_screen.dart';
import 'package:homesloc/screens/home/widget/calendar_bottom_sheet.dart';
import 'package:homesloc/screens/home/widget/guest_dialog.dart';
import 'package:homesloc/screens/home/widget/search_button.dart';

class HallSearchScreen extends StatelessWidget {
  HallSearchScreen({super.key});

  final calendarController = Get.put(CalendarController());
  final screenController = Get.put(HomeScreenController());
  final hallSearchController = Get.put(HallSearchController());

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
                                    // Set the dates in the hall search controller
                                    hallSearchController.setCheckInDate(
                                        calendarController.formatDateForApi(
                                            calendarController
                                                .checkInDate.value));
                                    hallSearchController.setCheckOutDate(
                                        calendarController.formatDateForApi(
                                            calendarController
                                                .checkOutDate.value));
                                    
                                    // Perform the search
                                    hallSearchController.searchHalls(refresh: true);
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
            if (hallSearchController.isLoading.value) {
              return SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: blue,
                  ),
                ),
              );
            } else if (hallSearchController.halls.isEmpty) {
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
                        'No halls found',
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
              // Extract all hall types from all halls
              List<HallTypeWithParent> allHallTypes = [];
              
              for (var hall in hallSearchController.halls) {
                if (hall.hallType != null) {
                  for (var hallType in hall.hallType!) {
                    if (hallType != null) {  // Add null check for hallType
                      allHallTypes.add(HallTypeWithParent(
                        hallType: hallType,
                        parentHall: hall,
                      ));
                    }
                  }
                }
              }
              
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == 0) {
                      // Return the heading for the first item
                      return Container(
                        margin: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 16.w, right: 16.w),
                        child: Text(
                          "Banquet Hall ${allHallTypes.length} Properties Found",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      );
                    } else {
                      // Return hall type card for other items
                      final hallTypeWithParent = allHallTypes[index - 1];
                      return _buildHallTypeCard(hallTypeWithParent);
                    }
                  },
                  childCount: allHallTypes.length + 1, // Add 1 for the heading
                ),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildHallTypeCard(HallTypeWithParent hallTypeWithParent) {
    final hallType = hallTypeWithParent.hallType;
    final parentHall = hallTypeWithParent.parentHall;
    
    // Add null checks for required values
    if (hallType == null || parentHall == null) {
      return SizedBox.shrink();  // Return empty widget if data is null
    }
    
    return GestureDetector(
      onTap: () {
        // Navigate to the DetailViewHallScreen with the hall and event details
        Get.to(() => DetailViewHallScreen(
          hall: parentHall,
          selectedEvent: hallType,
          eventId: hallType.id,
          startDate: hallSearchController.checkInDate.value,
          endDate: hallSearchController.checkOutDate.value,
        ));
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
              height: 128.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.sp),
                image: DecorationImage(
                  image: NetworkImage(parentHall.coverImage ?? 'https://via.placeholder.com/150'),
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
                    hallType.eventName ?? "Hall Type",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    _formatLocation(parentHall.locationInfo ?? LocationInfo()),
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
                        "₹${hallType.price ?? '0'}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      if (hallType.offerPrice != null && hallType.offerPrice!.isNotEmpty) ...[
                        SizedBox(width: 5.w),
                        Text(
                          "₹${hallType.offerPrice}",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: fontColor,
                            fontSize: 9.sp,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "${_calculateDiscountPercentage(hallType.price ?? '0', hallType.offerPrice ?? '0')}% OFF",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: green,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
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
                      if (hallType.amenities != null && hallType.amenities!.isNotEmpty)
                        _buildAmenities(hallType.amenities!)
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
                            "Venue Type: ",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: fontColor,
                              fontSize: 10.sp,
                            ),
                          ),
                          Text(
                            "${hallType.venueType ?? 'N/A'}",
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
                            "Space Type: ",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: fontColor,
                              fontSize: 10.sp,
                            ),
                          ),
                          Text(
                            "${hallType.spaceType ?? 'N/A'}",
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

  // Helper method to calculate discount percentage safely
  int _calculateDiscountPercentage(String price, String offerPrice) {
    try {
      final double originalPrice = double.parse(price);
      final double discountedPrice = double.parse(offerPrice);
      if (originalPrice > 0) {
        return ((originalPrice - discountedPrice) / originalPrice * 100).round();
      }
    } catch (e) {
      print('Error calculating discount: $e');
    }
    return 0;
  }

  String _formatLocation(LocationInfo location) {
    final parts = <String>[];
    
    if (location.city != null && location.city!.isNotEmpty) {
      parts.add(location.city!);
    }
    
    if (location.state != null && location.state!.isNotEmpty) {
      parts.add(location.state!);
    }
    
    return parts.join(', ');
  }
}

// Helper class to keep track of hall type and its parent hall
class HallTypeWithParent {
  final HallType hallType;
  final Hall parentHall;
  
  HallTypeWithParent({
    required this.hallType,
    required this.parentHall,
  });
}