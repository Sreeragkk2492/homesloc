import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/search/search_fresh_up_model.dart';

class SearchFreshUpApi {
  // Fetch fresh up services with search parameters
  Future<SearchFreshUpModel> searchFreshUp({
    String? checkIn,
    String? checkOut,
    bool? isActive,
    int page = 1,
    int pageSize = 100,
    String? sortBy,
    String? sortOrder,
   // bool isHotel = true,
  }) async {
    try {
      // Build the URI with query parameters
      final uri = Uri.parse('${ApiConstant.BASE_URL}${ApiConstant.SEARCH_FRESH_UP_URL}')
          .replace(queryParameters: {
        if (checkIn != null) 'check_in': checkIn,
        if (checkOut != null) 'check_out': checkOut,
        if (isActive != null) 'is_active': isActive.toString(),
        'page': page.toString(),
        'page_size': pageSize.toString(),
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
       // 'is_hotel': isHotel.toString(),
      });

      // Make the API request
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // Add any authentication headers if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> data = json.decode(response.body);
        return SearchFreshUpModel.fromJson(data);
      } else {
        // Handle error response
        throw Exception(
            'Failed to fetch fresh up services: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions
      throw Exception('Error fetching fresh up services: $e');
    }
  }
}
