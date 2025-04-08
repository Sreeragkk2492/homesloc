import 'dart:convert';
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:homesloc/models/search/search_hall_model.dart';

class SearchHallApi {
  // Fetch halls with pagination and filters
  Future<HallModel> searchHalls({
    String? location,
    String? checkInDate,
    String? checkOutDate,
    int? guests,
    int page = 1,
    int limit = 10,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      // Build query parameters
      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
      };

      // Add optional parameters if provided
      if (location != null && location.isNotEmpty) {
        queryParams['location'] = location;
      }
      if (checkInDate != null && checkInDate.isNotEmpty) {
        queryParams['check_in_date'] = checkInDate;
      }
      if (checkOutDate != null && checkOutDate.isNotEmpty) {
        queryParams['check_out_date'] = checkOutDate;
      }
      if (guests != null) {
        queryParams['guests'] = guests.toString();
      }
      if (sortBy != null && sortBy.isNotEmpty) {
        queryParams['sort_by'] = sortBy;
      }
      if (sortOrder != null && sortOrder.isNotEmpty) {
        queryParams['sort_order'] = sortOrder;
      }

      // Build the URI with query parameters
      final uri =
          Uri.parse('${ApiConstant.BASE_URL}${ApiConstant.HALL_SEARCH_URL}')
              .replace(queryParameters: queryParams);

      // Make the API request
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          // Add any authentication headers if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> data = json.decode(response.body);
        return HallModel.fromJson(data);
      } else {
        // Handle error response
        throw Exception(
            'Failed to fetch halls: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions
      throw Exception('Error searching halls: $e');
    }
  }

 
}
