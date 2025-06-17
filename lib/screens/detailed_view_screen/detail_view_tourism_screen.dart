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

  @override
  Widget build(BuildContext context) {
    final screenController = Get.put(TouristSearchController());
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
                          tourismDetails!.galleryImages.isNotEmpty == true
                              ? tourismDetails.galleryImages!.first
                              : 'assets/images/image (33).png'),
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
                        tourismDetails!.startLocation ?? "", 
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: fontColor,
                          fontSize: 14.sp,
                        ),
                      ),
                       SizedBox(height: 5.h),
                      Text(
                        tourismDetails!.destination ?? "",  
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
                  child:ListView.builder(
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
                    image: NetworkImage(tourismDetails!.galleryImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ) 
                ),

                SizedBox(height: 20.h),

                // Property Highlights Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: gwhite,
                          borderRadius: BorderRadius.circular(4.sp),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 12.sp,
                              color: blue,
                            ),
                            SizedBox(width: 4.w),
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

                SizedBox(height: 15.h),

                // Location Details
                _buildHighlightItem(
                  'assets/images/Frame (8).png',
                  "1233, parakkad, Kerala, India",
                ),

                SizedBox(height: 10.h),

                // Check-in Time
                _buildHighlightItem(
                  'assets/images/Frame (9).png',
                  "Check-in time not available",
                ),

                SizedBox(height: 10.h),

                // Route Information
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 3.h, right: 10.w),
                        child: Image(
                          image: AssetImage('assets/images/Frame (10).png'),
                          width: 15.w,
                          height: 15.h,
                          color: blue,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Route to new banquet hall',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              'Starting Point: parakkad Bus Stand\n1. Head southeast on Munnar-Udumalpet Road (NH85). 2. Take the Mattupetty Road exit. 3. Follow the scenic Mattupetty Road. After 12km you reach destination.',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

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
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Book Your Event Now",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Your dream event is just a click away! Book now for a seamless and unforgettable experience.",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: white,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "₹22.00",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "₹22.00",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white70,
                                      fontSize: 14.sp,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "0% OFF",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: yellow,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "+ 24 taxes & fees",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white70,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              color: yellow,
                              borderRadius: BorderRadius.circular(25.sp),
                            ),
                            child: Text(
                              "BOOK NOW",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25.h),

                // Rating & Reviews Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rating & Reviews',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: blue,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(4.sp),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: white,
                                    fontSize: 11.sp,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Icon(
                                  Icons.star,
                                  color: yellow,
                                  size: 12.sp,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "10 Reviews",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                              fontSize: 11.sp,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: gwhite,
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  size: 10.sp,
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
                      SizedBox(height: 15.h),

                      // Rating Categories
                      _buildRatingCategory("Staff", 8.9),
                      _buildRatingCategory("Facilities", 7.9),
                      _buildRatingCategory("Cleanliness", 8.9),
                      _buildRatingCategory("Location", 6.9),
                      _buildRatingCategory("Dealings", 7.3),
                      _buildRatingCategory("Food", 8.0),
                      _buildRatingCategory("Value Of Money", 8.9),
                      _buildRatingCategory("Comfort", 7.3),

                      SizedBox(height: 20.h),

                      // Reviews
                      _buildReview("Dasamoolam Damu",
                          "The room, cleanliness, and staff experience at this hotel were just fantastic."),
                      SizedBox(height: 15.h),
                      _buildReview("Dasamoolam Damu",
                          "The room, cleanliness, and staff experience at this hotel were just fantastic."),
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
                      Row(
                        children: [
                          _buildAmenityItem("Private Beach"),
                          SizedBox(width: 20.w),
                          _buildAmenityItem("Free cancellation"),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25.h),

                // Transportation Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transportations',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: blue,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        children: [
                          _buildTransportItem(Icons.flight, "Airport - 9.3 km"),
                          SizedBox(width: 30.w),
                          _buildTransportItem(
                              Icons.train, "Metro Station - 3.1 km"),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        children: [
                          _buildTransportItem(Icons.train, "Train - 5.3 km"),
                          SizedBox(width: 30.w),
                          _buildTransportItem(
                              Icons.directions_bus, "Bus - 6.2 km"),
                        ],
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
                        'About new banquet hall',
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
                            image: AssetImage('assets/images/image (33).png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        "No description available",
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
                            'Our Hall Policies',
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
                      _buildPolicyItem(Icons.access_time, "Check-in/Check-out",
                          "Check-in: 04:00:00\nCheck-out: 05:00:00"),
                      _buildPolicyItem(
                          Icons.credit_card,
                          "Acceptable Identity Proof",
                          "Passport, Aadhar, Voter ID, Driving License"),
                      _buildPolicyItem(
                          Icons.cancel, "Cancellation Policy", "freeBefore:-2"),
                      _buildPolicyItem(Icons.local_parking, "Parking Capacity",
                          "22 vehicles"),
                      _buildPolicyItem(Icons.celebration, "Decoration Policy",
                          "Decoration Not Allowed"),
                      _buildPolicyItem(Icons.local_parking, "Valet Parking",
                          "Not Available"),
                      _buildPolicyItem(
                          Icons.attach_money, "Extra Charges", "₹22"),
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

  Widget _buildAmenityItem(String amenity) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check_circle,
          size: 16.sp,
          color: blue,
        ),
        SizedBox(width: 5.w),
        Text(
          amenity,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: black,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
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
}
