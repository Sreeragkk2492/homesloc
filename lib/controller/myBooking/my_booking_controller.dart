import 'dart:convert';
import 'package:get/get.dart';
import 'package:homesloc/core/api/api_helper.dart';
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/booking/user_booking_model.dart';

class TripController extends GetxController {
  final bookings = <UserBooking>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final expandedIds = <String>{}.obs;
  final bookingDetails = <String, UserBooking>{}.obs;
  final isDetailLoading = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserBookings();
  }

  void toggleExpansionStatus(String bookingId) {
    if (expandedIds.contains(bookingId)) {
      expandedIds.remove(bookingId);
    } else {
      expandedIds.add(bookingId);
      if (!bookingDetails.containsKey(bookingId)) {
        fetchBookingDetails(bookingId);
      }
    }
  }

  Future<void> fetchBookingDetails(String bookingId) async {
    isDetailLoading[bookingId] = true;
    try {
      final url =
          Uri.parse("${ApiConstant.BASE_URL}/api/v1/bookings/$bookingId");
      final response = await ApiHelper.get(url, headers: {
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final detail = UserBooking.fromJson(data);
        bookingDetails[bookingId] = detail;
      }
    } catch (e) {
      print("Error fetching booking details: $e");
    } finally {
      isDetailLoading[bookingId] = false;
    }
  }

  Future<void> fetchUserBookings() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final url =
          Uri.parse("${ApiConstant.BASE_URL}/api/v1/bookings/user").replace(
              queryParameters: {
        'skip': '0',
        'limit': '10',
        'sort_by': 'created_at',
        'sort_order': 'desc',
        'status_filter': '',
        'property_type': '',
        'booking_id': '',
        'parent_name': '',
        'child_name': '',
      }..removeWhere((key, value) => value.isEmpty));
      final response = await ApiHelper.get(url, headers: {
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final bookingResponse = UserBookingResponse.fromJson(data);
        bookings.assignAll(bookingResponse.bookings);
      } else {
        errorMessage.value =
            "Failed to load bookings. Error code: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "An error occurred while fetching bookings.";
      print("Error fetching user bookings: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
