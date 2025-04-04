import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

class CalendarBottomSheet extends StatelessWidget {
  const CalendarBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarController = Get.find<CalendarController>();
    final ScrollController calenderScroll = ScrollController();

    return Container(
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

          // Only the calendar is scrollable
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: blue),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ScrollableCleanCalendar(
                  daySelectedBackgroundColor: yellow,
                  daySelectedBackgroundColorBetween: grey,
                  monthTextStyle: TextStyle(
                    color: blue,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold
                  ),
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
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        calendarController.checkInDate.value != null
                            ? calendarController.formatDate(
                                calendarController.checkInDate.value)
                            : "Select Date",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  ),
                )),

                // Total days display
                Obx(() => Container(
                  padding: EdgeInsets.only(
                    left: 5.w, right: 5.w, top: 5.h, bottom: 5.h
                  ),
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
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        "Days",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500
                        ),
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
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        calendarController.checkOutDate.value != null
                            ? calendarController.formatDate(
                                calendarController.checkOutDate.value)
                            : "Select Date",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500
                        ),
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
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 