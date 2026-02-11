import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/home/homescreen_model.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreenService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<HomescreenModel?> fetchHomeScreenData(int limit) async {
    try {
      final uri = Uri.parse(
          "${ApiConstant.BASE_URL}${ApiConstant.HOME_SCREEN_URL}?limit=$limit");

      String? token = await _storage.read(key: 'access_token');

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return HomescreenModel.fromJson(data);
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
}
