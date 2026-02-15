import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homesloc/core/common/global_variables.dart';
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/search/search_hotel_model.dart';
import 'package:http/http.dart' as http;

class SearchHotelService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<SearchHotelModel?> searchHotels({
    String? location,
    String? checkIn,
    String? checkOut,
    int? guestCount,
    int? roomCount,
    int? minPrice,
    int? maxPrice,
    String? propertyType,
    String? sortBy,
    int? limit,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (location != null && location.isNotEmpty) {
        queryParams['location'] = location;
      }
      if (checkIn != null) queryParams['check_in_date'] = checkIn;
      if (checkOut != null) queryParams['check_out_date'] = checkOut;
      if (guestCount != null)
        queryParams['guest_count'] = guestCount.toString();
      if (roomCount != null) queryParams['room_count'] = roomCount.toString();
      if (minPrice != null) queryParams['min_price'] = minPrice.toString();
      if (maxPrice != null) queryParams['max_price'] = maxPrice.toString();
      if (propertyType != null) queryParams['property_type'] = propertyType;
      if (sortBy != null) queryParams['sort_by'] = sortBy;
      if (limit != null) queryParams['limit'] = limit.toString();

      final uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.HOTEL_SEARCH_URL)
          .replace(queryParameters: queryParams);

      print('Search URL: $uri');

      // Attempt to get token from storage if global accessToken is empty
      String? token = accessToken;
      if (token.isEmpty) {
        token = await _storage.read(key: 'access_token');
      }

      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        },
      );

      print('Search Response Code: ${response.statusCode}');
      // print('Search Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return SearchHotelModel.fromJson(jsonResponse);
      } else {
        print('Failed to search hotels: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error searching hotels: $e');
      return null;
    }
  }

  Future<SearchHotelModel?> searchAccommodationsGroupedByHotel({
    int page = 1,
    int pageSize = 10,
    String sortBy = 'created_at',
    String sortOrder = 'desc',
    String? name,
    String? search,
    String? startDate, // checkin
    String? endDate, // checkout
    int? minPrice,
    int? maxPrice,
  }) async {
    try {
      final queryParams = <String, String>{
        'page': page.toString(),
        'page_size': pageSize.toString(),
        'sort_by': sortBy,
        'sort_order': sortOrder,
      };

      if (name != null) queryParams['name'] = name;
      if (search != null) queryParams['search'] = search;
      if (startDate != null) queryParams['start_date'] = startDate;
      if (endDate != null) queryParams['end_date'] = endDate;
      if (minPrice != null) queryParams['min_price'] = minPrice.toString();
      if (maxPrice != null) queryParams['max_price'] = maxPrice.toString();

      final uri = Uri.parse(
              ApiConstant.BASE_URL + ApiConstant.HOTEL_FULLPROPERTY_ROOM_URL)
          .replace(queryParameters: queryParams);

      print('Grouped Search URL: $uri');

      // Attempt to get token from storage if global accessToken is empty
      String? token = accessToken;
      if (token.isEmpty) {
        token = await _storage.read(key: 'access_token');
      }

      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        },
      );

      print('Grouped Search Response Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return SearchHotelModel.fromJson(jsonResponse);
      } else {
        print('Failed to search hotels grouped: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error searching hotels grouped: $e');
      return null;
    }
  }

  Future<SearchHotelModel?> searchAccommodationsGroupedByHall({
    int page = 1,
    int pageSize = 10,
    String sortBy = 'created_at',
    String sortOrder = 'desc',
    bool isActive = true,
  }) async {
    try {
      final queryParams = <String, String>{
        'page': page.toString(),
        'page_size': pageSize.toString(),
        'sort_by': sortBy,
        'sort_order': sortOrder,
        'is_active': isActive.toString(),
      };

      final uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.HALL_SEARCH_URL)
          .replace(queryParameters: queryParams);

      print('Hall Search URL: $uri');

      // Attempt to get token from storage if global accessToken is empty
      String? token = accessToken;
      if (token.isEmpty) {
        token = await _storage.read(key: 'access_token');
      }

      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        },
      );

      print('Hall Search Response Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return SearchHotelModel.fromJson(jsonResponse);
      } else {
        print('Failed to search halls: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error searching halls: $e');
      return null;
    }
  }

  Future<SearchHotelModel?> searchFreshup({
    int page = 1,
    int pageSize = 10,
    String? location,
    String? checkIn,
    String? checkOut,
    int? guestCount,
    int? roomCount,
  }) async {
    try {
      final queryParams = <String, String>{
        'page': page.toString(),
        'page_size': pageSize.toString(),
      };

      if (location != null && location.isNotEmpty) {
        queryParams['location'] = location;
      }
      if (checkIn != null) queryParams['check_in_date'] = checkIn;
      if (checkOut != null) queryParams['check_out_date'] = checkOut;
      if (guestCount != null)
        queryParams['guest_count'] = guestCount.toString();
      if (roomCount != null) queryParams['room_count'] = roomCount.toString();

      final uri =
          Uri.parse(ApiConstant.BASE_URL + ApiConstant.FRESHUP_SEARCH_URL)
              .replace(queryParameters: queryParams);

      print('Freshup Search URL: $uri');

      String? token = accessToken;
      if (token.isEmpty) {
        token = await _storage.read(key: 'access_token');
      }

      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        },
      );

      print('Freshup Search Response Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return SearchHotelModel.fromJson(jsonResponse);
      } else {
        print('Failed to search freshups: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error searching freshups: $e');
      return null;
    }
  }
}
