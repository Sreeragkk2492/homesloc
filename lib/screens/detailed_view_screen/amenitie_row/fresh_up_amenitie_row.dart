// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/controller/search/search_fresh_up_controller.dart';

class FreshUpAmenitieRow extends StatefulWidget {
  const FreshUpAmenitieRow({super.key});

  @override
  State<FreshUpAmenitieRow> createState() => _FreshUpAmenitieRowState();
}

class _FreshUpAmenitieRowState extends State<FreshUpAmenitieRow> {
  bool isExpanded = false;
  final freshUpController = Get.find<SearchFreshUpController>();

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final roomDetails = freshUpController.roomDetails.value;
      final pricePerHead = roomDetails?.pricePerHead;
      final amenities = pricePerHead?.amenities ?? [];
      
      if (amenities.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Text(
            'No amenities available',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: black,
              fontSize: 14.sp,
            ),
          ),
        );
      }
      
      final displayedAmenities = isExpanded ? amenities : amenities.take(4).toList();
      
      return Column(
        children: [
          // NameView(
          //   name: 'Amenities',
          //   color: blue,
          //   secondName: isExpanded ? 'Show Less' : 'View All',
          //   secondColor: blue,
          //   onTap: toggleExpanded,
          // ),
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
      );
    });
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