import 'dart:convert';
import 'package:homesloc/core/api/api_helper.dart';
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/home/homescreen_model.dart';

class HomeScreenService {
  Future<HomescreenModel?> fetchHomeScreenData(int limit) async {
    try {
      final uri = Uri.parse(
          "${ApiConstant.BASE_URL}${ApiConstant.HOME_SCREEN_URL}?limit=$limit");

      final response = await ApiHelper.get(
        uri,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
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
