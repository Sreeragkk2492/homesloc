import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homesloc/apis/home/hotel_detail_service.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/loader/app_loader.dart';
import 'package:homesloc/models/freshup/freshup_availability_model.dart';
import 'package:homesloc/models/home/hotel_detail_model.dart';
import 'package:homesloc/models/search/search_hotel_model.dart';
import 'package:homesloc/models/freshup/freshup_booking_request_model.dart';
import 'package:homesloc/screens/payment_screen/booking_successful/booking_successful.dart';
import 'package:homesloc/screens/payment_screen/freshup_payment_screen.dart';
import 'package:homesloc/core/services/razorpay_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';

class FreshupDetailController extends GetxController {
  final Hotel freshup;
  final String? initialStartDate;

  FreshupDetailController({required this.freshup, this.initialStartDate});

  final HotelDetailService _hotelDetailService = HotelDetailService();
  late final CalendarController calendarController;

  var carouselIndex = 0.obs;
  var isLoading = false.obs;
  var isSlotsLoading = false.obs;
  var availabilityModel = Rxn<FreshupAvailabilityModel>();
  var selectedSlotIds = <String>[].obs;
  var selectedFreshupRoom = Rxn<HotelRoom>();

  void selectRoom(HotelRoom room) {
    if (selectedFreshupRoom.value?.id == room.id) {
      return;
    }

    selectedFreshupRoom.value = room;
    // Reset slots and carousel index instantly for better UX
    selectedSlotIds.clear();
    carouselIndex.value = 0;

    // Refetch availability for the selected room using room ID
    fetchFreshupDetailsForRoom(room.id!);
  }

  Future<void> fetchFreshupDetailsForRoom(String roomId) async {
    if (freshup.freshupDetails?.priceMethod == null) return;
    isSlotsLoading(true);
    try {
      final dateFormat = DateFormat('yyyy-MM-dd');
      final date = dateFormat
          .format(calendarController.checkInDate.value ?? DateTime.now());
      final result = await _hotelDetailService.checkFreshupAvailability(
        freshupRoomId: roomId,
        priceMethod: freshup.freshupDetails!.priceMethod!,
        date: date,
      );
      availabilityModel.value = result;
      selectedSlotIds.clear();
    } catch (e) {
      debugPrint("Error fetching freshup details for room: $e");
    } finally {
      isSlotsLoading(false);
    }
  }

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

    fetchFreshupDetails();
  }

  Future<void> fetchFreshupDetails() async {
    if (freshup.id == null || freshup.freshupDetails?.priceMethod == null) {
      return;
    }

    isLoading(true);

    try {
      final dateFormat = DateFormat('yyyy-MM-dd');
      final date = dateFormat
          .format(calendarController.checkInDate.value ?? DateTime.now());

      final result = await _hotelDetailService.checkFreshupAvailability(
        freshupRoomId: freshup.id!,
        priceMethod: freshup.freshupDetails!.priceMethod!,
        date: date,
      );

      availabilityModel.value = result;

      // Clear selected slots when date/availability changes
      selectedSlotIds.clear();
    } catch (e) {
      debugPrint("Error fetching freshup details: $e");
    } finally {
      isLoading(false);
    }
  }

  void updateCarouselIndex(int index) {
    carouselIndex.value = index;
  }

  void toggleSlot(String slotId) {
    if (selectedSlotIds.contains(slotId)) {
      selectedSlotIds.remove(slotId);
    } else {
      selectedSlotIds.add(slotId);
    }
  }

  Future<void> bookNow() async {
    if (calendarController.checkInDate.value == null) {
      Get.snackbar(
        "Date Required",
        "Please select check-in date",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: white,
      );
      return;
    }

    if (selectedSlotIds.isEmpty) {
      Get.snackbar(
        "Slot Required",
        "Please select at least one stay slot",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: white,
      );
      return;
    }

    final dateFormat = DateFormat('yyyy-MM-dd');
    final date = dateFormat.format(calendarController.checkInDate.value!);

    // Show loading dialog
    Get.dialog(
      const Center(child: AppLoader(size: 50)),
      barrierDismissible: false,
    );

    try {
      final result = await _hotelDetailService.searchFreshupAvailability(
        slotIds: selectedSlotIds.toList(),
        roomType: freshup.freshupDetails?.priceMethod ?? "PER_ROOM",
        checkIn: date,
        adults: calendarController.guestCount.value,
        children: 0, // Children count if available
      );

      Get.back(); // Hide loading dialog

      debugPrint(
          "Availability Check Output: isAvailable=${result?.isAvailable}, hasBookingDetails=${result?.bookingDetails != null}, slotCount=${result?.slotDetails?.length}");

      if (result != null &&
          (result.isAvailable == true ||
              result.bookingDetails != null ||
              (result.slotDetails != null && result.slotDetails!.isNotEmpty))) {
        // Same day checkout for Freshup
        calendarController.checkOutDate.value =
            calendarController.checkInDate.value;

        Get.to(() => FreshupPaymentScreen(
              hotelName:
                  result.serviceDetails?.name ?? freshup.name ?? "Property",
              location: result.serviceDetails?.location ??
                  freshup.location ??
                  "Location",
              price: result.bookingDetails?.price?.toDouble() ??
                  double.tryParse(freshup.originalPrice ?? '0') ??
                  0.0,
              coverImage: result.serviceDetails?.coverImageUrl ??
                  freshup.coverImageUrl ??
                  "",
              bookingDetails: result.bookingDetails,
              selectedSlots: result.slotDetails,
              freshupId: freshup.id,
              cancellationPolicy: (result
                              .serviceDetails?.policies?.cancellationPolicy !=
                          null &&
                      result.serviceDetails!.policies!.cancellationPolicy!
                          .isNotEmpty)
                  ? result.serviceDetails!.policies!.cancellationPolicy
                  : (availabilityModel.value?.rawDetails?.cancellationPolicy !=
                              null &&
                          availabilityModel.value!.rawDetails!
                              .cancellationPolicy!.isNotEmpty)
                      ? availabilityModel.value!.rawDetails!.cancellationPolicy
                      : (freshup.freshupDetails?.cancellationPolicy != null &&
                              freshup.freshupDetails!.cancellationPolicy!
                                  .isNotEmpty)
                          ? freshup.freshupDetails!.cancellationPolicy
                          : (freshup.freshupDetails?.accommodationPolicies !=
                                      null &&
                                  freshup.freshupDetails!.accommodationPolicies!
                                      .isNotEmpty)
                              ? freshup.freshupDetails!.accommodationPolicies!
                                  .where((p) {
                                    final low = p.toLowerCase();
                                    return low.contains('cancel') ||
                                        low.contains('refund') ||
                                        low.contains('non-refundable') ||
                                        low.contains('nonrefundable') ||
                                        low.contains('charge');
                                  })
                                  .toList()
                                  .toSet()
                                  .join('\n')
                              : 'Standard Freshup cancellation policies apply.',
            ));
      } else {
        Get.snackbar(
          "Not Available",
          "Freshup not available for selected slots/criteria",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: white,
        );
      }
    } catch (e) {
      Get.back(); // Hide loading dialog
      debugPrint("Error during booking: $e");
      Get.snackbar(
        "Error",
        "An error occurred while checking availability",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: white,
      );
    }
  }

  Future<void> startFreshupPayment({
    required String hotelName,
    required String location,
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
      confirmFreshupBooking(
        hotelName: hotelName,
        location: location,
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
      description: "Freshup Booking for ${freshup.name}",
      prefillContact: contact,
      prefillEmail: prefillEmail,
    );
  }

  Future<void> confirmFreshupBooking({
    required String hotelName,
    required String location,
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
      final checkOutStr = dateFormat
          .format(calendarController.checkOutDate.value ?? DateTime.now());

      // Create a booking request for each selected slot
      final List<FreshupBookingRequestModel> bookings =
          selectedSlotIds.map((slotId) {
        return FreshupBookingRequestModel(
          propertyId: slotId,
          propertyType: "SLOT",
          userName: userName,
          primaryEmail: email,
          primaryMobile: mobile,
          checkIn: checkInStr,
          checkOut: checkOutStr,
          totalAmount: totalAmount / selectedSlotIds.length,
          paymentId: razorpayPaymentId,
          paymentMethod: "Online",
          paymentStatus: "Completed",
          bookingStatus: "Booked",
        );
      }).toList();

      final success = await _hotelDetailService.createNewBooking(bookings);

      Get.back(); // Hide loading

      if (success) {
        Get.offAll(() => BookingSuccessful(
              hotelName: hotelName,
              location: location,
              price: totalAmount.toStringAsFixed(0),
              checkInDate: checkInStr,
              checkOutDate: checkOutStr,
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
      debugPrint("Error confirming booking: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: white,
      );
    }
  }
}
