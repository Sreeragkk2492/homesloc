import 'dart:convert';
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:homesloc/models/search/hotel_full_property_model.dart';

class SearchHotelFullPropertyApi {
  

  Future<HotelFullPropertyModel> getFullPropertyDetails({
    required String propertyId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      // Print the URL for debugging
      final url = '${ApiConstant.BASE_URL}${ApiConstant.HOTEL_SEARCH_FULL_PROPERTY_URL}/$propertyId?start_date=$startDate&end_date=$endDate';
      print('Fetching full property details from: $url');
      print('Property ID: $propertyId');
      print('Start date: $startDate, End date: $endDate');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
        },
      );

      // Print response status and body for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return HotelFullPropertyModel.fromJson(jsonData);
      } else {
        final errorBody = response.body.isNotEmpty ? json.decode(response.body) : null;
        final errorMessage = errorBody != null && errorBody['detail'] != null 
            ? errorBody['detail'] 
            : 'Failed to load full property details: ${response.statusCode}';
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Exception in getFullPropertyDetails: $e');
      throw Exception('Error fetching full property details: $e');
    }
  }
}
