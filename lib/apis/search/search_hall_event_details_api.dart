import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/search/search_hall_event_details_model.dart';

class SearchHallEventDetailsApi {
  // Fetch hall event details with event ID and date range
  Future<HallEventDetailsModel> getHallEventDetails({
    required String eventId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      // Build the URI with query parameters
      final uri = Uri.parse('${ApiConstant.BASE_URL}${ApiConstant.EVENT_DETAIL_URL}$eventId')
          .replace(queryParameters: {
        'start_date': startDate,
        'end_date': endDate,
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
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> data = json.decode(response.body);
        return HallEventDetailsModel.fromJson(data);
      } else {
        // Handle error response
        throw Exception(
            'Failed to fetch hall event details: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions
      throw Exception('Error fetching hall event details: $e');
    }
  }
}
