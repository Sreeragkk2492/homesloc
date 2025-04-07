import 'package:get/get.dart';
import 'package:homesloc/apis/search/search_hotel_full_property_api.dart';
import 'package:homesloc/models/search/hotel_full_property_model.dart';

class SearchHotelFullPropertiesController extends GetxController {
  final SearchHotelFullPropertyApi _api = SearchHotelFullPropertyApi();
  
  // Observable variables to track state
  final Rx<HotelFullPropertyModel?> fullPropertyDetails = Rx<HotelFullPropertyModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  
  // Function to fetch full property details
  Future<void> fetchFullPropertyDetails({
    required String propertyId,
    required String startDate,
    required String endDate,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    
    print('Controller: Fetching full property details for property ID: $propertyId');
    print('Controller: Start date: $startDate, End date: $endDate');
    
    try {
      final result = await _api.getFullPropertyDetails(
        propertyId: propertyId,
        startDate: startDate,
        endDate: endDate,
      );
      
      fullPropertyDetails.value = result;
      print('Controller: Successfully fetched full property details');
    } catch (e) {
      print('Controller: Error fetching full property details: $e');
      errorMessage.value = 'Controller: Error fetching full property details: $e';
    } finally {
      isLoading.value = false;
    }
  }
  
  // Function to clear the data
  void clearFullPropertyDetails() {
    fullPropertyDetails.value = null;
    errorMessage.value = '';
  }
  
  // Helper function to get amenities
  List<String> getAmenities() {
    if (fullPropertyDetails.value?.amenityIds == null) {
      return [];
    }
    return fullPropertyDetails.value!.amenityIds!
        .map((amenity) => amenity.name ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
  }
  
  // Helper function to get rooms
  List<Room> getRooms() {
    if (fullPropertyDetails.value?.rooms == null) {
      return [];
    }
    return fullPropertyDetails.value!.rooms!;
  }
  
  // Helper function to get hotel details
  HotelDetails? getHotelDetails() {
    return fullPropertyDetails.value?.hotelDetails;
  }
  
  // Helper function to get policies
  Policies? getPolicies() {
    return fullPropertyDetails.value?.hotelDetails?.policies;
  }
  
  // Helper function to get legal policies
  LegalPolicies? getLegalPolicies() {
    return fullPropertyDetails.value?.hotelDetails?.legalPolicies;
  }
  
  // Helper function to get nearby attractions
  List<NearByAttraction> getNearbyAttractions() {
    if (fullPropertyDetails.value?.hotelDetails?.nearByAttraction == null) {
      return [];
    }
    return fullPropertyDetails.value!.hotelDetails!.nearByAttraction!;
  }
  
  // Helper function to get gallery images
  List<String> getGalleryImages() {
    if (fullPropertyDetails.value?.hotelDetails?.galleryImages == null) {
      return [];
    }
    return fullPropertyDetails.value!.hotelDetails!.galleryImages!;
  }
  
  // Helper function to get videos
  List<String> getVideos() {
    if (fullPropertyDetails.value?.hotelDetails?.videos == null) {
      return [];
    }
    return fullPropertyDetails.value!.hotelDetails!.videos!;
  }
}
