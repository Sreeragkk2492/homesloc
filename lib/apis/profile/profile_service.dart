import 'dart:convert';
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/core/api/api_helper.dart';
import 'package:homesloc/models/profile/user_profile_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileService {
  Future<UserProfileModel?> getUserProfile() async {
    try {
      // API Helper requires the full URI
      final uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.PROFILE_URL);

      // The ApiHelper.get usually handles attaching the Bearer token automatically
      // if it's stored in global_variables.dart or local storage.
      final response = await ApiHelper.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return UserProfileModel.fromJson(data);
      } else {
        print('Failed to load profile. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception caught while fetching user profile: $e');
      return null;
    }
  }

  Future<bool> updateUserProfile(Map<String, dynamic> data) async {
    try {
      final uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.PROFILE_URL);

      final response = await ApiHelper.put(
        uri,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update profile. Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception caught while updating user profile: $e');
      return false;
    }
  }
}
