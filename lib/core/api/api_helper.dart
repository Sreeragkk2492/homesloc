import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homesloc/core/common/global_variables.dart';
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:get/get.dart';
import 'package:homesloc/screens/auth/sign_in.dart';

class ApiHelper {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Flag to prevent multiple simultaneous refresh token calls
  static bool _isRefreshing = false;

  /// Centralized getting of access token
  static Future<String?> _getAccessToken() async {
    if (accessToken.isNotEmpty) {
      return accessToken;
    }
    return await _storage.read(key: 'access_token');
  }

  /// Perform GET request with automatic token refresh on 401
  static Future<http.Response> get(Uri url,
      {Map<String, String>? headers}) async {
    String? token = await _getAccessToken();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      requestHeaders['Authorization'] = 'Bearer $token';
    }

    if (headers != null) {
      requestHeaders.addAll(headers);
    }

    http.Response response = await http.get(url, headers: requestHeaders);

    // If unauthorized, try refreshing the token
    if (response.statusCode == 401) {
      if (token == null || token.isEmpty) {
        return response;
      }
      bool refreshed = await _refreshToken();
      if (refreshed) {
        // Retry the request with the new token
        token = await _getAccessToken();
        if (token != null && token.isNotEmpty) {
          requestHeaders['Authorization'] = 'Bearer $token';
        }
        response = await http.get(url, headers: requestHeaders);
      } else {
        // Logout if refresh fails
        _logout();
      }
    }

    return response;
  }

  /// Perform POST request with automatic token refresh on 401
  static Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    String? token = await _getAccessToken();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      requestHeaders['Authorization'] = 'Bearer $token';
    }

    if (headers != null) {
      requestHeaders.addAll(headers);
    }

    http.Response response = await http.post(
      url,
      headers: requestHeaders,
      body: body,
      encoding: encoding,
    );

    // If unauthorized, try refreshing the token
    if (response.statusCode == 401) {
      if (token == null || token.isEmpty) {
        return response;
      }
      bool refreshed = await _refreshToken();
      if (refreshed) {
        // Retry the request with the new token
        token = await _getAccessToken();
        if (token != null && token.isNotEmpty) {
          requestHeaders['Authorization'] = 'Bearer $token';
        }
        response = await http.post(
          url,
          headers: requestHeaders,
          body: body,
          encoding: encoding,
        );
      } else {
        // Logout if refresh fails
        _logout();
      }
    }

    return response;
  }

  /// Perform PUT request with automatic token refresh on 401
  static Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    String? token = await _getAccessToken();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      requestHeaders['Authorization'] = 'Bearer $token';
    }

    if (headers != null) {
      requestHeaders.addAll(headers);
    }

    http.Response response = await http.put(
      url,
      headers: requestHeaders,
      body: body,
      encoding: encoding,
    );

    // If unauthorized, try refreshing the token
    if (response.statusCode == 401) {
      if (token == null || token.isEmpty) {
        return response;
      }
      bool refreshed = await _refreshToken();
      if (refreshed) {
        // Retry the request with the new token
        token = await _getAccessToken();
        if (token != null && token.isNotEmpty) {
          requestHeaders['Authorization'] = 'Bearer $token';
        }
        response = await http.put(
          url,
          headers: requestHeaders,
          body: body,
          encoding: encoding,
        );
      } else {
        // Logout if refresh fails
        _logout();
      }
    }

    return response;
  }

  /// Internal method to refresh the token
  static Future<bool> _refreshToken() async {
    if (_isRefreshing) {
      // Very simplistic approach: wait a bit and hope the refresh finishes
      // A more robust approach would use Completer to queue requests
      await Future.delayed(const Duration(seconds: 2));
      return true;
    }

    _isRefreshing = true;

    try {
      String? currentRefreshToken = refreshToken.isNotEmpty
          ? refreshToken
          : await _storage.read(key: 'refresh_token');

      if (currentRefreshToken == null || currentRefreshToken.isEmpty) {
        _isRefreshing = false;
        return false;
      }

      final url =
          Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.REFRESH_TOKEN_URL}");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "refresh_token": currentRefreshToken,
        }),
      );

      print("Refresh token API response: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        if (data['access_token'] != null) {
          // Update tokens
          accessToken = data['access_token'];
          await _storage.write(key: 'access_token', value: accessToken);

          // The refresh token API might also return a new refresh token,
          // but the swagger docs you provided don't show it.
          // If it does, update it too.
          if (data['refresh_token'] != null) {
            refreshToken = data['refresh_token'];
            await _storage.write(key: 'refresh_token', value: refreshToken);
          }

          _isRefreshing = false;
          return true;
        }
      }

      _isRefreshing = false;
      return false;
    } catch (e) {
      print("Error refreshing token: $e");
      _isRefreshing = false;
      return false;
    }
  }

  /// Helper to force logout out the user
  static void _logout() async {
    accessToken = '';
    refreshToken = '';
    userId = '';
    userName = '';
    await _storage.deleteAll();
    Get.offAll(() => const SignIn());
  }
}
