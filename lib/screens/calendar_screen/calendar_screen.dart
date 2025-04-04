// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/calender_row/calender_first_row.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

import '../../controller/calender_controller.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  ScrollController calenderScroll = ScrollController();
  final calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: scaffoldColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.sp,
            color: blue,
          ),
          onPressed: () => Get.back(),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 60.w),
          child: Text(
            "Calendar",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: blue,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
                width: screenWidth, height: 100.h, child: CalenderFirstRow()),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(20),
                ),
                constraints: BoxConstraints(maxHeight: 380.h),
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
            SizedBox(height: 20.h),
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
                              ? calendarController.formatDate(calendarController.checkInDate.value)
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
                              ? calendarController.formatDate(calendarController.checkOutDate.value)
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
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
              child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Container(
                  width: screenWidth - 50,
                  height: 43.h,
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(28.sp),
                  ),
                  child: Center(
                    child: Text(
                      "Done",
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