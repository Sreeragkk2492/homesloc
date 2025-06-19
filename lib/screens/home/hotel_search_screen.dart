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
import 'package:homesloc/screens/detailed_view_screen/detailed_view_screen.dart';
import 'package:homesloc/screens/home/widget/build_ameneties.dart';
import 'package:homesloc/screens/home/widget/calendar_bottom_sheet.dart';
import 'package:homesloc/screens/home/widget/guest_dialog.dart';
import 'package:homesloc/screens/home/widget/search_button.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

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
                                    // Call the search method
                                    searchHotelController.searchHotels();
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
            } else if (searchHotelController.searchResult.value?.hotels?.isEmpty ?? true) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(
                      //   Icons.search_off,
                      //   size: 64.sp,
                      //   color: Colors.grey,
                      // ),
                      // SizedBox(height: 16.h),
                       Container(
                            width: 150.w,
                            height: 150.h,
                            child: Lottie.asset(
                              'assets/images/search_animation.json', 
                             // controller: _checkmarkController,
                              repeat:true, 
                            ),
                          ),
                      // Text(
                      //   'No hotels found',
                      //   style: TextStyle(
                      //     fontSize: 18.sp,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      // SizedBox(height: 8.h),
                      // Text(
                      //   'Try adjusting your search criteria',
                      //   style: TextStyle(
                      //     fontSize: 14.sp,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                    ],
                  ),
                ),
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
                      try {
                        final minPrice = double.parse(hotel.priceRange!.min!);
                        final maxPrice = double.parse(hotel.priceRange!.max!);
                        if (maxPrice > 0) {
                          discountPercentage =
                              ((maxPrice - minPrice) / maxPrice * 100).round();
                        }
                      } catch (e) {
                        print('Error parsing price: $e');
                      }
                    }

                    // Check if hotel has full property data
                    final hasFullProperty = hotel.isFullProperty == true &&
                        hotel.fullProperty != null;

                    return Column(
                      children: [
                        // Hotel Info Section - Only show if it has full property data
                        if (hasFullProperty)
                          GestureDetector(
                            onTap: () {
                              Get.to(() => DetailedViewScreen(
                                    hotel: hotel,
                                    startDate: DateFormat('yyyy-MM-dd').format(
                                        calendarController.checkInDate.value!),
                                    endDate: DateFormat('yyyy-MM-dd').format(
                                        calendarController.checkOutDate.value!),
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 5.h,
                                  bottom: 5.h,
                                  left: 10.w,
                                  right: 10.w),
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
                                    margin:
                                        EdgeInsets.only(left: 5.w, top: 2.h),
                                    width: 144.w,
                                    height: 128.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(13.sp),
                                      image: DecorationImage(
                                        image: NetworkImage(hotel
                                                .coverImageUrl ??
                                            'https://via.placeholder.com/150'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.w, top: 11.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (hotel.name ?? "Hotel Name").length >
                                                  20
                                              ? "${(hotel.name ?? "Hotel Name").substring(0, 20)}..."
                                              : hotel.name ?? "Hotel Name",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        SizedBox(height: 3.h),
                                        Text(
                                          (hotel.locationInfo?.city ?? "City")
                                                      .length >
                                                  20
                                              ? "${(hotel.locationInfo?.city ?? "City").substring(0, 20)}..."
                                              : hotel.locationInfo?.city ??
                                                  "City",
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
                                                decoration:
                                                    TextDecoration.lineThrough,
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
                                            buildAmenities(hotel),
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        // Rooms Section - Show for all hotels
                        if (hotel.rooms != null && hotel.rooms!.isNotEmpty)
                          ...hotel.rooms!
                              .map((room) => GestureDetector(
                                    onTap: () {
                                      Get.to(() => DetailedViewScreen(
                                            hotel: hotel,
                                            selectedRoom: room,
                                            roomId: room.id,
                                            startDate: calendarController
                                                .checkInDate.value
                                                ?.toIso8601String(),
                                            endDate: calendarController
                                                .checkOutDate.value
                                                ?.toIso8601String(),
                                          ));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 5.h,
                                          bottom: 5.h,
                                          left: 10.w,
                                          right: 10.w),
                                      width: 339.w,
                                      height: 138.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: border),
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 5.w, top: 2.h),
                                            width: 144.w,
                                            height: 128.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(13.sp),
                                              image: DecorationImage(
                                                image: NetworkImage(room
                                                                .roomImages !=
                                                            null &&
                                                        room.roomImages!
                                                            .isNotEmpty
                                                    ? room.roomImages![0]
                                                    : 'https://via.placeholder.com/150'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 5.w, top: 11.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  room.roomName ?? "Room",
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                SizedBox(height: 3.h),
                                                Text(
                                                  room.roomType ?? "Room Type",
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: fontColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11.sp,
                                                  ),
                                                ),
                                                SizedBox(height: 3.h),
                                                Text(
                                                  "₹${room.price ?? '0'}",
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                SizedBox(height: 3.h),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 7.w),
                                                  child: Text(
                                                    "+ ₹${(double.parse(room.price ?? '0') * 0.18).round()} Taxes & Fees",
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
                                                    buildAmenities(hotel),
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
                                                            BorderRadius
                                                                .circular(3.sp),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "${hotel.starRating}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                      ],
                    );
                  },
                  childCount: searchHotelController
                          .searchResult.value?.hotels?.length ??
                      0,
                ),
              );
            } else {
              // Show FourthHomeBuilder when no search results
              return FourthHomeBuilder();
            }
          })
        ],
      ),
    );
  }
}
