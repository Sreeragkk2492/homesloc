// ignore_for_file: file_names, avoid_print, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/search_hotel_full_properties_controller.dart';
import 'package:homesloc/controller/search/search_hotel_room_details_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/detailed_view_screen/amenitie_row/amenitie_row.dart';
import 'package:homesloc/screens/detailed_view_screen/full_property_widgets/property_maps.dart';
import 'package:homesloc/screens/detailed_view_screen/property_row/property_first_row.dart';
import 'package:homesloc/screens/detailed_view_screen/property_row/property_second_row.dart';
import 'package:homesloc/screens/detailed_view_screen/property_row/property_third_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_first_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_second_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_third_row.dart';
import 'package:homesloc/screens/detailed_view_screen/transportation_row/transportations_first_row.dart';
import 'package:homesloc/screens/detailed_view_screen/transportation_row/transportations_second_row.dart';
import 'package:homesloc/core/widgets/yellow_star/yellow_star.dart';
import 'package:homesloc/core/widgets/book_now/book_now.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/first_detailed_view_builder.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/second_detailed_view_builder.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/screens/detailed_view_screen/hotel_policies_row/hotel_policies_row.dart';

// Import the new widget components
import 'package:homesloc/screens/detailed_view_screen/full_property_widgets/property_header.dart';
import 'package:homesloc/screens/detailed_view_screen/full_property_widgets/property_location.dart';
import 'package:homesloc/screens/detailed_view_screen/full_property_widgets/property_route.dart';
import 'package:homesloc/screens/detailed_view_screen/full_property_widgets/property_rating.dart';
import 'package:homesloc/screens/detailed_view_screen/full_property_widgets/property_description.dart';
import 'package:homesloc/screens/detailed_view_screen/full_property_widgets/full_property_book_now.dart';
import 'package:homesloc/screens/detailed_view_screen/full_property_widgets/property_policies.dart';
import 'package:homesloc/screens/detailed_view_screen/full_property_widgets/property_amenities.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/full_property_first_detailed_view_builder.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/room_details_first_detailed_view_builder.dart';
import 'package:lottie/lottie.dart';

class FullPropertyDetailedViewScreen extends StatelessWidget {
  final dynamic hotel;
  final String? startDate;
  final String? endDate;

  const FullPropertyDetailedViewScreen({
    super.key,
    this.hotel,
    this.startDate,
    this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize both controllers
    final fullPropertyController =
        Get.put(SearchHotelFullPropertiesController());
    final roomDetailsController = Get.put(SearchHotelRoomDetailsController());

    // Detect ROOM type
    final isRoomType = hotel?.accommodationType == 'ROOM';

    // Fetch room details if ROOM type
    if (isRoomType && hotel != null && startDate != null && endDate != null) {
      roomDetailsController.fetchRoomDetails(
        roomId: hotel.id,
        startDate: startDate!,
        endDate: endDate!,
      );
    }

    // Fetch full property details when hotel is selected and dates are provided
    if (!isRoomType && hotel != null && startDate != null && endDate != null) {
      fullPropertyController.fetchFullPropertyDetails(
        propertyId: hotel.id,
        startDate: startDate!,
        endDate: endDate!,
      );
    }

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.sp,
            color: blue,
          ),
          onPressed: () {
            fullPropertyController.clearFullPropertyDetails();
            roomDetailsController.clearRoomDetails();
            Get.back();
          },
        ),
        title: Center(
          child: Text(
            hotel?.name ?? "Property Details",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: blue,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('favorite button');
            },
            icon: Icon(
              Icons.favorite_outline_rounded,
              color: blue,
              size: 25.sp,
            ),
          ),
        ],
      ),
      body: isRoomType
          ? Obx(() {
              if (roomDetailsController.isLoading.value) {
                return Center(
                    child: Container(
                  width: 50.w,
                  height: 50.h,
                  child: Lottie.asset(
                    'assets/images/loading.json',
                    repeat: true,
                  ),
                ));
              }
              if (roomDetailsController.errorMessage.value.isNotEmpty) {
                return Center(
                    child: Text(roomDetailsController.errorMessage.value));
              }
              final hotelDetails =
                  roomDetailsController.roomDetails.value?.hotelDetails;
              final rooms = hotelDetails?.rooms ?? [];
              if (rooms.isEmpty) return SizedBox();

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Property Cover Image
                    Container(
                      height: 200.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(hotelDetails?.coverImageUrl ??
                              'assets/images/image (33).png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Base Property Price and Hotel Type
                    Container(
                      padding: EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Property Name
                          Text(
                            hotelDetails?.name ?? "Property",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),

                          // Hotel Type
                          Text(
                            hotelDetails?.hotelType ?? "Property Type",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: fontColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 5.h),

                          // Base Property Price
                          Text(
                            "₹${roomDetailsController.roomDetails.value?.price ?? '0'}",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 98.h,
                      child: RoomDetailsFirstDetailedViewBuilder(
                          roomDetails: roomDetailsController.roomDetails.value),
                    ),

                    // Property Location Section
                    PropertyLocation(hotel: hotelDetails),

                    SizedBox(height: 15.h),

                    // Use the custom FullPropertyBookNow widget
                     FullPropertyBookNow(
                      startDate:startDate ?? '',
                      endDate:endDate ?? '',
                    ),

                    // Property Rating Section
                    const PropertyRating(),

                    SizedBox(height: 5.h),

                    HomeDivider(),

                    // Use the new PropertyAmenities widget for full properties
                    PropertyAmenities(hotel: hotel),

                    HomeDivider(),

                    // Choose your room section
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Text(
                        'Choose your room',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    Obx(() => Column(
                          children: List.generate(rooms.length, (index) {
                            final room = rooms[index];
                            final isSelected = fullPropertyController
                                    .selectedRoomIndex.value ==
                                index;
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 10.w, right: 10.w, bottom: 15.h),
                              padding: EdgeInsets.all(15.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.sp),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // First line: Room name
                                  Row(
                                    children: [
                                      Text(
                                        (room.roomName ?? '').toUpperCase(),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      SizedBox(width: 6.w),
                                      Icon(Icons.check_circle,
                                          color: Colors.green, size: 18.sp),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  // Second line: room size and price left, image right
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Room size and price (left)
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              room.roomSize != null
                                                  ? '${room.roomSize} sq ft'
                                                  : '',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: fontColor,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            if (room.price != null) ...[
                                              SizedBox(height: 4.h),
                                              Text(
                                                '₹${room.price}',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: black,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                            if (room.offerPrice != null &&
                                                room.offerPrice !=
                                                    room.price) ...[
                                              SizedBox(height: 2.h),
                                              Text(
                                                '₹${room.offerPrice}',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.green,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      // Room image (right)
                                      if (room.roomImages != null &&
                                          room.roomImages!.isNotEmpty)
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6.sp),
                                          child: Image.network(
                                            room.roomImages![0],
                                            width: 110.w,
                                            height: 80.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 16.h),
                                  // Third line: Centered SELECTED button
                                  Center(
                                    child: SizedBox(
                                      width: 140.w,
                                      child: ElevatedButton(
                                        onPressed: () => fullPropertyController
                                            .selectedRoomIndex.value = index,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: isSelected
                                              ? Colors.green
                                              : Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.sp),
                                          ),
                                          minimumSize: Size(100.w, 40.h),
                                        ),
                                        child: Text(
                                          isSelected ? 'SELECTED' : 'SELECT',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        )),

                    // Property Description Section
                    PropertyDescription(
                        coverImageUrl: hotelDetails?.coverImageUrl),

                    HomeDivider(),

                    // Replace the HotelPoliciesRow with our new PropertyPolicies widget
                    const PropertyPolicies(),
                    SizedBox(height: 30.h),
                    // Extract lat/lng from hotelDetails
                    if (hotelDetails?.latitude != null &&
                        hotelDetails?.longitude != null) ...[
                      PropertyMapSection(
                        latitude: double.tryParse(hotelDetails?.latitude ?? '') ?? 0.0,
                        longitude: double.tryParse(hotelDetails?.longitude ?? '') ?? 0.0,
                        propertyName: hotelDetails?.name ?? '',
                      ),
                    ],
                  ],
                ),
              );
            })
          : Obx(() {
              if (fullPropertyController.isLoading.value) {
                return Center(
                    child: Container(
                  width: 50.w,
                  height: 50.h,
                  child: Lottie.asset(
                    'assets/images/loading.json',
                    repeat: true,
                  ),
                ));
              }

              if (fullPropertyController.errorMessage.value.isNotEmpty) {
                return Center(
                    child: Text(fullPropertyController.errorMessage.value));
              }

              // Use the fetched full property details if available, otherwise fall back to accommodation data
              // final hotelDetails = fullPropertyController.fullPropertyDetails.value?.hotelDetails;
              //  final displayHotel = hotelDetails ?? hotel;

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Property Cover Image
                    Container(
                      height: 200.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(fullPropertyController
                                  .fullPropertyDetails
                                  .value
                                  ?.hotelDetails
                                  ?.coverImageUrl ??
                              'assets/images/image (33).png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Base Property Price and Hotel Type
                    Container(
                      padding: EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Property Name
                          Text(
                            fullPropertyController.fullPropertyDetails.value
                                    ?.hotelDetails?.name ??
                                "Property",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),

                          // Hotel Type
                          Text(
                            fullPropertyController.fullPropertyDetails.value!
                                    .hotelDetails!.hotelType ??
                                "Property Type",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: fontColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 5.h),

                          // Base Property Price
                          Text(
                            "₹${fullPropertyController.fullPropertyDetails.value?.basePropertyPrice ?? '0'}",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 5.h),

                          // Property Description
                          // if (fullPropertyController.fullPropertyDetails.value?.hotelDetails?.description != null)
                          //   Text(
                          //     fullPropertyController.fullPropertyDetails.value?.hotelDetails?.description ?? "",
                          //     style: TextStyle(
                          //       fontFamily: 'Poppins',
                          //       color: black,
                          //       fontSize: 14.sp,
                          //     ),
                          //   ),

                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 98.h,
                      child: FullPropertyFirstDetailedViewBuilder(
                          hotel:
                              fullPropertyController.fullPropertyDetails.value),
                    ),

                    // Property Location Section
                    PropertyLocation(
                        hotel: fullPropertyController
                            .fullPropertyDetails.value?.hotelDetails),

                    SizedBox(
                      height: 15.h,
                    ),

                    // Use the custom FullPropertyBookNow widget
                     FullPropertyBookNow(
                      startDate:startDate ?? '',
                      endDate:endDate ?? '',
                    ),

                    // Property Rating Section
                    const PropertyRating(),

                    SizedBox(height: 5.h),

                    HomeDivider(),

                    // Use the new PropertyAmenities widget for full properties
                    PropertyAmenities(hotel: hotel),

                    HomeDivider(),

                    // Remove Transportations Section
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
                    //   child: Text(
                    //     'Transportations',
                    //     style: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         color: blue,
                    //         fontSize: 17.sp,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    // TransportationsFirstRow(),
                    // TransportationsSecondRow(),
                    // HomeDivider(),

                    // Choose your room section
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Text(
                        'Choose your room',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    Obx(() => Column(
                          children: List.generate(
                              fullPropertyController.fullPropertyDetails.value
                                      ?.rooms?.length ??
                                  0, (index) {
                            final room = fullPropertyController
                                .fullPropertyDetails.value!.rooms![index];
                            final isSelected = fullPropertyController
                                    .selectedRoomIndex.value ==
                                index;
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 10.w, right: 10.w, bottom: 15.h),
                              padding: EdgeInsets.all(15.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.sp),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // First line: Room name
                                  Row(
                                    children: [
                                      Text(
                                        (room.roomName ?? '').toUpperCase(),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      SizedBox(width: 6.w),
                                      Icon(Icons.check_circle,
                                          color: Colors.green, size: 18.sp),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  // Second line: room size left, image right
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Room size (left)
                                      Expanded(
                                        child: Text(
                                          room.roomSize != null
                                              ? '${room.roomSize} sq ft'
                                              : '',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: fontColor,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                      // Room image (right)
                                      if (room.roomImages != null &&
                                          room.roomImages!.isNotEmpty)
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6.sp),
                                          child: Image.network(
                                            room.roomImages![0],
                                            width: 110.w,
                                            height: 80.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 16.h),
                                  // Third line: Centered SELECTED button
                                  Center(
                                    child: SizedBox(
                                      width: 140.w,
                                      child: ElevatedButton(
                                        onPressed: () => fullPropertyController
                                            .selectedRoomIndex.value = index,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: isSelected
                                              ? Colors.green
                                              : Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.sp),
                                          ),
                                          minimumSize: Size(100.w, 40.h),
                                        ),
                                        child: Text(
                                          isSelected ? 'SELECTED' : 'SELECT',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        )),

                    // Property Description Section
                    PropertyDescription(
                        coverImageUrl: fullPropertyController
                            .fullPropertyDetails
                            .value
                            ?.hotelDetails
                            ?.coverImageUrl),

                    HomeDivider(),

                    // Replace the HotelPoliciesRow with our new PropertyPolicies widget
                    const PropertyPolicies(),
                    SizedBox(height: 30.h),
                    if (fullPropertyController.fullPropertyDetails.value
                                ?.hotelDetails?.latitude !=
                            null &&
                        fullPropertyController.fullPropertyDetails.value
                                ?.hotelDetails?.longitude !=
                            null) ...[
                      PropertyMapSection(
                        latitude: double.tryParse(fullPropertyController.fullPropertyDetails.value?.hotelDetails?.latitude ?? '') ?? 0.0,
                        longitude: double.tryParse(fullPropertyController.fullPropertyDetails.value?.hotelDetails?.longitude ?? '') ?? 0.0,
                        propertyName: fullPropertyController.fullPropertyDetails
                                .value?.hotelDetails?.name ??
                            '',
                      ),
                    ],
                  ],
                ),
              );
            }),
    );
  }
}
