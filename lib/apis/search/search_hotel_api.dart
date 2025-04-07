import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/search/search_hotel_model.dart';


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
      // Build query parameters
      Map<String, String> queryParams = {
        if (name != null) 'name': name,
        if (location != null) 'location': location,
        if (checkIn != null) 'check_in': checkIn,
        if (checkOut != null) 'check_out': checkOut,
        if (guestCount != null) 'guest_count': guestCount.toString(),
        if (minPrice != null) 'min_price': minPrice.toString(),
        if (maxPrice != null) 'max_price': maxPrice.toString(),
        if (starRating != null) 'star_rating': starRating.toString(),
         'is_active': 'true',
        // 'page': page.toString(),
        // 'page_size': pageSize.toString(),
        // 'sort_by': sortBy,
        // 'sort_order': sortOrder,
      };

      // Construct URL with query parameters
      final uri = Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.HOTEL_SEARCH_URL}")
          .replace(queryParameters: queryParams);
      
      // Print the full URL for debugging
      print('🔍 SEARCH HOTEL API URL: ${uri.toString()}');
      print('🔍 SEARCH HOTEL API PARAMETERS:');
      queryParams.forEach((key, value) {
        print('   $key: $value');
      });
      
      // Add proper headers
      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          // Add authorization if needed
          // 'Authorization': 'Bearer YOUR_ACCESS_TOKEN'
        },
      );

      // Print response status and headers
      print('🔍 SEARCH HOTEL API RESPONSE STATUS: ${response.statusCode}');
      print('🔍 SEARCH HOTEL API RESPONSE HEADERS:');
      response.headers.forEach((key, value) {
        print('   $key: $value');
      });
      
      // Print response body (truncated if too long)
      final responseBody = response.body;
      if (responseBody.length > 1000) {
        print('🔍 SEARCH HOTEL API RESPONSE BODY (truncated):');
        print('   ${responseBody.substring(0, 1000)}...');
        print('   [Response truncated. Full length: ${responseBody.length} characters]');
      } else {
        print('🔍 SEARCH HOTEL API RESPONSE BODY:');
        print('   $responseBody');
      }

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return SearchHotelModel.fromJson(jsonData);
      } else {
        print('❌ API Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to search hotels: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error searching hotels: $e');
      return null;
    }
  }
}
