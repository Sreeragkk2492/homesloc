// ignore_for_file: file_names, avoid_print, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/hall_search_controller.dart';
import 'package:homesloc/controller/search/search_hotel_room_details_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/detailed_view_screen/amenitie_row/amenitie_row.dart';
import 'package:homesloc/screens/detailed_view_screen/amenitie_row/hall_amenitie_row.dart';
import 'package:homesloc/screens/detailed_view_screen/full_property_widgets/property_maps.dart';
import 'package:homesloc/screens/detailed_view_screen/hall_policies_row/hall_policies_row.dart';
import 'package:homesloc/screens/detailed_view_screen/property_row/property_first_row.dart';
import 'package:homesloc/screens/detailed_view_screen/property_row/property_second_row.dart';
import 'package:homesloc/screens/detailed_view_screen/property_row/property_third_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_first_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_second_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_third_row.dart';
import 'package:homesloc/screens/detailed_view_screen/transportation_row/transportations_first_row.dart';
import 'package:homesloc/screens/detailed_view_screen/transportation_row/transportations_second_row.dart';
import 'package:homesloc/core/widgets/yellow_star/yellow_star.dart';
import 'package:homesloc/core/widgets/book_now/hall_book_now.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/hall_first_detailed_view_builder.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/second_detailed_view_builder.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/screens/detailed_view_screen/hotel_policies_row/hotel_policies_row.dart';
import 'package:lottie/lottie.dart';

class DetailViewHallScreen extends StatelessWidget {
  final dynamic hall;
  final dynamic selectedEvent;
  final String? eventId;
  final String? startDate;
  final String? endDate;

  const DetailViewHallScreen({
    super.key,
    this.hall,
    this.selectedEvent,
    this.eventId,
    this.startDate,
    this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final hallSearchController = Get.put(HallSearchController());
    final roomDetailsController = Get.put(SearchHotelRoomDetailsController());

    // Fetch event details if eventId and dates are provided
    if (eventId != null && startDate != null && endDate != null) {
      hallSearchController.fetchEventDetails(
        eventId: eventId!,
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
            hallSearchController.clearSelectedEventDetails();
            Get.back();
          },
        ),
        title: Center(
          child: Text(
            hall?.name ?? "Hall Details",
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
        if (eventId != null && hallSearchController.isLoadingEventDetails.value) {
          return  Center(child:  Container(
                        width: 50.w,
                        height: 50.h,
                        child: Lottie.asset(
                          'assets/images/loading.json',
                          // controller: _checkmarkController,
                          repeat: true,
                        ),
                      ),);
        }

        if (eventId != null && hallSearchController.eventDetailsErrorMessage.value.isNotEmpty) {
          return Center(child: Text(hallSearchController.eventDetailsErrorMessage.value));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hall Cover Image
              Container(
                height: 200.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      eventId != null && hallSearchController.selectedEventDetails.value != null
                          ? hallSearchController.selectedEventDetails.value?.hallDetails?.coverImageUrl ?? 'assets/images/image (33).png'
                          : hall?.coverImage ?? 'assets/images/image (33).png'
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Event Details Section (if event is selected)
              if (eventId != null && hallSearchController.selectedEventDetails.value != null)
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hallSearchController.selectedEventDetails.value?.eventName ?? "Event",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              hallSearchController.selectedEventDetails.value?.venueType ?? "Venue Type",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: fontColor,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "₹${hallSearchController.selectedEventDetails.value?.price ?? '0'}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          
                            Text(
                              hallSearchController.selectedEventDetails.value?.hallDetails?.description ?? "",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 98.h,
                child: HallFirstDetailedViewBuilder(hall: hall),
              ),
                SizedBox(height: 10.h), 
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
                      child: Text(
                        hallSearchController.selectedEventDetails.value?.hallDetails?.address != null
                            ? [
                                hallSearchController.selectedEventDetails.value?.hallDetails?.address,
                                hallSearchController.selectedEventDetails.value?.hallDetails?.postcode,
                                hallSearchController.selectedEventDetails.value?.hallDetails?.city,
                                hallSearchController.selectedEventDetails.value?.hallDetails?.state,
                                hallSearchController.selectedEventDetails.value?.hallDetails?.country,
                              ].where((element) => element != null && element.isNotEmpty).join(", ")
                            : "Address not available",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontSize: 13.sp,
                          height: 1.5,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
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
                      child: Text(
                       "Ph:",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontSize: 13.sp,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
             // SizedBox(height: 10.h), 
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 10.w),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           Padding(
              //             padding: EdgeInsets.only(bottom: 82.h, right: 10.w),
              //             child: Image(
              //               image: AssetImage('assets/images/Frame (10).png'),
              //               width: 15.w,
              //               height: 15.h,
              //               color: blue,
              //             ),
              //           ),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 'Route to ${hallSearchController.selectedEventDetails.value?.hallDetails?.name ?? "Hall"}',
              //                 style: TextStyle(
              //                   fontFamily: 'Poppins',
              //                   color: black,
              //                   fontSize: 13.sp,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //               Text(
              //                 'Starting Point: ${hallSearchController.selectedEventDetails.value?.hallDetails?.city ?? "City"} Bus Stand',
              //                 style: TextStyle(
              //                   fontFamily: 'Poppins',
              //                   color: black,
              //                   fontSize: 13.sp,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //               Text(
              //                 '1. Head southeast on Munnar-Udumalpet\nRoad (NH85).  2. Take the Mattupetty Road\nexit. 3. Follow the scenic Mattupetty Road.\nAfter 12km you reach destination.',
              //                 style: TextStyle(
              //                   fontFamily: 'Poppins',
              //                   color: black,
              //                   fontSize: 13.sp,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            //  HomeDivider(),
              // NameView(
              //   name: "Property highlights",
              //   color: blue,
              //   secondName: 'View All',
              //   secondColor: blue,
              // ),
              SizedBox(
                height: 15.h,
              ),
              // PropertyFirstRow(),
              // PropertySecondRow(),
              // ProperyThirdRow(),
              // SizedBox(
              //   height: 15.h,
              // ),
              HallBookNow(
                hall: hall,
                selectedEvent: hallSearchController.selectedEventDetails.value,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            hallSearchController.selectedEventDetails.value?.hallDetails?.startingRange?.toString() ?? '4.5',
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
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 128.w),
                      child: Text(
                        "10 Reviews", // Placeholder review count
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: const Color.fromARGB(255, 190, 190, 190),
                          fontSize: 11.sp
                        ),
                      ),
                    ),
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
                          Text(
                            'Excellent', // Placeholder rating text
                            style: TextStyle(
                              color: black,
                              fontFamily: 'Poppins',
                              fontSize: 10.sp
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              // RatingFirstRow(),
              // RatingSecondRow(),
              // RatingThirdRow(),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width,
              //   height: 120.h,
              //   child: SecondDetailedViewBuilder(),
              // ),
              HomeDivider(),
              HallAmenitieRow(), 
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
                  'About ${hallSearchController.selectedEventDetails.value?.hallDetails?.name ?? "Hall"}', 
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
                  borderRadius: BorderRadius.circular(5.sp),
                  image: DecorationImage(
                      image: NetworkImage(
                        eventId != null && hallSearchController.selectedEventDetails.value != null
                            ? hallSearchController.selectedEventDetails.value?.hallDetails?.coverImageUrl ?? 'assets/images/image (33).png'
                            : hall?.coverImage ?? 'assets/images/image (33).png'
                      ),
                      fit: BoxFit.fill ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    Text(
                      hallSearchController.selectedEventDetails.value?.hallDetails?.description ?? "No description available",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: black,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox( 
                      height: 8.h,
                    ),
                  ],
                ),
              ),
              HomeDivider(),
              NameView(
                  name: 'Our Hall Policies',
                  color: blue,
                  secondName: 'View All',
                  secondColor: blue),
             
              const HallPoliciesRow(),
              SizedBox(height: 30.h),
              //  SizedBox(height: 30.h),
                    if ( hallSearchController.selectedEventDetails.value
                                ?.hallDetails?.latitude !=
                            null &&
                        hallSearchController.selectedEventDetails.value
                                ?.hallDetails?.longitude !=
                            null) ...[
                      PropertyMapSection(
                        latitude: double.tryParse(hallSearchController.selectedEventDetails.value?.hallDetails?.latitude ?? '') ?? 0.0,
                        longitude: double.tryParse(hallSearchController.selectedEventDetails.value?.hallDetails?.longitude ?? '') ?? 0.0,
                        propertyName: hallSearchController.selectedEventDetails
                                .value?.hallDetails?.name ??
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
