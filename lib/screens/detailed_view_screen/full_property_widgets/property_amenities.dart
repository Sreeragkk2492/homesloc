import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/controller/search/search_hotel_full_properties_controller.dart';
import 'package:homesloc/controller/search/search_hotel_room_details_controller.dart';

class PropertyAmenities extends StatefulWidget {
  final dynamic hotel;
  
  const PropertyAmenities({Key? key, this.hotel}) : super(key: key);

  @override
  State<PropertyAmenities> createState() => _PropertyAmenitiesState();
}

class _PropertyAmenitiesState extends State<PropertyAmenities> {
  bool isExpanded = false;

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Try to get controllers
      final fullPropertyController = Get.find<SearchHotelFullPropertiesController>();
      final roomDetailsController = Get.find<SearchHotelRoomDetailsController>();
      
      List<String> amenities = [];
      
      // Try to get amenities from full property details first
      final fullPropertyDetails = fullPropertyController.fullPropertyDetails.value;
      final fullPropertyHotelDetails = fullPropertyDetails?.hotelDetails;
      if (fullPropertyHotelDetails?.amenities != null) {
        amenities = fullPropertyHotelDetails!.amenities!.map((amenity) => amenity.name ?? '').where((name) => name.isNotEmpty).toList();
      }
      // Try to get amenities from room details if full property amenities are not available
      else {
        final roomDetails = roomDetailsController.roomDetails.value;
        final roomDetailsHotelDetails = roomDetails?.hotelDetails;
        if (roomDetailsHotelDetails?.amenities != null) {
          amenities = roomDetailsHotelDetails!.amenities!.map((amenity) => amenity.name ?? '').where((name) => name.isNotEmpty).toList();
        }
        // Fallback to accommodation amenities if detailed amenities are not available
        else if (widget.hotel?.amenities != null) {
          amenities = widget.hotel.amenities.map((amenity) => amenity.name ?? '').where((name) => name.isNotEmpty).toList();
        }
      }
      
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