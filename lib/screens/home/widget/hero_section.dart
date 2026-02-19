import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/core/utils/bottom_sheet_utils.dart';
import 'package:homesloc/core/widgets/search_form/search_form.dart';
import 'package:homesloc/screens/home/widget/guest_dialog.dart';
import 'package:homesloc/screens/home/widget/search_button.dart';
import 'package:homesloc/controller/search/search_hotel_controller.dart';
import 'package:homesloc/core/controller/bottom_navigation_bar/bottom_bar_controller.dart';
import 'package:homesloc/animations/animated_content.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onCalendarTap;
  const HeroSection({super.key, this.onCalendarTap});

  @override
  Widget build(BuildContext context) {
    final calendarController = Get.put(CalendarController());
    final searchHotelController = Get.put(SearchHotelController());
    final bottomBarController = Get.put(BottomBarController());

    return Column(
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
                        BottomSheetUtils.showCalendarBottomSheet(context);
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
                                    ? calendarController.formatDateShort(
                                        calendarController.checkInDate.value)
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
                                    ? calendarController.formatDateShort(
                                        calendarController.checkOutDate.value)
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/Vector (1).png'),
                            width: 16.w,
                            height: 16.h,
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Obx(() => Text(
                                "${searchHotelController.guestCountVal} Guests",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: poppinsFont,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w100,
                                ),
                              )),
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
                    if (calendarController.checkInDate.value == null ||
                        calendarController.checkOutDate.value == null) {
                      Get.snackbar(
                        "Dates Required",
                        "please select the dates",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: blue.withOpacity(0.8),
                        colorText: white,
                        margin: EdgeInsets.all(15.r),
                        borderRadius: 10.r,
                      );
                      return;
                    }
                    bottomBarController
                        .updateSelectedPageIndex(1); // Switch to Search Screen
                    searchHotelController.searchHotels();
                  },
                  child: SearchButton())),
        ),
      ],
    );
  }
}
