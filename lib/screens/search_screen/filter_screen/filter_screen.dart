import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/filter_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/search_screen/filter_screen/widget/widget_budget_section.dart';
import 'package:homesloc/screens/search_screen/filter_screen/widget/widget_header.dart';
import 'package:homesloc/screens/search_screen/filter_screen/widget/widget_popular_filter.dart';
import 'package:homesloc/screens/search_screen/filter_screen/widget/widget_selected_filter.dart';

class FilterSearchScreen extends StatelessWidget {
  const FilterSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FilterController());

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),
                SizedBox(height: 10.h),
                buildSelectedFilters(controller),
                SizedBox(height: 20.h),
                buildSectionWithToggle(
                    'Popular Filters', controller.popularFilters, controller),
                SizedBox(height: 20.h),
                buildSectionWithToggle(
                    'Facilities', controller.facilities, controller),
                SizedBox(height: 20.h),
                buildBudgetSection(controller),
                SizedBox(height: 20.h),
                buildSectionWithToggle(
                    'Room Facilities', controller.roomFacilities, controller),
                SizedBox(height: 20.h),
                buildSectionWithToggle(
                    'Property Type', controller.propertyType, controller),
                SizedBox(height: 20.h),
                buildSectionWithToggle('Meals', controller.meals, controller),
                SizedBox(height: 20.h),
                buildSectionWithToggle('Rating', controller.rating, controller),
                SizedBox(height: 20.h),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Back to search functionality
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: grey,
                      foregroundColor: blue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 12.h),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 18.sp,
                          color: black,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Back to search',
                          style: TextStyle(
                            color: black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
