import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/search/tourist_search_controller.dart';
import 'package:homesloc/core/colors/colors.dart';

class TourismDetailViewScreen extends StatelessWidget {
  final String packageId;
  final String startDate;
  final String endDate;
  TourismDetailViewScreen(
      {super.key,
      required this.packageId,
      required this.startDate,
      required this.endDate});

  final screenController = Get.put(TouristSearchController());

  @override
  Widget build(BuildContext context) {
    // Fetch fresh up details when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenController.resetTourismDetails();
      screenController.fetchTourismDetails(
        packageId: packageId,
        startDate: startDate,
        endDate: endDate,
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
              screenController.resetTourismDetails();
              Get.back();
            },
          ),
          title: Center(
            child: Obx(() {
              final details = screenController.tourismDetails.value;
              return Text(
                details?.packageName ?? "Tourism Package",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: blue,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
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
          if (screenController.isLoadingTourismDetails.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (screenController.tourismDetailsErrorMessage.value.isNotEmpty) {
            return Center(
                child: Text(screenController.tourismDetailsErrorMessage.value));
          }
          final tourismDetails = screenController.tourismDetails.value;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Image
                Container(
                  height: 200.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          tourismDetails!.agencyDetails.coverImageUrl ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Event Details
                Padding(
                  padding: EdgeInsets.all(15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tourismDetails!.packageName ?? "Tourism Package",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        tourismDetails!.packageType ?? "Tourism Package",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: fontColor,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Text(
                            "₹${tourismDetails!.priceWithoutFlight ?? '0'}",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (tourismDetails!.offerPrice != null) ...[
                            SizedBox(width: 5.w),
                            Text(
                              "₹${tourismDetails!.offerPrice}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: fontColor,
                                fontSize: 14.sp,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'Start Location: ${tourismDetails!.startLocation}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: fontColor,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Ph: ${tourismDetails!.agencyDetails.phoneNumber}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: fontColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                // Small Images Row
                Container(
                    height: 98.h,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tourismDetails!.galleryImages.length,
                      itemBuilder: (context, index) {
                        if (tourismDetails!.galleryImages.isEmpty) {
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
                                    tourismDetails!.galleryImages[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    )),

                SizedBox(height: 20.h),

                // Property Highlights Grid
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          _buildFeatureItem(Icons.park, "Garden view"),
                          SizedBox(width: 20.w),
                          _buildFeatureItem(Icons.deck, "Terrace"),
                          SizedBox(width: 20.w),
                          _buildFeatureItem(Icons.water, "River view"),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        children: [
                          _buildFeatureItem(Icons.local_bar, "Bar"),
                          SizedBox(width: 20.w),
                          _buildFeatureItem(Icons.fitness_center, "Gym"),
                          SizedBox(width: 20.w),
                          _buildFeatureItem(Icons.pool, "Swimming Pool"),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        children: [
                          _buildFeatureItem(Icons.face, "Grilling"),
                          SizedBox(width: 20.w),
                          _buildFeatureItem(Icons.medical_services, "Medical"),
                          SizedBox(width: 20.w),
                          _buildFeatureItem(Icons.free_breakfast, "Breakfast"),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Book Now Section
                Container(
                  padding: EdgeInsets.all(12.r),
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(23.sp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h),
                      Text(
                        'Book Your Package Now',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 190, 190, 190),
                            fontFamily: 'Poppins',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Your refreshing stay is just a click away! Book\nnow for a comfortable and relaxing experience.',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 190, 190, 190),
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w100),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: Divider(
                          color: const Color.fromARGB(255, 190, 190, 190),
                        ),
                      ),
                      // If a custom price is provided, use it
                      if (tourismDetails!.priceWithoutFlight != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "₹${tourismDetails!.priceWithoutFlight}",
                                    style: TextStyle(
                                        color: white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp),
                                  ),
                                  Text(
                                    "+ ₹${(double.parse(tourismDetails!.priceWithoutFlight ?? '0') * 0.18).round()} taxes & fees",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 190, 190, 190),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        decorationColor: white,
                                        fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              width: 110.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: yellow,
                                borderRadius: BorderRadius.circular(28.sp),
                              ),
                              child: Center(
                                child: Text(
                                  "BOOK NOW",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 14.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      // Otherwise, use the room details if available
                      if (tourismDetails!.priceWithoutFlight == null)
                        Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "₹${tourismDetails?.offerPrice ?? tourismDetails?.priceWithoutFlight ?? '0'}",
                                          style: TextStyle(
                                              color: white,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.sp),
                                        ),
                                        if (tourismDetails?.offerPrice !=
                                                null &&
                                            tourismDetails
                                                    ?.priceWithoutFlight !=
                                                null)
                                          Padding(
                                            padding: EdgeInsets.only(left: 4.w),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "₹${tourismDetails?.priceWithoutFlight}",
                                                  style: TextStyle(
                                                      color: const Color
                                                          .fromARGB(
                                                          255, 190, 190, 190),
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor: white,
                                                      fontSize: 10.sp),
                                                ),
                                                SizedBox(width: 4.w),
                                                Text(
                                                  "${tourismDetails?.offerPrice}% OFF",
                                                  style: TextStyle(
                                                      color: green,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 10.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                    Text(
                                      "+ ₹${(double.parse((tourismDetails?.offerPrice ?? tourismDetails?.priceWithoutFlight ?? '0').toString()) * 0.18).round()} taxes & fees",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 190, 190, 190),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          decorationColor: white,
                                          fontSize: 10.sp),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                width: 110.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: yellow,
                                  borderRadius: BorderRadius.circular(28.sp),
                                ),
                                child: Center(
                                  child: Text(
                                    "BOOK NOW",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                    ],
                  ),
                ),

                SizedBox(height: 25.h),

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
                                  tourismDetails!.amenities.map((amenity) {
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

                SizedBox(height: 25.h),

                // Itinerary Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Itinerary',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: blue,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      tourismDetails!.itinerary.isEmpty
                          ? Text(
                              'No itinerary available',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: fontColor,
                                fontSize: 13.sp,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: tourismDetails!.itinerary.length,
                              itemBuilder: (context, index) {
                                final item = tourismDetails!.itinerary[index];
                                return _buildItineraryCard(item, index);
                              },
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),

                // About Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About ${tourismDetails!.agencyDetails.name}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: blue,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        width: double.infinity,
                        height: 90.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          image: DecorationImage(
                            image: NetworkImage(
                                tourismDetails!.agencyDetails.coverImageUrl ??
                                    ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        tourismDetails!.agencyDetails.description ?? '',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: black,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25.h),

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
                        tourismDetails!.agencyDetails.policies
                                    .cancellationPolicy !=
                                null
                            ? "Free cancellation up to ${tourismDetails!.agencyDetails.policies.cancellationDays} days before check-in"
                            : "No cancellation policy available",
                      ),
                      _buildPolicyItem(
                        Icons.credit_card,
                        "Payment Policy",
                        tourismDetails!.agencyDetails.policies.paymentPolicy ??
                            "Not specified",
                      ),
                      _buildPolicyItem(
                        Icons.badge,
                        "Acceptable Identity Proof",
                        (tourismDetails!.agencyDetails.policies
                                        .acceptableIdentityProof !=
                                    null &&
                                tourismDetails!.agencyDetails.policies
                                    .acceptableIdentityProof.isNotEmpty)
                            ? tourismDetails!
                                .agencyDetails.policies.acceptableIdentityProof
                                .join(", ")
                            : "Not specified",
                      ),
                      if (tourismDetails!
                                  .agencyDetails.policies.tripTermsConditions !=
                              null &&
                          tourismDetails!.agencyDetails.policies
                              .tripTermsConditions.isNotEmpty)
                        _buildPolicyItem(
                          Icons.info_outline,
                          "Terms & Conditions",
                          tourismDetails!
                              .agencyDetails.policies.tripTermsConditions
                              .join("\n"),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),
              ],
            ),
          );
        }));
  }

  Widget _buildSmallImage() {
    return Container(
      width: 90.w,
      height: 90.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        image: DecorationImage(
          image: AssetImage('assets/images/image (33).png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildHighlightItem(String iconPath, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3.h, right: 10.w),
            child: Image(
              image: AssetImage(iconPath),
              width: 15.w,
              height: 15.h,
              color: blue,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: black,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: blue,
        ),
        SizedBox(width: 5.w),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: black,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingCategory(String category, double rating) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        children: [
          Container(
            width: 80.w,
            child: Text(
              category,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: black,
                fontSize: 12.sp,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Text(
              rating.toString(),
              style: TextStyle(
                fontFamily: 'Poppins',
                color: white,
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReview(String name, String review) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20.sp,
          backgroundColor: Colors.grey[300],
          child: Icon(Icons.person, color: Colors.grey[600]),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                review,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: black,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
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

  Widget _buildTransportItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: blue,
        ),
        SizedBox(width: 5.w),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: black,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
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

  Widget _buildItineraryCard(dynamic item, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: gwhite,
        borderRadius: BorderRadius.circular(10.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day Circle
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'Day ${item.day}',
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(width: 14.w),
          // Itinerary Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.description ?? '',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: black,
                    fontSize: 12.sp,
                  ),
                ),
                if (item.location != null &&
                    item.location.toString().isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, size: 13.sp, color: blue),
                        SizedBox(width: 4.w),
                        Text(
                          item.location,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: fontColor,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                // if (item.meal_plan != null && item.meal_plan.toString().isNotEmpty)
                //   Padding(
                //     padding: EdgeInsets.only(top: 6.h),
                //     child: Row(
                //       children: [
                //         Icon(Icons.restaurant, size: 13.sp, color: blue),
                //         SizedBox(width: 4.w),
                //         Text(
                //           item.meal_plan,
                //           style: TextStyle(
                //             fontFamily: 'Poppins',
                //             color: fontColor,
                //             fontSize: 11.sp,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
