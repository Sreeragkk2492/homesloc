import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/controller/search/search_hotel_full_properties_controller.dart';

class PropertyAmenities extends StatefulWidget {
  const PropertyAmenities({Key? key}) : super(key: key);

  @override
  State<PropertyAmenities> createState() => _PropertyAmenitiesState();
}

class _PropertyAmenitiesState extends State<PropertyAmenities> {
  bool isExpanded = false;
  final fullPropertyController = Get.find<SearchHotelFullPropertiesController>();

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final amenities = fullPropertyController.getAmenities();
      
      if (amenities.isEmpty) {
        return const SizedBox.shrink();
      }

      final displayedAmenities = isExpanded ? amenities : amenities.take(4).toList();

      return Column(
        children: [
          NameView(
            name: 'Amenities',
            color: blue,
            secondName: isExpanded ? 'Show Less' : 'View All',
            secondColor: blue,
            onTap: toggleExpanded,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
            child: Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: displayedAmenities.map((amenity) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: gwhite,
                    borderRadius: BorderRadius.circular(4.sp),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: AssetImage('assets/images/Frame (20).png'),
                        width: 11.w,
                        height: 11.h,
                        color: black,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        amenity,
                        style: TextStyle(
                          color: black,
                          fontFamily: 'Poppins',
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      );
    });
  }
} 