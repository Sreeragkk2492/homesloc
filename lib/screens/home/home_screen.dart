// ignore_for_file: unused_import, file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homesloc/animations/animated_content.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/routes/routes.dart';
import 'package:homesloc/main.dart';
import 'package:homesloc/screens/calendar_screen/calendar_screen.dart';
import 'package:homesloc/screens/categorie_screen/categorie_screen.dart';
import 'package:homesloc/screens/categorie_screen/categorie_view/categorie_view.dart';
import 'package:homesloc/screens/home/widget/guest_dialog.dart';
import 'package:homesloc/screens/home/widget/search_button.dart';
import 'package:homesloc/screens/search_screen/search_screen.dart';
import 'package:homesloc/core/controller/bottom_navigation_bar/new_navigation.dart';
import 'package:homesloc/core/widgets/builder/home_builder/first_home_builder.dart';
import 'package:homesloc/core/widgets/builder/home_builder/fourth_home_builder.dart';
import 'package:homesloc/core/widgets/builder/home_builder/second_home_builder.dart';
import 'package:homesloc/core/widgets/builder/home_builder/third_home_builder.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/logo.dart/logo.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/core/widgets/search_form/search_form.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:homesloc/screens/home/widget/hero_section.dart';

import '../../controller/calender_controller.dart';
import '../../controller/home/home_screen_controller.dart';
import '../../controller/search/search_hotel_controller.dart';
import '../../core/controller/bottom_navigation_bar/bottom_bar_controller.dart';

// HomeScreen implementation below

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final calendarController = Get.put(CalendarController());
  final TextEditingController locationController = TextEditingController();
  final screenController = Get.put(HomeScreenController());
  final bottomBarController = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: blue,
            elevation: 0,
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
                //  SizedBox(height: 5.h),
                const HeroSection(),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20.h,
                          // bottom: 10.h,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              // color: black,
                              height: 105.h,
                              width: MediaQuery.of(context).size.width,
                              child: FirstHomeBuilder(),
                            ),
                          ],
                        ),
                      ),
                      HomeDivider(),
                      NameView(
                        name: 'Best tour packages',
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
                          child: SecondHomeBuilder(),
                        ),
                      ),
                      HomeDivider(),
                      NameView(
                        name: 'Best wedding deals',
                        color: black,
                        secondName: 'View All',
                        secondColor: black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 195.h,
                        // color: yellow,
                        child: ThirdHomeBuilder(),
                      ),
                      HomeDivider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Get.toNamed('/categorie');
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) {
                                //       return CategorieView();
                                //     }));
                              },
                              child: Container(
                                width: 38.w,
                                height: 33.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  color: gwhite,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/Vector (3).png'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          FourthHomeBuilder(),
        ],
      ),
    );
  }

  // Add this function to your HomeScreen class
  void _showCalendarBottomSheet(BuildContext context) {
    final calendarController = Get.put(CalendarController());
    final ScrollController calenderScroll = ScrollController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: scaffoldColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),

            // Calendar title
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                "Select Dates",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: blue,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Only the calendar is scrollable
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ScrollableCleanCalendar(
                  daySelectedBackgroundColor: yellow,
                  daySelectedBackgroundColorBetween: blue.withOpacity(0.1),
                  dayTextStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    color: black,
                  ),
                  monthTextStyle: TextStyle(
                    color: blue,
                    fontFamily: 'Poppins',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  weekdayTextStyle: TextStyle(
                    color: fontColor,
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  scrollController: calenderScroll,
                  calendarController: calendarController.calendarController,
                  layout: Layout.BEAUTY,
                  calendarCrossAxisSpacing: 0,
                ),
              ),
            ),

            // Date display section
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.05),
                    offset: const Offset(0, -5),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Check-in date card
                      Expanded(
                        child: Obx(() => _buildDateCard(
                              title: "CHECK-IN",
                              date: calendarController.checkInDate.value != null
                                  ? calendarController.formatDate(
                                      calendarController.checkInDate.value)
                                  : "Select Date",
                              isSelected:
                                  calendarController.checkInDate.value != null,
                            )),
                      ),

                      // Total days indicator
                      Obx(() => Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: yellow.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              "${calendarController.totalDays.value} Days",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: blue,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),

                      // Check-out date card
                      Expanded(
                        child: Obx(() => _buildDateCard(
                              title: "CHECK-OUT",
                              date:
                                  calendarController.checkOutDate.value != null
                                      ? calendarController.formatDate(
                                          calendarController.checkOutDate.value)
                                      : "Select Date",
                              isSelected:
                                  calendarController.checkOutDate.value != null,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Apply button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(15.sp),
                      child: Ink(
                        width: double.infinity,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.circular(15.sp),
                          boxShadow: [
                            BoxShadow(
                              color: blue.withOpacity(0.3),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Confirm & Continue",
                            style: TextStyle(
                              color: white,
                              fontSize: 16.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateCard(
      {required String title, required String date, required bool isSelected}) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: scaffoldColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected ? blue.withOpacity(0.2) : border.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              fontFamily: "Poppins",
              color: fontColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            date,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: "Poppins",
              color: blue,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
