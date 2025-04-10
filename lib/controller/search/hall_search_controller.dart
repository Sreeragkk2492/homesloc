import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homesloc/apis/search/search_hall_api.dart';
import 'package:homesloc/apis/search/search_hall_event_details_api.dart';
import 'package:homesloc/models/search/search_hall_model.dart';
import 'package:homesloc/models/search/search_hall_event_details_model.dart';

class HallSearchController extends GetxController {
  final SearchHallApi _searchHallApi = SearchHallApi();
  final SearchHallEventDetailsApi _searchHallEventDetailsApi = SearchHallEventDetailsApi();

  // Observable variables
  final RxList<Hall> halls = <Hall>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxInt totalCount = 0.obs;
  final RxBool hasNextPage = false.obs;
  final RxBool hasPreviousPage = false.obs;
  
  // Event details observable
  final Rx<HallEventDetailsModel?> selectedEventDetails = Rx<HallEventDetailsModel?>(null);
  final RxBool isLoadingEventDetails = false.obs;
  final RxString eventDetailsErrorMessage = ''.obs;

  // Search parameters
  final RxString location = ''.obs;
  final RxString checkInDate = ''.obs;
  final RxString checkOutDate = ''.obs;
  final RxInt guests = 0.obs;
  final RxString sortBy = ''.obs;
  final RxString sortOrder = ''.obs;

  // Fetch event details
  Future<void> fetchEventDetails({
    required String eventId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      isLoadingEventDetails.value = true;
      eventDetailsErrorMessage.value = '';
      
      final eventDetails = await _searchHallEventDetailsApi.getHallEventDetails(
        eventId: eventId,
        startDate: startDate,
        endDate: endDate,
      );
      
      selectedEventDetails.value = eventDetails;
    } catch (e) {
      eventDetailsErrorMessage.value = e.toString();
      print('Error fetching event details: $e');
    } finally {
      isLoadingEventDetails.value = false;
    }
  }

  // Clear selected event details
  void clearSelectedEventDetails() {
    selectedEventDetails.value = null;
    eventDetailsErrorMessage.value = '';
  }

  // Search halls with current parameters
  Future<void> searchHalls({bool refresh = false}) async {
    try {
      // Reset page if refreshing
      if (refresh) {
        currentPage.value = 1;
      }

      // Show loading indicator
      isLoading.value = true;
      errorMessage.value = '';

      // Call the API
      final HallModel result = await _searchHallApi.searchHalls(
        location: location.value,
        checkInDate: checkInDate.value,
        checkOutDate: checkOutDate.value,
        guests: guests.value > 0 ? guests.value : null,
        page: currentPage.value,
        sortBy: sortBy.value,
        sortOrder: sortOrder.value,
      );

      // Update the observable variables
      if (refresh) {
        halls.clear();
      }

      if (result.halls != null) {
        halls.addAll(result.halls!);
      }

      totalPages.value = result.totalPages ?? 1;
      totalCount.value = result.totalCount ?? 0;
      hasNextPage.value = result.hasNext ?? false;
      hasPreviousPage.value = result.hasPrevious ?? false;
    } catch (e) {
      errorMessage.value = e.toString();
      print('Error searching halls: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Load next page
  Future<void> loadNextPage() async {
    if (hasNextPage.value && !isLoading.value) {
      currentPage.value++;
      await searchHalls();
    }
  }

  // Load previous page
  Future<void> loadPreviousPage() async {
    if (hasPreviousPage.value && !isLoading.value) {
      currentPage.value--;
      await searchHalls();
    }
  }

  // Set search parameters
  void setLocation(String value) {
    location.value = value;
  }

  void setCheckInDate(String value) {
    checkInDate.value = value;
  }

  void setCheckOutDate(String value) {
    checkOutDate.value = value;
  }

  void setGuests(int value) {
    guests.value = value;
  }

  void setSortBy(String value) {
    sortBy.value = value;
  }

  void setSortOrder(String value) {
    sortOrder.value = value;
  }

  // Reset search parameters
  void resetSearch() {
    location.value = '';
    checkInDate.value = '';
    checkOutDate.value = '';
    guests.value = 0;
    sortBy.value = '';
    sortOrder.value = '';
    currentPage.value = 1;
    halls.clear();
  }
}
