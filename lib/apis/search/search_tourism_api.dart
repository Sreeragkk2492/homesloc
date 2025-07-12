import 'dart:convert';
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/search/search_tourist_package_model.dart';
import 'package:http/http.dart' as http;

class SearchTourismApi {
  // Fetch halls with pagination and filters
  Future<SearchTouristPackageModel> searchTourism({
    String? packageName,
    String? destination,
    int? durationDays,
    String? startDate,
    String? endDate,
    bool? isActive,
    num? minPrice,
    num? maxPrice,
    String? currency,
    int page = 1,
    int pageSize = 100,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      // Build query parameters
      final queryParams = {
        'page': page.toString(),
      };

      if (packageName != null && packageName.isNotEmpty) {
        queryParams['package_name'] = packageName;
      }
      if (destination != null && destination.isNotEmpty) {
        queryParams['destination'] = destination;
      }
      if (durationDays != null) {
        queryParams['duration_days'] = durationDays.toString();
      }
      if (startDate != null && startDate.isNotEmpty) {
        queryParams['start_date'] = startDate;
      }
      if (endDate != null && endDate.isNotEmpty) {
        queryParams['end_date'] = endDate;
      }
      if (isActive != null) {
        queryParams['is_active'] = isActive.toString();
      }
      if (minPrice != null) {
        queryParams['min_price'] = minPrice.toString();
      }
      if (maxPrice != null) {
        queryParams['max_price'] = maxPrice.toString();
      }
      if (currency != null && currency.isNotEmpty) {
        queryParams['currency'] = currency;
      }
      if (pageSize != null) {
        queryParams['page_size'] = pageSize.toString();
      }
      if (sortBy != null && sortBy.isNotEmpty) {
        queryParams['sort_by'] = sortBy;
      }
      if (sortOrder != null && sortOrder.isNotEmpty) {
        queryParams['sort_order'] = sortOrder;
      }

      // Build the URI with query parameters
      final uri =
          Uri.parse('${ApiConstant.BASE_URL}${ApiConstant.TOURIST_PACKAGE_SEARCH_URL}')
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
        return SearchTouristPackageModel.fromJson(data);
      } else {
        // Handle error response
        throw Exception(
            'Failed to fetch tourism packages: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions
      throw Exception('Error searching tourism packages: $e');
    }
  }

 
}
