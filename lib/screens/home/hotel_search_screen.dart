import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/animations/animated_content.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/controller/home/home_screen_controller.dart';
import 'package:homesloc/controller/search/search_hotel_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/builder/home_builder/fourth_home_builder.dart';
import 'package:homesloc/core/widgets/logo.dart/logo.dart';
import 'package:homesloc/core/widgets/search_form/search_form.dart';
import 'package:homesloc/screens/home/widget/guest_dialog.dart';
import 'package:homesloc/screens/home/widget/search_button.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:homesloc/screens/detailed_view_screen/detailed_view_screen.dart';

class HotelSearchScreen extends StatelessWidget {
  HotelSearchScreen({super.key});

  final calendarController = Get.put(CalendarController());
  final screenController = Get.put(HomeScreenController());
  final searchHotelController = Get.put(SearchHotelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: blue,
            automaticallyImplyLeading: false,
            pinned: false,
            // Change to true if you want the AppBar to remain visible at the top when scrolling
            floating: true,
            // Set true to make it appear when scrolling up
            snap: true,
            // Works with `floating` to snap into view
            // expandedHeight: 100.h, // Adjust the height as needed

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
                                      _showCalendarBottomSheet(context);
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (context) {
                                      //   return CalendarScreen();
                                      // }));
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
                                    // Call the search method
                                    searchHotelController.searchHotels();
                                    calendarController.clearDates();
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
          Obx(() {
            if (searchHotelController.isLoading.value) {
              return SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (searchHotelController.errorMessage.value.isNotEmpty) {
              return SliverFillRemaining(
                child: Center(
                    child: Text(searchHotelController.errorMessage.value)),
              );
            } else if (searchHotelController.searchResult.value?.hotels !=
                    null &&
                searchHotelController.searchResult.value!.hotels!.isNotEmpty) {
              // Display search results
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final hotel = searchHotelController
                        .searchResult.value!.hotels![index];

                    // Calculate discount percentage if priceRange is available
                    int discountPercentage = 0;
                    if (hotel.priceRange != null &&
                        hotel.priceRange!.min != null &&
                        hotel.priceRange!.max != null) {
                      final minPrice = double.parse(hotel.priceRange!.min!);
                      final maxPrice = double.parse(hotel.priceRange!.max!);
                      if (maxPrice > 0) {
                        discountPercentage =
                            ((maxPrice - minPrice) / maxPrice * 100).round();
                      }
                    }

                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DetailedViewScreen(hotel: hotel));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 5.h, bottom: 5.h, left: 10.w, right: 10.w),
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
                                image: NetworkImage(hotel.coverImageUrl ??
                                    'https://via.placeholder.com/150'),
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
                                  hotel.name ?? "Hotel Name",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  hotel.locationInfo?.city ?? "City",
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
                                      "₹${hotel.priceRange?.min ?? '0'}",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "₹${hotel.priceRange?.max ?? '0'}",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: fontColor,
                                        fontSize: 9.sp,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "$discountPercentage% OFF",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: green,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.h),
                                Padding(
                                  padding: EdgeInsets.only(left: 7.w),
                                  child: Text(
                                    "+ ₹${(double.parse(hotel.priceRange?.min ?? '0') * 0.18).round()} Taxes & Fees",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: fontColor,
                                      fontSize: 11.sp,
                                    ),
                                  ),
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
                                    _buildAmenities(hotel),
                                  ],
                                ),
                                SizedBox(height: 3.h),
                                Row(
                                  children: [
                                    Container(
                                      width: 44.w,
                                      height: 18.h,
                                      decoration: BoxDecoration(
                                        color: blue,
                                        borderRadius:
                                            BorderRadius.circular(3.sp),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${hotel.starRating}",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: white,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          SizedBox(width: 2.w),
                                          Icon(
                                            Icons.star,
                                            color: yellow,
                                            size: 13.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "${hotel.quickInfo?.totalRooms ?? 0.toInt()} Rooms Available",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: fontColor,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                          ),
                          )
                        ],
                        
                      ),
                    ),
                  );
                  },
                  childCount: searchHotelController
                          .searchResult.value?.hotels?.length ??
                      0,
                ),
              );
            } else {
              // Show a message when no hotels are found
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    "No hotels found. Please search for available hotels.",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      color: fontColor,
                    ),
                  ),
                ),
              );
            }
          })
        ],
      ),
    );
  }

  Widget _buildAmenities(dynamic hotel) {
    if (hotel.quickInfo?.amenities != null &&
        hotel.quickInfo!.amenities!.isNotEmpty) {
      // Character limit for displaying amenities
      final int characterLimit = 16;
      final amenities = hotel.quickInfo!.amenities!;

      // Initialize variables to track displayed text and count
      String displayText = "";
      int displayedCount = 0;
      List<Widget> amenityWidgets = [];

      // Build amenity widgets while respecting character limit
      for (int i = 0; i < amenities.length; i++) {
        final amenityName = amenities[i].name ?? "Amenity";

        // Check if adding this amenity would exceed the character limit
        if (displayText.length + amenityName.length <= characterLimit) {
          // Add separator if not the first item
          if (displayedCount > 0) {
            displayText += ", ";
            amenityWidgets.add(SizedBox(width: 5.w));
          }

          // Add icon and text
          amenityWidgets.add(Icon(
            Icons.local_activity,
            size: 11.sp,
            color: fontColor,
          ));

          amenityWidgets.add(SizedBox(width: 2.w));

          amenityWidgets.add(Text(
            amenityName,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: fontColor,
              fontSize: 11.sp,
            ),
          ));

          // Update tracking variables
          displayText += amenityName;
          displayedCount++;
        } else {
          // We've hit the character limit, add "more..." and break
          amenityWidgets.add(SizedBox(width: 5.w));
          amenityWidgets.add(Text(
            "more...",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: ogBlue,
              fontSize: 11.sp,
            ),
          ));
          break;
        }
      }

      // Return row with the amenity widgets
      return Row(children: amenityWidgets);
    } else {
      // Default amenities if none are provided
      return Row(
        children: [
          Icon(Icons.hotel, size: 11.sp, color: fontColor),
          SizedBox(width: 2.w),
          Text(
            "Basic",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: fontColor,
              fontSize: 11.sp,
            ),
          ),
        ],
      );
    }
  }

  void _showCalendarBottomSheet(BuildContext context) {
    // final calendarController = Get.put(CalendarController());
    final ScrollController calenderScroll = ScrollController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: scaffoldColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          children: [
            // Handle bar at top of bottom sheet
            Container(
              margin: EdgeInsets.only(top: 10.h),
              width: 40.w,
              height: 5.h,
              decoration: BoxDecoration(
                //  color: grey,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),

            // Calendar title
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Text(
                "Calendar",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: blue,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Calendar first row - fixed
            // Container(
            //     width: MediaQuery
            //         .of(context)
            //         .size
            //         .width,
            //     height: 100.h,
            //     child: CalenderFirstRow()
            // ),

            // Only the calendar is scrollable
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: blue),
                    // color: white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ScrollableCleanCalendar(
                    daySelectedBackgroundColor: yellow,
                    daySelectedBackgroundColorBetween: grey,
                    monthTextStyle: TextStyle(
                        color: blue,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold),
                    scrollController: calenderScroll,
                    calendarController: calendarController.calendarController,
                    layout: Layout.BEAUTY,
                    calendarCrossAxisSpacing: 0,
                  ),
                ),
              ),
            ),

            // Date display section - fixed
            Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Check-in date display
                  Obx(() => Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: blue),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Check-In-Date",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              calendarController.checkInDate.value != null
                                  ? calendarController.formatDate(
                                      calendarController.checkInDate.value)
                                  : "Select Date",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      )),

                  // Total days display
                  Obx(() => Container(
                        padding: EdgeInsets.only(
                            left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
                        decoration: BoxDecoration(
                          color: grey,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: blue),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${calendarController.totalDays.value}",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Days",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      )),

                  // Check-out date display
                  Obx(() => Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: blue),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Check-Out-Date",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              calendarController.checkOutDate.value != null
                                  ? calendarController.formatDate(
                                      calendarController.checkOutDate.value)
                                  : "Select Date",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),

            // Done button - fixed at bottom
            Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 43.h,
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(28.sp),
                  ),
                  child: Center(
                    child: Text(
                      "Apply",
                      style: TextStyle(
                          color: black,
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
