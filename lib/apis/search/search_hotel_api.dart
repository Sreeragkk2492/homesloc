import 'package:homesloc/models/search/search_hotel_model.dart';
import 'package:homesloc/core/dummy_data/dummy_data.dart';
// import 'package:http/http.dart' as http;

class SearchHotelService {
  Future<SearchHotelModel?> searchHotels({
    String? name,
    String? location,
    String? checkIn,
    String? checkOut,
    int? guestCount,
    int? minPrice,
    int? maxPrice,
    bool isActive = true,
    int? starRating,
    int page = 1,
    int pageSize = 10,
    String sortBy = "created_at",
    String sortOrder = "desc",
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      return DummyData.searchHotelModel;
    } catch (e) {
      print('Error searching hotels: $e');
      return null;
    }
  }
}
