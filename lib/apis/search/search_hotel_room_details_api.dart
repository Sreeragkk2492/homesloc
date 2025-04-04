import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/search/room_details_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchHotelRoomDetailsApi {
  Future<RoomDetailsModel> getRoomDetails({
    required String roomId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final url = Uri.parse('${ApiConstant.BASE_URL}${ApiConstant.HOTEL_SEARCH_ROOM_DETAILS_URL}/$roomId')
          .replace(queryParameters: {
        'start_date': startDate,
        'end_date': endDate,
      });

      print('API URL: $url');
      
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return RoomDetailsModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch room details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getRoomDetails: $e');
      throw Exception('Error fetching room details: $e');
    }
  }
}
