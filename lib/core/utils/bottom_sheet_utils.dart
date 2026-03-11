import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/screens/home/widget/guest_dialog.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

class BottomSheetUtils {
  static void showCalendarBottomSheet(BuildContext context) {
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

  static void showGuestBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12.h, bottom: 20.h),
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: BookingDialog(),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  static Widget _buildDateCard(
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

  static Future<void> showSingleDatePicker(BuildContext context) async {
    final calendarController = Get.put(CalendarController());
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    DateTime initDate = calendarController.checkInDate.value ?? today;
    if (initDate.isBefore(today)) {
      initDate = today;
    }

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: today,
      lastDate: today.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: blue,
              onPrimary: white,
              onSurface: black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: blue),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      calendarController.checkInDate.value = selectedDate;
      calendarController.checkOutDate.value = selectedDate;
      calendarController.totalDays.value = 1;
    }
  }
}
