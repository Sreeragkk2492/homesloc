import 'dart:convert';
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/search/search_hotel_model.dart';
import 'package:homesloc/core/api/api_helper.dart';

import 'package:homesloc/models/search/tourism_search_model.dart';
import 'package:homesloc/models/tourism/tourism_detail_model.dart';
import 'package:homesloc/models/tourism/tourism_availability_model.dart';

class SearchHotelService {
  Future<TourismSearchModel?> searchTourism({
    int page = 1,
    int pageSize = 10,
    String sortBy = 'created_at',
    String sortOrder = 'desc',
    String? location,
  }) async {
    try {
      final queryParams = <String, String>{
        'page': page.toString(),
        'page_size': pageSize.toString(),
        'sort_by': sortBy,
        'sort_order': sortOrder,
      };

      if (location != null && location.isNotEmpty) {
        queryParams['location'] = location;
      }

      final uri =
          Uri.parse(ApiConstant.BASE_URL + ApiConstant.TOURISM_SEARCH_URL)
              .replace(queryParameters: queryParams);

      print('Tourism Search URL: $uri');

      final response = await ApiHelper.get(
        uri,
      );

      print('Tourism Search Response Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return TourismSearchModel.fromJson(jsonResponse);
      } else {
        print('Failed to search tourism: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error searching tourism: $e');
      return null;
    }
  }

  Future<SearchHotelModel?> searchHotels({
    int page = 1,
    int pageSize = 10,
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
      if (minPrice != null) queryParams['min_price'] = minPrice.toString();
      if (maxPrice != null) queryParams['max_price'] = maxPrice.toString();
      if (propertyType != null) queryParams['property_type'] = propertyType;
      if (sortBy != null) queryParams['sort_by'] = sortBy;
      if (limit != null) queryParams['limit'] = limit.toString();

      final uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.HOTEL_SEARCH_URL)
          .replace(queryParameters: queryParams);

      print('Search URL: $uri');

      final response = await ApiHelper.get(
        uri,
      );

      print('Search Response Code: ${response.statusCode}');
      // print('Search Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
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

      final response = await ApiHelper.get(
        uri,
      );

      print('Grouped Search Response Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
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
    String? startDate,
    String? endDate,
    String? location,
  }) async {
    try {
      final queryParams = <String, String>{
        'page': page.toString(),
        'page_size': pageSize.toString(),
        'sort_by': sortBy,
        'sort_order': sortOrder,
        'is_active': isActive.toString(),
      };

      if (startDate != null) queryParams['check_in_date'] = startDate;
      if (endDate != null) queryParams['check_out_date'] = endDate;
      if (location != null && location.isNotEmpty) {
        queryParams['location'] = location;
      }

      final uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.HALL_SEARCH_URL)
          .replace(queryParameters: queryParams);

      print('Hall Search URL: $uri');

      final response = await ApiHelper.get(
        uri,
      );

      print('Hall Search Response Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
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

      final response = await ApiHelper.get(
        uri,
      );

      print('Freshup Search Response Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
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

  Future<TourismDetailModel?> fetchTourismDetails({
    required String packageId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final queryParams = <String, String>{
        'start_date': startDate,
        'end_date': endDate,
      };

      final uri = Uri.parse(ApiConstant.BASE_URL +
              ApiConstant.TOURISM_DETAILS_URL +
              packageId)
          .replace(queryParameters: queryParams);

      final response = await ApiHelper.get(uri);

      if (response.statusCode == 200) {
        return TourismDetailModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      } else {
        print('Failed to fetch tourism details: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching tourism details: $e');
      return null;
    }
  }

  Future<TourismAvailabilityModel?> checkTourismAvailability({
    required String packageId,
    required String checkin,
  }) async {
    try {
      final queryParams = <String, String>{
        'package_id': packageId,
        'checkin': checkin,
      };

      final uri =
          Uri.parse(ApiConstant.BASE_URL + ApiConstant.TOURISM_AVAILABILITY_URL)
              .replace(queryParameters: queryParams);

      final response = await ApiHelper.get(uri);

      if (response.statusCode == 200) {
        return TourismAvailabilityModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      } else {
        print('Failed to check tourism availability: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error checking tourism availability: $e');
      return null;
    }
  }
}
