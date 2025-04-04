// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/categorie_screen/categorie_screen.dart';
import 'package:homesloc/screens/detailed_view_screen/detailed_view_screen.dart';
import 'package:homesloc/screens/home/home_screen.dart';
import 'package:homesloc/core/controller/bottom_navigation_bar/new_navigation.dart';
import 'package:homesloc/core/widgets/builder/home_builder/fourth_home_builder.dart';
import 'package:homesloc/core/widgets/builder/search_builder/first_search_builder.dart';
import 'package:homesloc/core/widgets/builder/search_builder/fourth_search_builder.dart';
import 'package:homesloc/core/widgets/builder/search_builder/second_search_builder.dart';
import 'package:homesloc/core/widgets/builder/search_builder/third_search_builder.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/logo.dart/second_logo.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/core/widgets/view_all_button/view_all_button.dart';
import 'package:homesloc/screens/search_screen/filter_screen/filter_screen.dart';

import '../../controller/home/home_screen_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> budgetRanges = ['1000-8000', '8000-15000', '15000+'];
  String? selectedRange;
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  // Get search data controller
  final searchDataController = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: blue,
            automaticallyImplyLeading: false,
            pinned:
                false, // Change to true if you want the AppBar to remain visible at the top when scrolling
            floating: true, // Set true to make it appear when scrolling up
            snap: true, // Works with `floating` to snap into view
            // expandedHeight: 100.h, // Adjust the height as needed
            title: Padding(
              padding: EdgeInsets.only(left: 90.w),
              child: SecondLog(),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 15.w, top: 8.h),
                width: 21.w,
                height: 21.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/notifications-outline.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  height: 98.h,
                  width: MediaQuery.of(context).size.width,
                  color: blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 334.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: gblue,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Obx(() => Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 13.w, top: 15.h),
                                child: Text(
                                  // Display the location from controller
                                  searchDataController.location.value.isEmpty
                                      ? "Enter location"
                                      : "Hotels in ${searchDataController.location.value}",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: poppinsFont,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w100),
                                ),
                              ),
                              Positioned(
                                right: 120.w,
                                bottom: 2.h,
                                child: Text(
                                  '|',
                                  style: TextStyle(
                                    color: poppinsFont,
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 15.w,
                                top: 8.h,
                                child: Text(
                                  // Display date range from controller
                                  searchDataController.getFormattedDateRange().isNotEmpty
                                      ? searchDataController.getFormattedDateRange()
                                      : "Select dates",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: poppinsFont,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w100),
                                ),
                              ),
                              Positioned(
                                right: 28.w,
                                top: 24.h,
                                child: Text(
                                  // Display guest and room info
                                  searchDataController.getGuestRoomInfo(),
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: poppinsFont,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w100),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            PopupMenuButton(
                              offset: Offset(0, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem<String>(
                                  value: 'hotel',
                                  child: Text(
                                    'Hotel',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'apartment',
                                  child: Text(
                                    'Apartment',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'villa',
                                  child: Text(
                                    'Villa',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'resort',
                                  child: Text(
                                    'Resort',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'cabin',
                                  child: Text(
                                    'Cabin',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'cottage',
                                  child: Text(
                                    'Cottage',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'glamping_site',
                                  child: Text(
                                    'Glamping Site',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'guest_house',
                                  child: Text(
                                    'Guest House',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'holyday_apartment',
                                  child: Text(
                                    'Holyday Apartment',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ],
                              child: Container(
                                height: 30.h,
                                width: 105.w,
                                decoration: BoxDecoration(
                                  color: gblue,
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sort",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: poppinsFont,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    Image(
                                      image:
                                          AssetImage('assets/images/Frame.png'),
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // GestureDetector(
                            //   onTapDown: (TapDownDetails details) =>
                            //       _showPopupMenu(context, details),
                            //   child: Container(
                            //     height: 30.h,
                            //     width: 105.w,
                            //     decoration: BoxDecoration(
                            //       color: gblue,
                            //       borderRadius: BorderRadius.circular(10.sp),
                            //     ),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Text(
                            //           "Sort",
                            //           style: TextStyle(
                            //               fontFamily: 'Poppins',
                            //               color: poppinsFont,
                            //               fontSize: 13.sp,
                            //               fontWeight: FontWeight.w100),
                            //         ),
                            //         SizedBox(
                            //           width: 7.w,
                            //         ),
                            //         Image(
                            //           image:
                            //               AssetImage('assets/images/Frame.png'),
                            //           color: white,
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: Container(
                            //     height: 30.h,
                            //     width: 105.w,
                            //     decoration: BoxDecoration(
                            //       color: gblue,
                            //       borderRadius: BorderRadius.circular(10.sp),
                            //     ),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Text(
                            //           "Price",
                            //           style: TextStyle(
                            //               fontFamily: 'Poppins',
                            //               color: poppinsFont,
                            //               fontSize: 13.sp,
                            //               fontWeight: FontWeight.w100),
                            //         ),
                            //         SizedBox(
                            //           width: 3.w,
                            //         ),
                            //         Icon(
                            //           Icons.keyboard_arrow_down,
                            //           size: 20.sp,
                            //           color: poppinsFont,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            PopupMenuButton<String>(
                              color: white,
                              position: PopupMenuPosition.under,
                              offset: const Offset(-75, 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  enabled:
                                      false, // Makes the item non-clickable
                                  child: Container(
                                    decoration: BoxDecoration(color: white),
                                    // width: 250.w,
                                    padding: EdgeInsets.all(8.r),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Budget (Per Night)',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: blue,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                controller: minController,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Min',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 8,
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: TextField(
                                                controller: maxController,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Max',
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 8,
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: budgetRanges.map((range) {
                                            return InkWell(
                                              onTap: () {
                                                final values = range.split('-');
                                                if (values.length > 1) {
                                                  minController.text =
                                                      values[0];
                                                  maxController.text = values[1]
                                                      .replaceAll('+', '');
                                                } else {
                                                  minController.text = values[0]
                                                      .replaceAll('+', '');
                                                  maxController.text = '';
                                                }
                                                setState(() {
                                                  selectedRange = range;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  border:
                                                      Border.all(color: grey),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  range,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: blue,
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w100,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              child: Container(
                                height: 30.h,
                                width: 105.w,
                                decoration: BoxDecoration(
                                  color: gblue,
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Price",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: poppinsFont,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: poppinsFont,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => FilterSearchScreen());
                              },
                              child: Container(
                                height: 30.h,
                                width: 105.w,
                                decoration: BoxDecoration(
                                  color: gblue,
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Filter",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: poppinsFont,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w100),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Image(
                                      image: AssetImage(
                                        'assets/images/Frame (2).png',
                                      ),
                                      width: 13.w,
                                      height: 13.h,
                                      color: white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                NameView(
                  name: 'Best hotels near you',
                  color: black,
                  secondName: '16 Result',
                  secondColor: black,
                ),
              ],
            ),
          ),
          FirstSearchBuilder(),
          SliverToBoxAdapter(
              child: Column(
            children: [
              HomeDivider(),
              NameView(
                name: 'Special Offers',
                color: black,
                secondName: 'View All',
                secondColor: black,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 15.h),
                child: SizedBox(
                  // color: yellow,
                  height: 130.h,
                  // width: MediaQuery.of(context).size.width,
                  child: SecondSearchBuilder(),
                ),
              ),
              HomeDivider(),
              NameView(
                name: 'Experience Packages',
                color: black,
                secondName: 'View all',
                secondColor: black,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 195.h,
                // color: yellow,
                child: ThirdSearchBuilder(),
              ),
              HomeDivider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Hotels",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 38.w,
                      height: 33.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: gwhite,
                        image: DecorationImage(
                          image: AssetImage('assets/images/Vector (3).png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          )),
          FourthSearchBuilder(),
          SliverToBoxAdapter(child: ViewAllButton()),
        ],
      ),
    );
  }
}
