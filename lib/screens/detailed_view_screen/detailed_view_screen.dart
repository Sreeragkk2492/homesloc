// ignore_for_file: file_names, avoid_print, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/search_hotel_room_details_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/detailed_view_screen/amenitie_row/amenitie_row.dart';
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
import 'package:homesloc/screens/detailed_view_screen/room_policies_row/room_policies_row.dart';
import 'package:homesloc/screens/detailed_view_screen/full_property_detailed_view_screen.dart';

class DetailedViewScreen extends StatelessWidget {
  final dynamic hotel;
  final dynamic selectedRoom;
  final String? roomId;
  final String? startDate;
  final String? endDate;

  const DetailedViewScreen({
    super.key,
    this.hotel,
    this.selectedRoom,
    this.roomId,
    this.startDate,
    this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    // If the hotel is a full property, use the FullPropertyDetailedViewScreen
    if (hotel != null && hotel.isFullProperty == true) {
      return FullPropertyDetailedViewScreen(
        hotel: hotel,
        startDate: startDate,
        endDate: endDate,
      );
    }

    final roomDetailsController = Get.put(SearchHotelRoomDetailsController());

    // Fetch room details if roomId and dates are provided
    if (roomId != null && startDate != null && endDate != null) {
      roomDetailsController.fetchRoomDetails(
        roomId: roomId!,
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
            roomDetailsController.clearRoomDetails();
            Get.back();
          },
        ),
        title: Center(
          child: Text(
            hotel?.name ?? "Hotel Details",
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
      body: Obx(() {
        if (roomId != null && roomDetailsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (roomId != null && roomDetailsController.errorMessage.value.isNotEmpty) {
          return Center(child: Text(roomDetailsController.errorMessage.value));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hotel Cover Image
              Container(
                height: 200.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(hotel?.coverImageUrl ?? 'assets/images/image (33).png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Room Details Section (if room is selected)
              if (roomId != null && roomDetailsController.roomDetails.value != null)
                Container(
                  // margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: border),
                  //   borderRadius: BorderRadius.circular(15.sp),
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Room Image
                      // Container(
                      //   height: 180.h,
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.only(
                      //       topLeft: Radius.circular(15.sp), 
                      //       topRight: Radius.circular(15.sp),
                      //     ),
                      //     image: DecorationImage(
                      //       image: NetworkImage(
                      //         roomDetailsController.roomDetails.value?.roomImages.first ?? 
                      //         hotel?.coverImageUrl ?? 
                      //         'assets/images/image (33).png'
                      //       ),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                      // Room Details
                      Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              roomDetailsController.roomDetails.value?.roomName ?? "Room",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              roomDetailsController.roomDetails.value?.roomType ?? "Room Type",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: fontColor,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "₹${roomDetailsController.roomDetails.value?.price ?? '0'}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "+ ₹${(double.parse(roomDetailsController.roomDetails.value?.price ?? '0') * 0.18).round()} Taxes & Fees",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: fontColor,
                                fontSize: 12.sp,
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
             Container(
                    height: 98.h,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: roomDetailsController.roomDetails.value?.images?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (roomDetailsController.roomDetails.value?.images?.isEmpty ?? true) {
                          return Center(
                            child: Text(
                              'No images available',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: fontColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            // You can add image preview functionality here
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            height: 98.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp), 
                              image: DecorationImage(
                                image: NetworkImage(
                                   roomDetailsController.roomDetails.value?.images?[index] ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    )),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Property highlights',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: blue,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 67.w,
                      height: 22.h,
                      decoration: BoxDecoration(
                        color: gwhite,
                        borderRadius: BorderRadius.circular(4.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 12.sp,
                            color: blue,
                          ),
                          Text(
                            'Location',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: blue,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, right: 10.w),
                      child: Image(
                        image: AssetImage('assets/images/Frame (8).png'),
                        width: 15.w,
                        height: 15.h,
                        color: blue,
                      ),
                    ),
                    Expanded(
                      child: Obx(() {
                        final hotelDetails = roomDetailsController.roomDetails.value?.hotelDetails;
                        final address = [
                          hotelDetails?.address,
                          hotelDetails?.postcode,
                          hotelDetails?.city,
                          hotelDetails?.state,
                          hotelDetails?.country,
                        ].where((element) => element != null && element.isNotEmpty).join(", ");
                        
                        return Text(
                          address.isNotEmpty ? address : "Address not available",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: black,
                            fontSize: 13.sp,
                            height: 1.5,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, right: 10.w),
                      child: Image(
                        image: AssetImage('assets/images/Frame (9).png'),
                        width: 15.w,
                        height: 15.h,
                        color: blue,
                      ),
                    ),
                    Expanded(
                      child: Obx(() {
                        final hotelDetails = roomDetailsController.roomDetails.value?.hotelDetails;
                        return Text(
                          hotelDetails?.phoneNumber ?? "Contact number not available",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: black,
                            fontSize: 13.sp,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.only(bottom: 82.h, right: 10.w),
                    //       child: Image(
                    //         image: AssetImage('assets/images/Frame (10).png'),
                    //         width: 15.w,
                    //         height: 15.h,
                    //         color: blue,
                    //       ),
                    //     ),
                    //     // Column(
                    //     //   crossAxisAlignment: CrossAxisAlignment.start,
                    //     //   children: [
                    //     //     Text( 
                    //     //       'Route to ${roomDetailsController.roomDetails.value?.hotelDetails?.name ?? "Hotel"}',
                    //     //       style: TextStyle(
                    //     //         fontFamily: 'Poppins',
                    //     //         color: black,
                    //     //         fontSize: 13.sp,
                    //     //         fontWeight: FontWeight.bold,
                    //     //       ),
                    //     //     ),
                    //     //     // Text(
                    //     //     //   'Starting Point: ${roomDetailsController.roomDetails.value?.hotelDetails?.city ?? "City"} Bus Stand',
                    //     //     //   style: TextStyle(
                    //     //     //     fontFamily: 'Poppins',
                    //     //     //     color: black,
                    //     //     //     fontSize: 13.sp, 
                    //     //     //     fontWeight: FontWeight.w500,
                    //     //     //   ),
                    //     //     // ),
                           
                    //     //   ],
                    //     // ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              HomeDivider(),
              NameView(
                name: "Property highlights",
                color: blue,
                secondName: 'View All',
                secondColor: blue,
              ),
              SizedBox(
                height: 15.h,
              ),
              PropertyFirstRow(),
              PropertySecondRow(),
              ProperyThirdRow(),
              SizedBox(
                height: 15.h,
              ),
              BookNow(
                hotel: hotel,
                selectedRoom: roomDetailsController.roomDetails.value,
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.h, left: 10.w, bottom: 10.h),
                child: Text(
                  'Rating & Reviews',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: blue,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 42.w,
                      height: 18.h,
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(3.sp),
                      ),
                      child: Obx(() {
                        final hotelDetails = roomDetailsController.roomDetails.value?.hotelDetails;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${hotelDetails?.starRating ?? 0}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: white,
                                fontSize: 11.sp
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Icon(
                              Icons.star,
                              color: yellow,
                              size: 14.sp,
                            )
                          ],
                        );
                      }),
                    ),
                    Obx(() {
                      final hotelDetails = roomDetailsController.roomDetails.value?.hotelDetails;
                      return Padding(
                        padding: EdgeInsets.only(right: 128.w),
                        child: Text(
                          "${hotelDetails?.totalRooms ?? 0} Reviews",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: const Color.fromARGB(255, 190, 190, 190),
                            fontSize: 11.sp
                          ),
                        ),
                      );
                    }),
                    Container(
                      width: 80.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: gwhite,
                        borderRadius: BorderRadius.circular(21.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/Vector (7).png'),
                            width: 11.w,
                            height: 11.h,
                            color: blue,
                          ),
                          SizedBox(width: 5.w),
                          Obx(() {
                            final hotelDetails = roomDetailsController.roomDetails.value?.hotelDetails;
                            final rating = hotelDetails?.starRating ?? 0;
                            String ratingText = 'Poor';
                            if (rating >= 4) {
                              ratingText = 'Excellent';
                            } else if (rating >= 3) {
                              ratingText = 'Good';
                            } else if (rating >= 2) {
                              ratingText = 'Average';
                            }
                            return Text(
                              ratingText,
                              style: TextStyle(
                                color: black,
                                fontFamily: 'Poppins',
                                fontSize: 10.sp
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              RatingFirstRow(),
              RatingSecondRow(),
              RatingThirdRow(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 120.h,
                // color: yellow,
                child: SecondDetailedViewBuilder(),
              ),
              HomeDivider(),
              // NameView(
              //     name: 'Amenities',
              //     color: blue,
              //     secondName: 'View All',
              //     secondColor: blue),
              AmenitieRow(),
              HomeDivider(),
              Padding( 
                padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
                child: Text(
                  'Transportations',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: blue,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TransportationsFirstRow(),
              TransportationsSecondRow(),
              HomeDivider(),
              Padding(
                padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
                child: Text(
                  'About ${roomDetailsController.roomDetails.value?.hotelDetails?.name ?? "Hotel"}', 
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: blue,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 10.h, left: 10.w, right: 10.w, bottom: 12.h),
                width: 340.w,
                height: 90.h,
                decoration: BoxDecoration(
                  // color: blue,
                  borderRadius: BorderRadius.circular(5.sp),
                  image: DecorationImage(
                      image:  NetworkImage(hotel?.coverImageUrl ?? 'assets/images/image (33).png'),
                      fit: BoxFit.fill ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    Obx(() {
                      final hotelDetails = roomDetailsController.roomDetails.value?.hotelDetails;
                      return Text(
                        hotelDetails?.description ?? "No description available",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontSize: 13.sp,
                        ),
                      );
                    }),
                    SizedBox( 
                      height: 8.h,
                    ),
                  ],
                ),
              ),
              HomeDivider(),
              NameView(
                  name: 'Our Accommodation Policies',
                  color: blue,
                  secondName: 'View All',
                  secondColor: blue),
             
              const HotelPoliciesRow(),
            //  HomeDivider(),
             // const RoomPoliciesRow(),
              SizedBox(height: 30.h),
            ],
          ),
        );
      }),
    );
  }
}
