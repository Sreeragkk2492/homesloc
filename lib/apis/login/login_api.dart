import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homesloc/core/common/global_variables.dart';
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/auth/login_model.dart';
import 'package:homesloc/widgets/custom_snackbar.dart';
import 'package:http/http.dart' as http;

Future<LoginModel> loginApi(
    {required String username, required String password}) async {
  const storage = FlutterSecureStorage();
  try {
    final url = Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.LOGIN_URL}");

  //  print(url);

    final response = await http.post(url, headers: {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    }, body: {
      'grant_type': 'password',
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      final loginresponse = LoginModel.fromJson(jsonDecode(response.body));

      accessToken = loginresponse.accessToken.toString();
      refreshToken = loginresponse.refreshToken.toString();
      userId = loginresponse.userId.toString();
      // username=loginresponse.username

      ///write to strorage
      await storage.write(key: "access_token", value: accessToken);
      await storage.write(key: "refresh_token", value: refreshToken);
      await storage.write(key: "user_id", value: userId);

      return loginresponse;
    } else {
      final errorBody = jsonDecode(response.body);
      if (errorBody.toString().contains('Invalid')) {
        customSnackBar('oops', 'Invalid Username or Password');
      } else {
        customSnackBar('oops', errorBody.toString());
      }

      throw Exception(
          'Failed to login: ${response.statusCode}, message: $errorBody');
    }
  } catch (e) {
    // Handle different error types in a single catch block
    if (e is SocketException) {
      customSnackBar('Network Error',
          'No internet connection. Please check your network settings.');
      throw Exception('Network error: No internet connection');
    } else if (e is TimeoutException) {
      customSnackBar('Network Error', 'Request timed out. Please try again.');
      throw Exception('Network error: Request timed out');
    } else if (e is http.ClientException) {
      customSnackBar('Network Error',
          'Unable to connect to the server. Please try again later.');
      throw Exception('Network error: Unable to connect to server');
    } else if (e is FormatException) {
      customSnackBar('Error', 'Received invalid response from server');
      throw Exception('Invalid server response');
    } else {
      customSnackBar(
          'Error', 'An unexpected error occurred. Please try again later.');
      throw Exception('Login error: $e');
    }
  }
}
