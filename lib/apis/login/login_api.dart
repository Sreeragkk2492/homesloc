import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homesloc/core/common/global_variables.dart';
import 'package:homesloc/models/auth/login_model.dart';
import 'package:homesloc/widgets/custom_snackbar.dart';
import 'package:homesloc/core/dummy_data/dummy_data.dart';

Future<LoginModel> loginApi(
    {required String username, required String password}) async {
  const storage = FlutterSecureStorage();
  try {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final loginresponse = DummyData.loginModel;

    accessToken = loginresponse.accessToken.toString();
    refreshToken = loginresponse.refreshToken.toString();
    userId = loginresponse.userId.toString();

    ///write to strorage
    await storage.write(key: "access_token", value: accessToken);
    await storage.write(key: "refresh_token", value: refreshToken);
    await storage.write(key: "user_id", value: userId);

    return loginresponse;
  } catch (e) {
    customSnackBar(
        'Error', 'An unexpected error occurred. Please try again later.');
    throw Exception('Login error: $e');
  }
}
