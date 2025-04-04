import 'dart:convert';

import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/home/homescreen_model.dart';
import 'package:http/http.dart' as http;

class HomeScreenService {
  Future<HomescreenModel?> fetchHomeScreenData(int limit) async {
    try {
      final uri = Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.HOME_SCREEN_URL}")
          .replace(queryParameters: {'limit': limit.toString()});
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer <YOUR_ACCESS_TOKEN>'  // Replace with your access token
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return HomescreenModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
}
