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
import 'package:homesloc/screens/detailed_view_screen/full_property_detailed_view_screen.dart';
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
            } else if (searchHotelController.searchResult.value?.accommodations.isEmpty ?? true) {
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
                    ],
                  ),
                ),
              );
            } else if (searchHotelController.searchResult.value?.accommodations !=
                    null &&
                searchHotelController.searchResult.value!.accommodations.isNotEmpty) {
              // Display search results
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final accommodation = searchHotelController
                        .searchResult.value!.accommodations[index];

                    // Calculate discount percentage if price is available
                    int discountPercentage = 0;
                    if (accommodation.price != null && accommodation.offerPrice != null) {
                      try {
                        final originalPrice = double.parse(accommodation.price!);
                        final offerPrice = double.parse(accommodation.offerPrice!);
                        if (originalPrice > 0) {
                          discountPercentage =
                              ((originalPrice - offerPrice) / originalPrice * 100).round();
                        }
                      } catch (e) {
                        print('Error parsing price: $e');
                      }
                    }

                    // Determine which price to display based on accommodation type
                    String displayPrice;
                    String originalPrice;
                    
                    if (accommodation.accommodationType == 'ROOM') {
                      // For ROOM type, use room price and offer price
                      displayPrice = accommodation.offerPrice ?? accommodation.price ?? '0';
                      originalPrice = accommodation.price ?? '0';
                    } else {
                      // For FULL_PROPERTY type, use base property price
                      displayPrice = accommodation.offerPrice ?? accommodation.basePropertyPrice ?? '0';
                      originalPrice = accommodation.price ?? accommodation.basePropertyPrice ?? '0';
                    }

                    return Column(
                      children: [
                        // Main Accommodation Card
                          GestureDetector(
                            onTap: () {
                            Get.to(() => FullPropertyDetailedViewScreen(
                                hotel: accommodation,
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
                                      image: NetworkImage(accommodation
                                              .coverImageUrl.isNotEmpty
                                          ? accommodation.coverImageUrl
                                          : 'https://via.placeholder.com/150'),
                                        fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.w, top: 11.h, right: 5.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          accommodation.name.length > 20
                                              ? "${accommodation.name.substring(0, 20)}..."
                                              : accommodation.name,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 3.h),
                                        Text(
                                          accommodation.city.length > 20
                                              ? "${accommodation.city.substring(0, 20)}..."
                                              : accommodation.city,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: fontColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 3.h),
                                        Flexible(
                                          child: Row(
                                          children: [
                                              Flexible(
                                                child: Text(
                                                  "₹$displayPrice",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                              if (originalPrice != '0') ...[
                                            SizedBox(width: 5.w),
                                                Flexible(
                                                  child: Text(
                                                    "₹$originalPrice",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: fontColor,
                                                fontSize: 9.sp,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                              ],
                                              if (discountPercentage > 0) ...[
                                            SizedBox(width: 5.w),
                                                Flexible(
                                                  child: Text(
                                              "$discountPercentage% OFF",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: green,
                                                fontSize: 11.sp,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 3.h),
                                        Text(
                                          "+ ₹${(double.parse(displayPrice) * 0.18).round()} Taxes & Fees",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: fontColor,
                                              fontSize: 11.sp,
                                            ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 3.h),
                                        Flexible(
                                          child: Row(
                                          children: [
                                            Text(
                                              "Amenities : ",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: fontColor,
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                              Expanded(
                                                child: buildAmenities(accommodation),
                                              ),
                                          ],
                                          ),
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
                                                    "${accommodation.hotelStarRating ?? 0}",
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
                                            Flexible(
                                              child: Text(
                                                "${accommodation.quantity ?? 0} Rooms Available",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: fontColor,
                                                fontSize: 10.sp,
                                                ),
                                                overflow: TextOverflow.ellipsis,
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
                            ),
                          ),
                      ],
                    );
                  },
                  childCount: searchHotelController
                          .searchResult.value?.accommodations.length ??
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
