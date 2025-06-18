// ignore_for_file: file_names, avoid_print, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/search_hotel_full_properties_controller.dart';
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
    final fullPropertyController = Get.put(SearchHotelFullPropertiesController());
    final roomDetailsController = Get.put(SearchHotelRoomDetailsController());

    // Fetch full property details if hotel is a full property and dates are provided
    if (hotel != null && hotel.isFullProperty == true && startDate != null && endDate != null) {
      print('Fetching full property details for hotel ID: ${hotel.id}');
      print('Is full property: ${hotel.isFullProperty}');
      print('Start date: $startDate, End date: $endDate');
      
      // Use the full property ID if available, otherwise use the hotel ID
      final propertyId = hotel.fullProperty?.id ?? hotel.id;
      
      fullPropertyController.fetchFullPropertyDetails(
        propertyId: propertyId,
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
            Get.back();
          },
        ),
        title: Center(
          child: Text(
            hotel?.name ?? "Full Property Details",
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
        if (hotel?.isFullProperty == true && fullPropertyController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (hotel?.isFullProperty == true && fullPropertyController.errorMessage.value.isNotEmpty) {
          return Center(child: Text(fullPropertyController.errorMessage.value));
        }

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
                    image: NetworkImage(hotel?.coverImageUrl ?? 'assets/images/image (33).png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Full Property Details Section
              if (hotel?.isFullProperty == true && fullPropertyController.fullPropertyDetails.value != null)
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property Details
                      const PropertyHeader(),
                    ],
                  ),
                ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 98.h,
                child: hotel?.isFullProperty == true 
                    ? FullPropertyFirstDetailedViewBuilder(hotel: hotel)
                    : FirstDetailedViewBuilder(hotel: hotel),
              ),
              
              // Property Location Section
              const PropertyLocation(),
              
              // Property Route Section
            //  const PropertyRoute(),
              
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
              
              // Use the custom FullPropertyBookNow widget
              const FullPropertyBookNow(),
              
              // Property Rating Section
              const PropertyRating(),
              
              SizedBox(height: 5.h),
              RatingFirstRow(),
              RatingSecondRow(),
              RatingThirdRow(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 120.h,
                child: SecondDetailedViewBuilder(),
              ),
              HomeDivider(),
              // Use the new PropertyAmenities widget for full properties, otherwise use the original AmenitieRow
              hotel?.isFullProperty == true 
                  ? const PropertyAmenities() 
                  : AmenitieRow(),
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
              
              // Property Description Section
              PropertyDescription(coverImageUrl: hotel?.coverImageUrl),
              
              HomeDivider(),
              // Replace the HotelPoliciesRow with our new PropertyPolicies widget
              const PropertyPolicies(),
              SizedBox(height: 30.h),
            ],
          ),
        );
      }),
    );
  }
} 