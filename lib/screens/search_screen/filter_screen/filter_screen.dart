import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/filter_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/controller/search/search_hotel_controller.dart';

class FilterSearchScreen extends StatelessWidget {
  const FilterSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Filters',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (Get.find<SearchHotelController>().isTourism.value ||
                          Get.find<SearchHotelController>()
                              .isAdventureTourism
                              .value) ...[
                        _buildTourismSection(controller),
                        const Divider(),
                      ] else ...[
                        _buildAmenitiesSection(controller),
                        const Divider(),
                        if (Get.find<SearchHotelController>()
                            .isFreshup
                            .value) ...[
                          _buildFreshupSection(controller),
                          const Divider(),
                        ] else if (Get.find<SearchHotelController>()
                            .isGroupedByHall
                            .value) ...[
                          _buildBanquetHallSection(controller),
                          const Divider(),
                        ] else ...[
                          _buildStarRatingSection(controller),
                          const Divider(),
                          _buildRadioSection(
                            'Accommodation Type',
                            ['Full Property', 'Room Wise'],
                            controller.accommodationType,
                            controller.setAccommodationType,
                          ),
                          const Divider(),
                          _buildRadioSection(
                            'Property Type',
                            ['Hotel', 'Apartment', 'Homestay', 'Houseboat'],
                            controller.selectedPropertyType,
                            controller.setPropertyType,
                          ),
                          const Divider(),
                          _buildRadioSection(
                            'Room Type',
                            ['Standard', 'Deluxe', 'Suite', 'Executive'],
                            controller.roomType,
                            controller.setRoomType,
                          ),
                        ],
                        SizedBox(height: 20.h),
                      ],
                    ],
                  ),
                ),
              ),
              _buildBottomButtons(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmenitiesSection(FilterController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amenities',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Select amenities for your stay',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 10.h),
        Obx(() {
          final keys = controller.displayedAmenities;
          return Column(
            children: keys.map((amenity) {
              return _buildCheckboxRow(
                amenity,
                controller.amenities[amenity]!,
                (val) => controller.toggleFilter('Amenities', amenity),
              );
            }).toList(),
          );
        }),
        Obx(() => TextButton(
              onPressed: () => controller.toggleShowAllAmenities(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.showAllAmenities.value
                        ? 'Show less'
                        : 'Show all',
                    style: TextStyle(color: blue),
                  ),
                  Icon(
                    controller.showAllAmenities.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: blue,
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildStarRatingSection(FilterController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text(
          'Star Rating',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Obx(() => Column(
              children: [5, 4, 3, 2, 1].map((rating) {
                return Row(
                  children: [
                    Radio<int>(
                      value: rating,
                      groupValue: controller.starRating.value,
                      onChanged: (val) => controller.setStarRating(val!),
                      activeColor: blue,
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          color:
                              index < rating ? Colors.amber : Colors.grey[300],
                          size: 20.sp,
                        );
                      }),
                    ),
                  ],
                );
              }).toList(),
            )),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildFreshupSection(FilterController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text(
          'Freshup Type',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Obx(() => Column(
              children: controller.freshupType.keys.map((type) {
                return _buildCheckboxRow(
                  type,
                  controller.freshupType[type]!,
                  (val) => controller.toggleFilter('FreshupType', type),
                );
              }).toList(),
            )),
        SizedBox(height: 20.h),
        const Divider(),
        SizedBox(height: 10.h),
        Text(
          'Price Method',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Obx(() => Column(
              children: controller.priceMethod.keys.map((method) {
                return _buildCheckboxRow(
                  method,
                  controller.priceMethod[method]!,
                  (val) => controller.toggleFilter('PriceMethod', method),
                );
              }).toList(),
            )),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildBanquetHallSection(FilterController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text(
          'Venue Type',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Obx(() {
          final keys = controller.displayedVenueTypes;
          return Column(
            children: keys.map((type) {
              return _buildCheckboxRow(
                type,
                controller.venueType[type]!,
                (val) => controller.toggleFilter('VenueType', type),
              );
            }).toList(),
          );
        }),
        Obx(() => TextButton(
              onPressed: () => controller.toggleShowAllVenueTypes(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.showAllVenueTypes.value
                        ? 'Show less'
                        : 'Show all',
                    style: TextStyle(color: blue),
                  ),
                  Icon(
                    controller.showAllVenueTypes.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: blue,
                  ),
                ],
              ),
            )),
        SizedBox(height: 20.h),
        const Divider(),
        SizedBox(height: 10.h),
        Text(
          'Space Type',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Obx(() => Column(
              children: controller.spaceType.keys.map((type) {
                return _buildCheckboxRow(
                  type,
                  controller.spaceType[type]!,
                  (val) => controller.toggleFilter('SpaceType', type),
                );
              }).toList(),
            )),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildTourismSection(FilterController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text(
          'Package Type',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Obx(() => Column(
              children: controller.packageType.keys.map((type) {
                return _buildCheckboxRow(
                  type,
                  controller.packageType[type]!,
                  (val) => controller.toggleFilter('PackageType', type),
                );
              }).toList(),
            )),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildCheckboxRow(
      String label, bool value, Function(bool?) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildRadioSection(String title, List<String> options,
      RxnString selectedValue, Function(String) onSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Obx(() => Column(
              children: options.map((option) {
                return Row(
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: selectedValue.value,
                      onChanged: (val) => onSelected(val!),
                      activeColor: blue,
                    ),
                    Text(
                      option,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                );
              }).toList(),
            )),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildBottomButtons(FilterController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        children: [
          OutlinedButton(
            onPressed: () => controller.clearAllFilters(),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 45.h),
              side: BorderSide(color: blue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Reset All Filters',
              style: TextStyle(
                color: blue,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: () {
              // Apply filters
              Get.find<SearchHotelController>().searchHotels();
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: blue,
              minimumSize: Size(double.infinity, 45.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Apply Filters',
              style: TextStyle(
                color: white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
