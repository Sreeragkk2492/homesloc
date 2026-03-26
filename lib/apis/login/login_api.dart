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
      final loginresponse =
          LoginModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      accessToken = loginresponse.accessToken.toString();
      refreshToken = loginresponse.refreshToken.toString();
      userId = loginresponse.userId.toString();
      userName = loginresponse.username.toString();
      userEmail = loginresponse.email.toString();

      ///write to strorage
      await storage.write(key: "access_token", value: accessToken);
      await storage.write(key: "refresh_token", value: refreshToken);
      await storage.write(key: "user_id", value: userId);
      await storage.write(key: "user_name", value: userName);
      await storage.write(key: "user_email", value: userEmail);

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

Future<LoginModel> googleLoginApi({required String idToken}) async {
  const storage = FlutterSecureStorage();
  try {
    final url =
        Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.GOOGLE_AUTH_URL}");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode({
        "id_token": idToken,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final loginresponse =
          LoginModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      accessToken = loginresponse.accessToken.toString();
      refreshToken = loginresponse.refreshToken.toString();
      userId = loginresponse.userId.toString();
      userName = loginresponse.username.toString();
      userEmail = loginresponse.email.toString();

      ///write to storage
      await storage.write(key: "access_token", value: accessToken);
      await storage.write(key: "refresh_token", value: refreshToken);
      await storage.write(key: "user_id", value: userId);
      await storage.write(key: "user_name", value: userName);
      await storage.write(key: "user_email", value: userEmail);

      return loginresponse;
    } else {
      throw Exception('Google login failed: ${response.body}');
    }
  } catch (e) {
    customSnackBar('Error', 'Google login failed: $e');
    throw Exception('Google login error: $e');
  }
}

Future<LoginModel> appleLoginApi({required String idToken}) async {
  const storage = FlutterSecureStorage();
  try {
    final url =
        Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.APPLE_AUTH_URL}");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode({
        "id_token": idToken,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final loginresponse =
          LoginModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      accessToken = loginresponse.accessToken.toString();
      refreshToken = loginresponse.refreshToken.toString();
      userId = loginresponse.userId.toString();
      userName = loginresponse.username.toString();
      userEmail = loginresponse.email.toString();

      ///write to storage
      await storage.write(key: "access_token", value: accessToken);
      await storage.write(key: "refresh_token", value: refreshToken);
      await storage.write(key: "user_id", value: userId);
      await storage.write(key: "user_name", value: userName);
      await storage.write(key: "user_email", value: userEmail);

      return loginresponse;
    } else {
      throw Exception('Apple login failed: ${response.body}');
    }
  } catch (e) {
    customSnackBar('Error', 'Apple login failed: $e');
    throw Exception('Apple login error: $e');
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
  required List<Map<String, dynamic>> services,
  required num commission,
  required String verificationToken,
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
        "services": services,
        "commission": commission,
        "verification_token": verificationToken,
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

Future<String> sendVerificationEmail({required String email}) async {
  try {
    final url =
        Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.Verify_EMAIL_URL}");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      customSnackBar('Success', 'OTP sent to email');
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body is Map<String, dynamic> &&
          body.containsKey('verification_token')) {
        return body['verification_token'];
      } else {
        // Fallback if token is not found but status is success, though unlikely based on requirement
        return "";
      }
    } else {
      throw Exception('Failed to send OTP: ${response.body}');
    }
  } catch (e) {
    customSnackBar('Error', 'Failed to send OTP: $e');
    throw Exception('Send OTP error: $e');
  }
}

Future<String> verifyEmailOtp(
    {required String verificationToken, required String otp}) async {
  try {
    final url =
        Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.Verify_OTP_URL}");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"verification_token": verificationToken, "otp": otp}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      // Assuming the token is in 'verification_token' or similar field.
      // Adjust based on actual API response.
      // If the response is just the token string or inside a data object:
      if (body is Map<String, dynamic> &&
          body.containsKey('verification_token')) {
        return body['verification_token'];
      } else if (body is Map<String, dynamic> && body.containsKey('token')) {
        return body['token'];
      }
      // Fallback or explicit check needed if API structure is known.
      // For now assuming it returns a JSON with verification_token
      return body['verification_token'] ?? "";
    } else {
      throw Exception('Failed to verify OTP: ${response.body}');
    }
  } catch (e) {
    customSnackBar('Error', 'Failed to verify OTP: $e');
    throw Exception('Verify OTP error: $e');
  }
}

Future<String> requestPasswordResetApi({required String email}) async {
  try {
    final url = Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.REQUEST_PASSWORD_RESET_URL}");
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      customSnackBar('Success', 'Verification code sent to email');
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      return body['verification_token'] ?? "";
    } else {
      throw Exception('Failed to request password reset: ${response.body}');
    }
  } catch (e) {
    customSnackBar('Error', 'Failed to request password reset: $e');
    throw Exception('Request password reset error: $e');
  }
}

Future<void> resetPasswordWithTokenApi({
  required String verificationToken,
  required String otp,
  required String newPassword,
  required String confirmPassword,
}) async {
  try {
    final url = Uri.parse(
        "${ApiConstant.BASE_URL}${ApiConstant.RESET_PASSWORD_WITH_TOKEN_URL}");
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode({
        "verification_token": verificationToken,
        "otp": otp,
        "new_password": newPassword,
        "confirm_password": confirmPassword,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      customSnackBar('Success', 'Password reset successfully');
    } else {
      throw Exception('Failed to reset password: ${response.body}');
    }
  } catch (e) {
    customSnackBar('Error', 'Failed to reset password: $e');
    throw Exception('Reset password error: $e');
  }
}
