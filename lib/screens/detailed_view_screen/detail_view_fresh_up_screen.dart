// ignore_for_file: file_names, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/search_fresh_up_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/detailed_view_screen/amenitie_row/fresh_up_amenitie_row.dart';
import 'package:homesloc/screens/detailed_view_screen/time_slots_row/fresh_up_time_slots_row.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/screens/detailed_view_screen/hotel_policies_row/hotel_policies_row.dart';
import 'package:homesloc/screens/detailed_view_screen/property_row/property_first_row.dart';
import 'package:homesloc/screens/detailed_view_screen/property_row/property_second_row.dart';
import 'package:homesloc/screens/detailed_view_screen/property_row/property_third_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_first_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_second_row.dart';
import 'package:homesloc/screens/detailed_view_screen/rating_row/rating_third_row.dart';
import 'package:homesloc/screens/detailed_view_screen/transportation_row/transportations_first_row.dart';
import 'package:homesloc/screens/detailed_view_screen/transportation_row/transportations_second_row.dart';
import 'package:homesloc/core/widgets/yellow_star/yellow_star.dart';
import 'package:homesloc/core/widgets/book_now/fresh_up_book_now.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/fresh_up_first_detailed_view_builder.dart';
import 'package:homesloc/core/widgets/builder/detailed_view_builder/second_detailed_view_builder.dart';

class DetailViewFreshUpScreen extends StatelessWidget {
  final String freshUpId;
  final String priceMethod;
  final String date;

  const DetailViewFreshUpScreen({
    super.key,
    required this.freshUpId,
    required this.priceMethod,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final freshUpController = Get.put(SearchFreshUpController());

    // Fetch fresh up details when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      freshUpController.resetRoomDetails();
      freshUpController.fetchFreshUpRoomDetails(
        freshUpId: freshUpId,
        priceMethod: priceMethod,
        date: date,
      );
    });

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
            freshUpController.resetRoomDetails();
            Get.back();
          },
        ),
        title: Center(
          child: Obx(() {
            final propertyDetails = freshUpController.roomDetails.value?.propertyDetails;
            return Text(
              propertyDetails?.name ?? "Fresh Up Details",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: blue,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_outline_rounded,
              color: blue,
              size: 25.sp,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (freshUpController.isLoadingRoomDetails.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (freshUpController.roomDetailsErrorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error loading details',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  freshUpController.roomDetailsErrorMessage.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          );
        }

        final roomDetails = freshUpController.roomDetails.value;
        if (roomDetails == null) {
          return const Center(child: Text('No details available'));
        }

        final propertyDetails = roomDetails.propertyDetails;
        
        // Get the appropriate price details based on price method
        final pricePerRoom = roomDetails.pricePerRoom;
        final pricePerHead = roomDetails.pricePerHead;
        
        // Determine which price details to use
        final isPerRoom = roomDetails.priceMethod == "PER_ROOM";
        final priceDetails = isPerRoom ? pricePerRoom : pricePerHead;
        
        // Get the appropriate price based on price method
        final price = isPerRoom 
            ? pricePerRoom?.price 
            : pricePerHead?.price ; 
            
        final offerPrice = isPerRoom 
            ? pricePerRoom?.offerPrice 
            : pricePerHead?.offerPrice;
            
        // Get common properties with proper type casting
        final freshupName = isPerRoom 
            ? pricePerRoom?.freshupName 
            : pricePerHead?.freshupName;
            
        final freshupType = isPerRoom 
            ? pricePerRoom?.freshupType 
            : pricePerHead?.freshupType;
            
        final freshupDescription = isPerRoom 
            ? pricePerRoom?.freshupDescription 
            : pricePerHead?.freshupDescription;
            
        final slots = isPerRoom 
            ? pricePerRoom?.slots 
            : pricePerHead?.slots;

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Image
              Container(
                height: 200.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      roomDetails.images?.isNotEmpty == true
                          ? roomDetails.images!.first
                          : propertyDetails?.coverImageUrl ?? 'assets/images/image (33).png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Fresh Up Details
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
                            freshupName ?? "Fresh Up",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            freshupType ?? "Type",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: fontColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Text(
                                "₹${price ?? '0'}",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (offerPrice != null) ...[
                                SizedBox(width: 5.w),
                                Text(
                                  "₹${offerPrice}",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: fontColor,
                                    fontSize: 14.sp,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "${_calculateDiscountPercentage(price ?? 0, offerPrice)}% OFF",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: green,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            freshupDescription ?? "",
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
                child: FreshUpFirstDetailedViewBuilder(freshUp: null),
              ),

              // Property Highlights Section
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
                        fontWeight: FontWeight.bold,
                      ),
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
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Location Details
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
                        [
                          propertyDetails?.address,
                          propertyDetails?.postcode,
                          propertyDetails?.city,
                          propertyDetails?.state,
                          propertyDetails?.country,
                        ].where((element) => element != null && element.isNotEmpty).join(", "),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontSize: 13.sp,
                          height: 1.5,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.h),

              // Check-in Time
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
                        "ph : ${propertyDetails?.phoneNumber ?? ''}",  
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontSize: 13.sp,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.h),

              // Route Information
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
              //                 'Route to ${propertyDetails?.name ?? "Fresh Up"}',
              //                 style: TextStyle(
              //                   fontFamily: 'Poppins',
              //                   color: black,
              //                   fontSize: 13.sp,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //               Text(
              //                 'Starting Point: ${propertyDetails?.city ?? "City"} Bus Stand',
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

              HomeDivider(),

              // Property Highlights Section
              NameView(
                name: "Property highlights",
                color: blue,
                secondName: 'View All',
                secondColor: blue,
              ),
              SizedBox(height: 15.h),
              PropertyFirstRow(),
              PropertySecondRow(),
              ProperyThirdRow(),
              SizedBox(height: 15.h),
              FreshUpBookNow(
                freshUp: roomDetails,
                price: null,
              ),

              // Ratings & Reviews Section
              Padding(
                padding: EdgeInsets.only(top: 18.h, left: 10.w, bottom: 10.h),
                child: Text(
                  'Rating & Reviews',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: blue,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
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
                            '4.5',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: white,
                              fontSize: 11.sp,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Icon(
                            Icons.star,
                            color: yellow,
                            size: 14.sp,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 128.w),
                      child: Text(
                        "10 Reviews",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: const Color.fromARGB(255, 190, 190, 190),
                          fontSize: 11.sp,
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
                            'Excellent',
                            style: TextStyle(
                              color: black,
                              fontFamily: 'Poppins',
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              RatingFirstRow(),
              RatingSecondRow(),
              RatingThirdRow(),

              // Second Detailed View Builder
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 120.h,
                child: SecondDetailedViewBuilder(),
              ),

              HomeDivider(),

              // Amenities Section
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amenities',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: blue,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'View All',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: blue,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10.w, right: 10.w, top: 10.h),
                            child: Wrap(
                              spacing: 10.w,
                              runSpacing: 10.h,
                              children:
                                  (propertyDetails!.freshupAmenities ?? []).map((amenity) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: gwhite,
                                    borderRadius: BorderRadius.circular(4.sp),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        _getAmenityIcon(amenity.name ?? ''),
                                        color: black,
                                        size: 11.sp,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        amenity.name ?? '',
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
                        ],
                      ),
                    ],
                  ),
                ),

              HomeDivider(),

              // Slots Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Slots',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: blue,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    if (slots == null || slots.isEmpty)
                      Text(
                        'No slots available',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: fontColor,
                          fontSize: 13.sp,
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: slots.length,
                        itemBuilder: (context, index) {
                          final slot = slots[index];
                          // Try both property and map access for checkIn/checkOut
                          String? checkIn;
                          String? checkOut;
                          try {
                            checkIn = slot.checkIn;
                          } catch (_) {
                            checkIn = null;
                          }
                          try {
                            checkOut = slot.checkOut;
                          } catch (_) {
                            checkOut = null;
                          }
                          return Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: gwhite,
                              borderRadius: BorderRadius.circular(8.sp),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.08),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.access_time, color: blue, size: 20.sp),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Check-in: ' + (checkIn != null ? checkIn.toString().substring(0,5) : '-'),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: black,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 3.h),
                                      Text(
                                        'Check-out: ' + (checkOut != null ? checkOut.toString().substring(0,5) : '-'),
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
                          );
                        },
                      ),
                  ],
                ),
              ),

              SizedBox(height: 25.h),

              // Transportation Info Section
              Padding(
                padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
                child: Text(
                  'Transportations',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: blue,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TransportationsFirstRow(),
              TransportationsSecondRow(),

              HomeDivider(),

              // About Section
              Padding(
                padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
                child: Text(
                  'About ${propertyDetails?.name ?? "Fresh Up"}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: blue,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Property Image
              Container(
                margin: EdgeInsets.only(
                  top: 10.h,
                  left: 10.w,
                  right: 10.w,
                  bottom: 12.h,
                ),
                width: 340.w,
                height: 90.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.sp),
                  image: DecorationImage(
                    image: NetworkImage(
                      propertyDetails?.coverImageUrl ?? 'assets/images/image (33).png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              // Property Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  propertyDetails?.description ?? "No description available",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: black,
                    fontSize: 13.sp,
                  ),
                ),
              ),

              HomeDivider(),

              // Policies Section
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Our Policies',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: blue,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'View All',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: blue,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      _buildPolicyItem(
                        Icons.access_time,
                        "Cancellation Policy",
                        (propertyDetails?.freshupPolicies?.cancellationPolicy ?? '').isNotEmpty
                            ? propertyDetails!.freshupPolicies!.cancellationPolicy!
                            : "No cancellation policy available",
                      ),
                      _buildPolicyItem(
                        Icons.schedule,
                        "Accepted Time Slots",
                        (propertyDetails?.freshupPolicies?.acceptedtimeslots ?? '').isNotEmpty
                            ? propertyDetails!.freshupPolicies!.acceptedtimeslots!
                            : "Not specified",
                      ),
                      _buildPolicyItem(
                        Icons.bed,
                        "Extra Bed Policy",
                        (propertyDetails?.freshupPolicies?.extraBedPolicy ?? '').isNotEmpty
                            ? propertyDetails!.freshupPolicies!.extraBedPolicy!
                            : "Not specified",
                      ),
                      _buildPolicyItem(
                        Icons.badge,
                        "Acceptable Identity Proof",
                        (propertyDetails?.freshupPolicies?.acceptableIdentityProof != null && (propertyDetails!.freshupPolicies!.acceptableIdentityProof?.isNotEmpty ?? false))
                            ? propertyDetails!.freshupPolicies!.acceptableIdentityProof!.join(", ")
                            : "Not specified",
                      ),
                      if ((propertyDetails?.freshupPolicies?.propertyrules ?? '').isNotEmpty)
                        _buildPolicyItem(
                          Icons.rule,
                          "Property Rules",
                          propertyDetails!.freshupPolicies!.propertyrules ?? '',
                        ),
                    ],
                  ),
                ),

              SizedBox(height: 30.h),
            ],
          ),
        );
      }),
    );
  }

  int _calculateDiscountPercentage(num originalPrice, num discountedPrice) {
    if (originalPrice > 0) {
      return ((originalPrice - discountedPrice) / originalPrice * 100).round();
    }
    return 0;
  }

   Widget _buildPolicyItem(IconData icon, String title, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: gwhite,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6.sp),
            ),
            child: Icon(
              icon,
              color: blue,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: fontColor,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

   IconData _getAmenityIcon(String amenityName) {
    // Map amenity names to appropriate icons
    final amenityIcons = {
      'Wi-Fi': Icons.wifi,
      'Parking': Icons.local_parking,
      'Air Conditioning': Icons.ac_unit,
      'Swimming Pool': Icons.pool,
      'Restaurant': Icons.restaurant,
      'Bar': Icons.local_bar,
      'Gym': Icons.fitness_center,
      'Spa': Icons.spa,
      'Conference Room': Icons.meeting_room,
      'Elevator': Icons.elevator,
      'Security': Icons.security,
      'Power Backup': Icons.power,
      'Sound System': Icons.speaker,
      'Lighting': Icons.lightbulb,
      'Decoration': Icons.celebration,
      'Catering': Icons.fastfood,
      'Photography': Icons.camera_alt,
      'Videography': Icons.videocam,
      'Makeup Room': Icons.face,
      'Changing Room': Icons.checkroom,
      'Stage': Icons.theater_comedy,
      'Dance Floor': Icons.music_note,
      'Projector': Icons.movie,
      'Screen': Icons.screen_share,
      'Microphone': Icons.mic,
      'Chairs': Icons.chair,
      'Tables': Icons.table_bar,
      'Crockery': Icons.restaurant_menu,
      'Cutlery': Icons.restaurant,
      'Linens': Icons.bed,
      'Generator': Icons.power,
      'Fire Extinguisher': Icons.local_fire_department,
      'First Aid Kit': Icons.medical_services,
      'Wheelchair Access': Icons.accessible,
      'Child Care': Icons.child_care,
      'Valet Parking': Icons.directions_car,
      'Guest Rooms': Icons.hotel,
      'Shuttle Service': Icons.directions_bus,
      'Outdoor Space': Icons.park,
      'Indoor Space': Icons.home,
      'Garden': Icons.yard,
      'Lake View': Icons.water,
      'Mountain View': Icons.landscape,
      'City View': Icons.location_city,
      'Beach Access': Icons.beach_access,
      'Pool': Icons.pool,
      'Jacuzzi': Icons.hot_tub,
      'Sauna': Icons.spa,
      'Tennis Court': Icons.sports_tennis,
      'Golf Course': Icons.sports_golf,
      'Basketball Court': Icons.sports_basketball,
      'Volleyball Court': Icons.sports_volleyball,
      'Badminton Court': Icons.sports,
      'Table Tennis': Icons.sports,
      'Chess': Icons.casino,
      'Library': Icons.library_books,
      'Business Center': Icons.business,
      'Laundry': Icons.local_laundry_service,
      'Dry Cleaning': Icons.cleaning_services,
      'Room Service': Icons.room_service,
      'Housekeeping': Icons.cleaning_services,
      'Concierge': Icons.support_agent,
      'Currency Exchange': Icons.currency_exchange,
      'ATM': Icons.atm,
      'Gift Shop': Icons.card_giftcard,
      'Tour Desk': Icons.tour,
      'Car Rental': Icons.directions_car,
      'Airport Transfer': Icons.flight,
      'Babysitting': Icons.child_care,
      'Pet Friendly': Icons.pets,
      'Smoking Area': Icons.smoking_rooms,
      'Non-Smoking': Icons.smoke_free,
      'Vegetarian Food': Icons.eco,
      'Vegan Food': Icons.eco,
      'Gluten-Free Food': Icons.no_meals,
      'Halal Food': Icons.restaurant,
      'Kosher Food': Icons.restaurant,
      'Jain Food': Icons.restaurant,
      'South Indian Food': Icons.restaurant,
      'North Indian Food': Icons.restaurant,
      'Chinese Food': Icons.restaurant,
      'Italian Food': Icons.restaurant,
      'Mexican Food': Icons.restaurant,
      'Thai Food': Icons.restaurant,
      'Japanese Food': Icons.restaurant,
      'Korean Food': Icons.restaurant,
      'Mediterranean Food': Icons.restaurant,
      'American Food': Icons.restaurant,
      'Continental Food': Icons.restaurant,
      'Fusion Food': Icons.restaurant,
      'Street Food': Icons.restaurant,
      'Fast Food': Icons.fastfood,
      'Fine Dining': Icons.restaurant,
      'Buffet': Icons.restaurant,
      'A La Carte': Icons.restaurant,
      'Bar Service': Icons.local_bar,
      'Wine Cellar': Icons.wine_bar,
      'Cocktail Bar': Icons.local_bar,
      'Beer Garden': Icons.local_bar,
      'Rooftop Bar': Icons.roofing,
      'Pool Bar': Icons.pool,
      'Sports Bar': Icons.sports,
      'Lounge': Icons.living,
      'Nightclub': Icons.nightlife,
      'Live Music': Icons.music_note,
      'DJ': Icons.headphones,
      'Karaoke': Icons.mic,
    };

    // Return the icon for the amenity or a default icon if not found
    return amenityIcons[amenityName] ?? Icons.check_circle;
  }
}
