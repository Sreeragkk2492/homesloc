import 'dart:convert';
import 'package:homesloc/models/search/tourism_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:homesloc/core/constant/api_constant.dart';

class TourismDetailsApi {
  // Fetch fresh up room details
  Future<TourismDetailsModel> fetchTourismDetails({
    required String packageId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      // Build the URI with query parameters
      final uri = Uri.parse('${ApiConstant.BASE_URL}${ApiConstant.TOURISM_DETAIL_URL}/$packageId')
          .replace(queryParameters: {
        'start_date': startDate,
        'end_date': endDate,
      });

      // Print the URL for debugging
      print('Fetching tourism details from URL: ${uri.toString()}');
      print('package ID: $packageId');
      print('start date: $startDate');
      print('end date: $endDate');

      // Make the API request
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          // Add any required authentication headers here
        },
      );

      // Check if the request was successful
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> data = json.decode(response.body);
        return TourismDetailsModel.fromJson(data);
      } else {
        // Handle error response
        throw Exception('Failed to fetch tourism details: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error in fetchTourismDetails: $e');
      throw Exception('Error fetching tourism details: $e');
    }
  }
}
