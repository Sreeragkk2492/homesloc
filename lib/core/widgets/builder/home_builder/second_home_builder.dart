// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/home/home_screen_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/loader/app_loader.dart';
import 'package:homesloc/screens/detailed_view_screen/tourism_detailed_view_screen.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:intl/intl.dart';

class SecondHomeBuilder extends StatelessWidget {
  SecondHomeBuilder({super.key});

  final HomeScreenController screenController =
      Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (screenController.isLoading.value) {
        return const Center(child: AppLoader(size: 40));
      }

      final tourPackages = screenController.tourPackages;
      if (tourPackages.isEmpty) {
        return const SizedBox.shrink();
      }

      return ListView.builder(
        itemCount: tourPackages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final package = tourPackages[index];
          final calendarController = Get.find<CalendarController>();

          return Padding(
            padding: EdgeInsets.only(left: 10.w, right: 9.w, top: 5.h),
            child: GestureDetector(
              onTap: () {
                if (package.id != null) {
                  Get.to(() => TourismDetailedViewScreen(
                        packageId: package.id!,
                        startDate: calendarController.checkInDate.value != null
                            ? DateFormat('yyyy-MM-dd')
                                .format(calendarController.checkInDate.value!)
                            : null,
                        endDate: calendarController.checkOutDate.value != null
                            ? DateFormat('yyyy-MM-dd')
                                .format(calendarController.checkOutDate.value!)
                            : null,
                      ));
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 170.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: (package.imageUrl != null &&
                                  package.imageUrl!.isNotEmpty)
                              ? NetworkImage(package.imageUrl!) as ImageProvider
                              : const AssetImage(
                                  'assets/images/34242665a695e6c15c2a531723032576.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  SizedBox(
                    width: 170.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            package.title ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: blue,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        CircleAvatar(
                          backgroundColor: yellow,
                          radius: 18.sp,
                          child: Icon(
                            Icons.arrow_outward_outlined,
                            color: white,
                            size: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
