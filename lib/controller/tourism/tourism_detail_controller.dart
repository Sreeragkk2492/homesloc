import 'package:get/get.dart';
import 'package:homesloc/apis/search/search_hotel_api.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/models/tourism/tourism_detail_model.dart';
import 'package:intl/intl.dart';
import 'package:homesloc/screens/payment_screen/tourism_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:homesloc/models/tourism/tourism_booking_request_model.dart';
import 'package:homesloc/apis/home/hotel_detail_service.dart';
import 'package:homesloc/screens/payment_screen/booking_successful/booking_successful.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/loader/app_loader.dart';
import 'package:homesloc/core/services/razorpay_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class TourismDetailController extends GetxController {
  final String packageId;
  final String? initialStartDate;
  final String? initialEndDate;

  TourismDetailController({
    required this.packageId,
    this.initialStartDate,
    this.initialEndDate,
  });

  final SearchHotelService _searchService = SearchHotelService();
  final HotelDetailService _hotelDetailService = HotelDetailService();
  late final CalendarController calendarController;

  var carouselIndex = 0.obs;
  var isLoading = false.obs;
  var tourismDetails = Rxn<TourismDetailModel>();
  var errorMessage = ''.obs;
  var userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.isRegistered<CalendarController>()) {
      calendarController = Get.find<CalendarController>();
    } else {
      calendarController = Get.put(CalendarController());
    }

    if (initialStartDate != null) {
      calendarController.checkInDate.value = DateTime.parse(initialStartDate!);
    }
    if (initialEndDate != null) {
      calendarController.checkOutDate.value = DateTime.parse(initialEndDate!);
    }

    fetchTourismDetails();
  }

  Future<void> fetchTourismDetails() async {
    isLoading(true);
    errorMessage('');

    try {
      final dateFormat = DateFormat('yyyy-MM-dd');
      final start = dateFormat
          .format(calendarController.checkInDate.value ?? DateTime.now());
      final end = dateFormat.format(calendarController.checkOutDate.value ??
          DateTime.now().add(const Duration(days: 1)));

      final result = await _searchService.fetchTourismDetails(
        packageId: packageId,
        startDate: start,
        endDate: end,
      );

      if (result != null) {
        tourismDetails.value = result;
      } else {
        errorMessage.value = 'Failed to load package details';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred while fetching details';
      print('Error in TourismDetailController: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> checkAvailabilityAndBook() async {
    if (calendarController.checkInDate.value == null) {
      Get.snackbar("Select Date", "Please select a travel date first.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFFFB74D), // yellow approximate
          colorText: const Color(0xFF0D47A1)); // blue approximate
      return;
    }

    isLoading(true);
    try {
      final dateFormat = DateFormat('yyyy-MM-dd');
      final checkin = dateFormat.format(calendarController.checkInDate.value!);

      final result = await _searchService.checkTourismAvailability(
        packageId: packageId,
        checkin: checkin,
      );

      if (result != null && result.isAvailable == true) {
        Get.to(() => TourismPaymentScreen(
              packageName: tourismDetails.value?.packageName ?? "Tour Package",
              destination: tourismDetails.value?.destination ?? "",
              price: double.tryParse(
                      tourismDetails.value?.priceWithoutFlight ?? "0") ??
                  0,
              coverImage:
                  tourismDetails.value?.galleryImages?.isNotEmpty == true
                      ? tourismDetails.value!.galleryImages!.first
                      : "",
              cancellationPolicy: tourismDetails
                      .value?.agencyDetails?.policies?.cancellationPolicy ??
                  'Standard cancellation policies apply.',
            ));
      } else {
        Get.snackbar("Not Available",
            "The selected package is not available for this date.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while checking availability.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print('Error checking tourism availability: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> startTourismPayment({
    required String packageName,
    required String destination,
    required String coverImage,
    required num totalAmount,
    required String userName,
    required String email,
    required String mobile,
  }) async {
    final RazorpayService razorpayService = RazorpayService();

    // Get user profile for prefill
    String contact = mobile;
    String prefillEmail = email;
    String prefillName = userName;

    razorpayService.onSuccess = (PaymentSuccessResponse response) {
      confirmTourismBooking(
        packageName: packageName,
        destination: destination,
        coverImage: coverImage,
        totalAmount: totalAmount,
        razorpayPaymentId: response.paymentId ?? "",
        userName: userName,
        email: email,
        mobile: mobile,
      );
    };

    razorpayService.onFailure = (PaymentFailureResponse response) {
      Get.snackbar(
        "Payment Failed",
        response.message ?? "Payment was unsuccessful. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: white,
      );
    };

    await razorpayService.openCheckout(
      amount: totalAmount.toDouble(),
      name: prefillName,
      description: "Tourism Booking for $packageName",
      prefillContact: contact,
      prefillEmail: prefillEmail,
    );
  }

  Future<void> confirmTourismBooking({
    required String packageName,
    required String destination,
    required String coverImage,
    required num totalAmount,
    required String razorpayPaymentId,
    required String userName,
    required String email,
    required String mobile,
  }) async {
    // Show loading
    Get.dialog(
      const Center(child: AppLoader(size: 50)),
      barrierDismissible: false,
    );

    try {
      final dateFormat = DateFormat('yyyy-MM-dd');
      final checkInStr = dateFormat
          .format(calendarController.checkInDate.value ?? DateTime.now());

      // Create a booking request for the tourism package
      final booking = TourismBookingRequestModel(
        propertyId: packageId,
        propertyType: "PACKAGE",
        userName: userName,
        primaryEmail: email,
        primaryMobile: mobile,
        checkIn: checkInStr,
        checkOut: checkInStr, // Tourism packages use same date for check-in/out
        totalAmount: totalAmount,
        paymentId: razorpayPaymentId,
        paymentMethod: "Online",
        paymentStatus: "Completed",
        bookingStatus: "Booked",
      );

      final success = await _hotelDetailService.createNewBooking([booking]);

      Get.back(); // Hide loading

      if (success) {
        Get.offAll(() => BookingSuccessful(
              hotelName: packageName,
              location: destination,
              price: totalAmount.toStringAsFixed(0),
              checkInDate: checkInStr,
              checkOutDate: checkInStr,
              coverImage: coverImage,
            ));
      } else {
        Get.snackbar(
          "Booking Failed",
          "Could not complete the booking. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: white,
        );
      }
    } catch (e) {
      Get.back();
      debugPrint("Error confirming tourism booking: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: white,
      );
    }
  }

  void updateCarouselIndex(int index) {
    carouselIndex.value = index;
  }
}
