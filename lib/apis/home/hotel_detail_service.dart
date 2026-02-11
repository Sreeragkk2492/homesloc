import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/home/hotel_detail_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HotelDetailService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<HotelDetailModel?> fetchHotelDetails(String hotelId) async {
    try {
      final uri = Uri.parse(
          "${ApiConstant.BASE_URL}${ApiConstant.HOTEL_DETAILS_URL}/$hotelId");

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
        return HotelDetailModel.fromJson(data);
      } else {
        print('Failed to load hotel details: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching hotel details: $e');
      return null;
    }
  }
}
