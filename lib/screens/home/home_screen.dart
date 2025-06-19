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
import 'package:homesloc/screens/home/widget/calendar_bottom_sheet.dart';
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

import '../../controller/calender_controller.dart';
import '../../controller/home/home_screen_controller.dart';
import '../../core/controller/bottom_navigation_bar/bottom_bar_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final calendarController = Get.put(CalendarController());
  final TextEditingController locationController = TextEditingController();
  final screenController = Get.put(HomeScreenController());
  final bottomBarController = Get.put(BottomBarController());
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _firstDay = DateTime.now();
    _lastDay = DateTime.now().add(const Duration(days: 365));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: blue,
            automaticallyImplyLeading: false,
            pinned:
            false,
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
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
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image(
                                          image: AssetImage('assets/images/Vector.png'),
                                          width: 15.w,
                                          height: 15.h,
                                        ),
                                        Text(
                                          calendarController.checkInDate.value != null
                                              ? calendarController.formatDateShort(calendarController.checkInDate.value)
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
                                          calendarController.checkOutDate.value != null
                                              ? calendarController.formatDateShort(calendarController.checkOutDate.value)
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
                                    builder: (context) =>
                                        Dialog(
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        color: blue,
                        child: Padding(
                            padding: EdgeInsets.only(left: 14.w, bottom: 9.h),
                            child: GestureDetector(
                              onTap: (){
                                // Only proceed if location is entered

                                  // Set search data in controller
                                  screenController.setSearchData(
                                    locationValue: locationController.text,
                                    checkIn: calendarController.checkInDate.value,
                                    checkOut: calendarController.checkOutDate.value,
                                    guests: 2, // Default or get from your guest dialog
                                    rooms: 1, // Default or get from your guest dialog
                                  );

                                  // Navigate to search tab
                                  bottomBarController.updateSelectedPageIndex(0);

                              },
                                child: SearchButton())
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20.h,
                          // bottom: 10.h,
                        ),

                        child: Row(
                          children: [
                            AnimatedContent(
                              leftToRight: 0.0,
                              time: 1500,
                              topToBottom: 5.0,
                              show: true,
                              child: SizedBox(
                                // color: black,
                                height: 105.h,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: FirstHomeBuilder(),
                              ),
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
                        name: 'Best booking deals',
                        color: black,
                        secondName: 'View All',
                        secondColor: black,
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
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
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return CategorieView();
                                    }));
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
  // void _showCalendarBottomSheet(BuildContext context) {
  //   final calendarController = Get.put(CalendarController());
  //   final ScrollController calenderScroll = ScrollController();

  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     isScrollControlled: true,
  //     builder: (context) =>
  //         Container(
  //           height: MediaQuery
  //               .of(context)
  //               .size
  //               .height * 0.75,
  //           decoration: BoxDecoration(
  //             color: scaffoldColor,
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(20.r),
  //               topRight: Radius.circular(20.r),
  //             ),
  //           ),
  //           child: Column(
  //             children: [
  //               // Handle bar at top of bottom sheet
  //               Container(
  //                 margin: EdgeInsets.only(top: 10.h),
  //                 width: 40.w,
  //                 height: 5.h,
  //                 decoration: BoxDecoration(
  //                 //  color: grey,
  //                   borderRadius: BorderRadius.circular(10.r),
  //                 ),
  //               ),

   //               // Calendar title
  //               Padding(
  //                 padding: EdgeInsets.symmetric(vertical: 15.h),
  //                 child: Text(
  //                   "Calendar",
  //                   style: TextStyle(
  //                     fontFamily: 'Poppins',
  //                     color: blue,
  //                     fontSize: 18.sp,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),

  //               // Calendar first row - fixed
  //               // Container(
  //               //     width: MediaQuery
  //               //         .of(context)
  //               //         .size
  //               //         .width,
  //               //     height: 100.h,
  //               //     child: CalenderFirstRow()
  //               // ),

  //               // Only the calendar is scrollable
  //                Expanded(
  //           child: Padding(
  //             padding: EdgeInsets.all(8.r),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 border: Border.all(color: blue),
  //                 borderRadius: BorderRadius.circular(20),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.grey.withOpacity(0.1),
  //                     spreadRadius: 1,
  //                     blurRadius: 10,
  //                     offset: const Offset(0, 2),
  //                   ),
  //                 ],
  //               ),
  //               child: CustomCalendar(
  //                 focusedDay: _focusedDay,
  //                 firstDay: _firstDay,
  //                 lastDay: _lastDay,
  //                 selectedDay: _selectedDay,
  //                 onDaySelected: (selectedDay, focusedDay) {
  //                   setState(() {
  //                     _selectedDay = selectedDay;
  //                     _focusedDay = focusedDay;
  //                   });
  //                   calendarController.handleDayTapped(selectedDay);
  //                 },
  //                 onPageChanged: (focusedDay) {
  //                   setState(() {
  //                     _focusedDay = focusedDay;
  //                   });
  //                 },
  //               ),
  //             ),
  //           ),
  //         ),

  //               // Date display section - fixed
  //               Padding(
  //                 padding: EdgeInsets.only(top: 15.h),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     // Check-in date display
  //                     Obx(() =>
  //                         Container(
  //                           padding: EdgeInsets.all(8.r),
  //                           decoration: BoxDecoration(
  //                             color: white,
  //                             borderRadius: BorderRadius.circular(10.r),
  //                             border: Border.all(color: blue),
  //                           ),
  //                           child: Column(
  //                             children: [
  //                               Text(
  //                                 "Check-In-Date",
  //                                 style: TextStyle(
  //                                     fontSize: 14.sp,
  //                                     fontFamily: "Poppins",
  //                                     fontWeight: FontWeight.w500
  //                                 ),
  //                               ),
  //                               Text(
  //                                 calendarController.checkInDate.value != null
  //                                     ? calendarController.formatDate(
  //                                     calendarController.checkInDate.value)
  //                                     : "Select Date",
  //                                 style: TextStyle(
  //                                     fontSize: 12.sp,
  //                                     fontFamily: "Poppins",
  //                                     fontWeight: FontWeight.w500
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                         )),

  //                     // Total days display
  //                     Obx(() =>
  //                         Container(
  //                           padding: EdgeInsets.only(
  //                               left: 5.w, right: 5.w, top: 5.h, bottom: 5.h
  //                           ),
  //                           decoration: BoxDecoration(
  //                             color: grey,
  //                             borderRadius: BorderRadius.circular(10.r),
  //                             border: Border.all(color: blue),
  //                           ),
  //                           child: Column(
  //                             children: [
  //                               Text(
  //                                 "${calendarController.totalDays.value}",
  //                                 style: TextStyle(
  //                                     fontSize: 14.sp,
  //                                     fontFamily: "Poppins",
  //                                     fontWeight: FontWeight.w500
  //                                 ),
  //                               ),
  //                               Text(
  //                                 "Days",
  //                                 style: TextStyle(
  //                                     fontSize: 12.sp,
  //                                     fontFamily: "Poppins",
  //                                     fontWeight: FontWeight.w500
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                         )),

  //                     // Check-out date display
  //                     Obx(() =>
  //                         Container(
  //                           padding: EdgeInsets.all(8.r),
  //                           decoration: BoxDecoration(
  //                             color: white,
  //                             borderRadius: BorderRadius.circular(10.r),
  //                             border: Border.all(color: blue),
  //                           ),
  //                           child: Column(
  //                             children: [
  //                               Text(
  //                                 "Check-Out-Date",
  //                                 style: TextStyle(
  //                                     fontSize: 14.sp,
  //                                     fontFamily: "Poppins",
  //                                     fontWeight: FontWeight.w500
  //                                 ),
  //                               ),
  //                               Text(
  //                                 calendarController.checkOutDate.value != null
  //                                     ? calendarController.formatDate(
  //                                     calendarController.checkOutDate.value)
  //                                     : "Select Date",
  //                                 style: TextStyle(
  //                                     fontSize: 12.sp,
  //                                     fontFamily: "Poppins",
  //                                     fontWeight: FontWeight.w500
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                         )),
  //                   ],
  //                 ),
  //               ),

  //               // Done button - fixed at bottom
  //               Padding(
  //                 padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
  //                 child: TextButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Container(
  //                     width: MediaQuery
  //                         .of(context)
  //                         .size
  //                         .width - 50,
  //                     height: 43.h,
  //                     decoration: BoxDecoration(
  //                       color: yellow,
  //                       borderRadius: BorderRadius.circular(28.sp),
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         "Apply",
  //                         style: TextStyle(
  //                             color: black,
  //                             fontSize: 16.sp,
  //                             fontFamily: 'Poppins',
  //                             fontWeight: FontWeight.w500
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //   );
  // }
}
