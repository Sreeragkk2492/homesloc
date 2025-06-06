import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/search/fresh_up_room_details_model.dart';

class FreshUpRoomDetailsApi {
  // Fetch fresh up room details
  Future<FreshUpRoomDetailsModel> fetchFreshUpRoomDetails({
    required String freshUpId,
    required String priceMethod,
    required String date,
  }) async {
    try {
      // Build the URI with query parameters
      final uri = Uri.parse('${ApiConstant.BASE_URL}/api/v1/search/freshup-room/$freshUpId')
          .replace(queryParameters: {
        'price_method': priceMethod,
        'date': date,
      });

      // Print the URL for debugging
      print('Fetching fresh up room details from URL: ${uri.toString()}');
      print('Fresh Up ID: $freshUpId');
      print('Price Method: $priceMethod');
      print('Date: $date');

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
        return FreshUpRoomDetailsModel.fromJson(data);
      } else {
        // Handle error response
        throw Exception('Failed to fetch fresh up room details: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error in fetchFreshUpRoomDetails: $e');
      throw Exception('Error fetching fresh up room details: $e');
    }
  }
}
