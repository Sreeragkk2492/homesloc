import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:homesloc/core/api/api_helper.dart';
import 'package:homesloc/core/constant/api_constant.dart';

class RazorpayService {
  static final RazorpayService _instance = RazorpayService._internal();
  factory RazorpayService() => _instance;

  late Razorpay _razorpay;

  // Callbacks
  Function(PaymentSuccessResponse)? onSuccess;
  Function(PaymentFailureResponse)? onFailure;
  Function(ExternalWalletResponse)? onExternalWallet;

  RazorpayService._internal() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (onSuccess != null) {
      onSuccess!(response);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (onFailure != null) {
      onFailure!(response);
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (onExternalWallet != null) {
      onExternalWallet!(response);
    }
  }

  /// Fetches an Order ID from the backend using the `/api/v1/bookings/razorpay/create-order` endpoint.
  Future<String?> generateOrderId(double amount) async {
    try {
      final url = Uri.parse(
          '${ApiConstant.BASE_URL}${ApiConstant.RAZORPAY_CREATE_ORDER_URL}');

      // The backend strictly requires an integer (Rupees).
      // We use .ceil() to send a whole number to satisfy the backend,
      // while the frontend will still charge the exact decimals.
      final int integerRupees = amount.ceil();
      final body = jsonEncode({
        'amount': integerRupees,
      });

      print('Starting Razorpay Create Order Request:');
      print('URL: $url');
      print('Body: $body');

      final response = await ApiHelper.post(
        url,
        body: body,
      );

      print(
          'Razorpay Create Order Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('Razorpay Decoded Data: $data');

        // Extract ID from various possible structures
        if (data is Map) {
          String? id = data['id']?.toString() ??
              data['order_id']?.toString() ??
              (data['data'] is Map ? data['data']['id']?.toString() : null);
          print('Extracted Order ID: $id');
          return id;
        }
      }
    } catch (e) {
      print('Error generating Razorpay Order ID: $e');
    }
    return null;
  }

  /// Initializes the Razorpay checkout.
  /// First, it calls your backend to get an `orderId`. If successful, it passes it
  /// to Razorpay to open the checkout flow.
  Future<void> openCheckout({
    required double amount,
    required String name,
    required String description,
    required String prefillContact,
    required String prefillEmail,
  }) async {
    try {
      // 1. Get backend Order ID
      final String? orderId = await generateOrderId(amount);

      if (orderId == null) {
        Get.snackbar(
          'Payment Error',
          'Failed to initialize payment securely. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // 2. Build Razorpay options
      final int amountInPaise = (amount * 100).toInt();

      var options = {
        'key': ApiConstant.RAZORPAY_TEST_KEY,
        'order_id': orderId,
        'amount': amountInPaise,
        'currency': 'INR',
        'name': 'Homesloc',
        'description': description,
        'prefill': {
          'contact': prefillContact,
          'email': prefillEmail,
        },
      };

      // 3. Open checkout
      print('Opening Razorpay Checkout with options: $options');
      _razorpay.open(options);
    } catch (e) {
      print('Razorpay Checkout Exception: ${e.toString()}');
    }
  }

  void dispose() {
    _razorpay.clear(); // Removes all listeners
  }
}
