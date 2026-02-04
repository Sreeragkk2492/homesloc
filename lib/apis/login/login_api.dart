import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homesloc/core/common/global_variables.dart';
import 'package:homesloc/models/auth/login_model.dart';
import 'package:homesloc/widgets/custom_snackbar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:homesloc/core/constant/api_constant.dart';

Future<LoginModel> loginApi(
    {required String username, required String password}) async {
  const storage = FlutterSecureStorage();
  try {
    final url = Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.LOGIN_URL}");

    // print("------------------------------------------------------------------");
    // print("Initiating Login Request");
    // print("URL: $url");
    // print("Payload: username=$username&password=$password");
    // print("------------------------------------------------------------------");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "accept": "application/json"
      },
      body: {
        "username": username,
        "password": password,
      },
    );

    // print("------------------------------------------------------------------");
    // print("Login Response Received");
    // print("Status Code: ${response.statusCode}");
    // print("Body: ${response.body}");
    // print("------------------------------------------------------------------");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final loginresponse = LoginModel.fromJson(jsonDecode(response.body));

      accessToken = loginresponse.accessToken.toString();
      refreshToken = loginresponse.refreshToken.toString();
      userId = loginresponse.userId.toString();
      userName = loginresponse.username.toString();

      ///write to strorage
      await storage.write(key: "access_token", value: accessToken);
      await storage.write(key: "refresh_token", value: refreshToken);
      await storage.write(key: "user_id", value: userId);
      await storage.write(key: "user_name", value: userName);

      return loginresponse;
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  } catch (e) {
    print("------------------------------------------------------------------");
    print("Login Request FAILED");
    print("Error: $e");
    print("------------------------------------------------------------------");
    customSnackBar('Error', 'Login failed: $e');
    throw Exception('Login error: $e');
  }
}

Future<void> registerUser({
  required String username,
  required String password,
  required String name,
  required String email,
  required String phoneNumber,
  required String userType,
  required String registrationNumber,
  required String profileImageUrl,
}) async {
  try {
    final url =
        Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.REGISTER_USER_URL}");

    // print("------------------------------------------------------------------");
    // print("Initiating Registration Request");
    // print("URL: $url");
    // print("Payload: ${jsonEncode({
    //       "username": username,
    //       "password": password,
    //       "name": name,
    //       "email": email,
    //       "phone_number": phoneNumber,
    //       "user_type": userType,
    //       "registration_number": registrationNumber,
    //       "profile_image_url": profileImageUrl,
    //     })}");
    // print("------------------------------------------------------------------");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "user_type": userType,
        "registration_number": registrationNumber,
        "profile_image_url": profileImageUrl,
      }),
    );

    // print("------------------------------------------------------------------");
    // print("Register Response Received");
    // print("Status Code: ${response.statusCode}");
    // print("Body: ${response.body}");
    // print("------------------------------------------------------------------");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to register user: ${response.body}');
    }
  } catch (e) {
    print("------------------------------------------------------------------");
    print("Register Request FAILED");
    print("Error: $e");
    print("------------------------------------------------------------------");
    customSnackBar('Error', 'Registration failed: $e');
    throw Exception('Registration error: $e');
  }
}
