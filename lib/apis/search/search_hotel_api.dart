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
    //String accommodationType = "FULL_PROPERTY",
    String sortBy = "created_at",
    String sortOrder = "desc",
  }) async {
    try {
      // Build query parameters
      Map<String, String> queryParams = {
        if (name != null && name.isNotEmpty) 'name': name,
        if (location != null && location.isNotEmpty) 'location': location,
        if (checkIn != null && checkIn.isNotEmpty) 'check_in': checkIn,
        if (checkOut != null && checkOut.isNotEmpty) 'check_out': checkOut,
        if (guestCount != null && guestCount > 0) 'guest_count': guestCount.toString(),
        if (minPrice != null && minPrice > 0) 'min_price': minPrice.toString(),
        if (maxPrice != null && maxPrice > 0) 'max_price': maxPrice.toString(),
        if (starRating != null && starRating > 0) 'star_rating': starRating.toString(),
       // if (accommodationType != null && accommodationType.isNotEmpty) 'accommodation_type': accommodationType,
        'is_active': isActive.toString(),
        'page': page.toString(),
        'page_size': pageSize.toString(),
        'sort_by': sortBy,
        'sort_order': sortOrder,
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
        try {
          final jsonData = json.decode(response.body);
          if (jsonData == null) {
            print('❌ API Error: Response body is null');
            return null;
          }
          return SearchHotelModel.fromJson(jsonData);
        } catch (e) {
          print('❌ Error parsing JSON: $e');
          return null;
        }
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
