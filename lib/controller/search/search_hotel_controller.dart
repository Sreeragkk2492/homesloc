import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homesloc/apis/search/location_autocomplete_service.dart';
import 'package:homesloc/apis/search/search_hotel_api.dart';
import 'package:homesloc/controller/search/filter_controller.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/models/search/search_hotel_model.dart';
import 'package:intl/intl.dart';

import 'package:homesloc/models/search/tourism_search_model.dart';

class SearchHotelController extends GetxController {
  final SearchHotelService _searchService = SearchHotelService();
  final LocationAutocompleteService _locationService =
      LocationAutocompleteService();

  final CalendarController calendarController = Get.find<CalendarController>();

  // Global Text Controllers for all Search Form Autocompletes across tabs
  final List<TextEditingController> locationControllers = [];

  void registerLocationController(TextEditingController controller) {
    if (!locationControllers.contains(controller)) {
      locationControllers.add(controller);
    }
  }

  // Observable variables
  final isLoading = false.obs;
  final errorMessage = RxString('');
  final searchResult = Rx<SearchHotelModel?>(null);
  final tourismResult = Rx<TourismSearchModel?>(null);

  // Pagination observables
  final currentPage = 1.obs;
  final pageSize = 10;
  final hasMore = true.obs;
  final isLoadMore = false.obs;

  // Filter observables
  final location = "".obs;
  final propertyType = "".obs;
  final minPrice = Rx<int?>(null);
  final maxPrice = Rx<int?>(null);
  final sortBy = "created_at".obs;

  // Use getters to sync with CalendarController
  int get guestCountVal => calendarController.guestCount.value;
  int get roomCountVal => calendarController.roomCount.value;

  // Flag to toggle between normal search, grouped hotel, and grouped hall
  final isGroupedByHotel = false.obs;
  final isGroupedByHall = false.obs;
  final isFreshup = false.obs;
  final isTourism = false.obs;
  final isAdventureTourism = false.obs;

  Future<Iterable<String>> fetchLocationSuggestions(String query) async {
    if (query.isEmpty) {
      return const Iterable<String>.empty();
    }

    try {
      final results = await _locationService.fetchSuggestions(query);
      return results;
    } catch (e) {
      return const Iterable<String>.empty();
    }
  }

  // Search hotels with current parameters
  Future<void> searchHotels({
    bool isLoadMoreAction = false,
    String? location,
    String? checkIn,
    String? checkOut,
    int? guestCount,
    int? roomCount,
    int? minPrice,
    int? maxPrice,
    String? propertyType,
    String? sortBy,
    int? limit,
  }) async {
    if (!isLoadMoreAction) {
      isLoading.value = true;
      currentPage.value = 1;
      hasMore.value = true;
      searchResult.value = null;
      tourismResult.value = null;
    } else {
      if (!hasMore.value || isLoadMore.value) return;
      isLoadMore.value = true;
      currentPage.value++;
    }
    errorMessage.value = '';

    // Extract the final location to send to the backend, then clear the UI State
    final searchLocation = location ?? this.location.value;

    // Clear the observable backend state so next search starts fresh
    this.location.value = '';

    // Clear all visual text fields explicitly without throwing if disposed
    for (var controller in locationControllers) {
      try {
        controller.clear();
      } catch (e) {
        // Ignored if the widget was already disposed from the widget tree
      }
    }

    try {
      if (isTourism.value || isAdventureTourism.value) {
        final newResult = await _searchService.searchTourism(
          page: currentPage.value,
          pageSize: limit ?? pageSize,
          sortBy: sortBy ?? this.sortBy.value,
          location: searchLocation,
          minPrice: minPrice ?? this.minPrice.value,
          maxPrice: maxPrice ?? this.maxPrice.value,
          packageType: isAdventureTourism.value
              ? "Adventure Tourism"
              : (Get.isRegistered<FilterController>()
                  ? Get.find<FilterController>().apiPackageType
                  : null),
        );
        if (newResult != null) {
          if (!isLoadMoreAction) {
            tourismResult.value = newResult;
          } else {
            if (newResult.packages != null && newResult.packages!.isNotEmpty) {
              if (tourismResult.value?.packages != null) {
                tourismResult.value!.packages!.addAll(newResult.packages!);
                tourismResult.refresh();
              }
            }
          }
          if (newResult.packages == null ||
              newResult.packages!.length < (limit ?? pageSize)) {
            hasMore.value = false;
          }
        } else if (!isLoadMoreAction) {
          errorMessage.value = 'Failed to fetch tourism data';
        }
        return;
      }

      SearchHotelModel? result;

      if (isFreshup.value) {
        // Call Freshup Search API
        result = await _searchService.searchFreshup(
          page: currentPage.value,
          pageSize: limit ?? pageSize,
          location: searchLocation,
          checkIn: checkIn ??
              (calendarController.checkInDate.value != null
                  ? DateFormat('yyyy-MM-dd')
                      .format(calendarController.checkInDate.value!)
                  : null),
          checkOut: checkOut ??
              (calendarController.checkOutDate.value != null
                  ? DateFormat('yyyy-MM-dd')
                      .format(calendarController.checkOutDate.value!)
                  : null),
          guestCount: guestCount ?? guestCountVal,
          roomCount: roomCount ?? roomCountVal,
          minPrice: minPrice ?? this.minPrice.value,
          maxPrice: maxPrice ?? this.maxPrice.value,
          freshupType: Get.isRegistered<FilterController>()
              ? Get.find<FilterController>().apiFreshupType
              : null,
          priceMethod: Get.isRegistered<FilterController>()
              ? Get.find<FilterController>().apiPriceMethod
              : null,
        );
      } else if (isGroupedByHall.value) {
        // Call the Hall search API
        result = await _searchService.searchAccommodationsGroupedByHall(
          page: currentPage.value,
          pageSize: limit ?? pageSize,
          sortBy: sortBy ?? this.sortBy.value,
          location: searchLocation,
          startDate: checkIn ??
              (calendarController.checkInDate.value != null
                  ? DateFormat('yyyy-MM-dd')
                      .format(calendarController.checkInDate.value!)
                  : null),
          endDate: checkOut ??
              (calendarController.checkOutDate.value != null
                  ? DateFormat('yyyy-MM-dd')
                      .format(calendarController.checkOutDate.value!)
                  : null),
          minPrice: minPrice ?? this.minPrice.value,
          maxPrice: maxPrice ?? this.maxPrice.value,
          venueType: Get.isRegistered<FilterController>()
              ? Get.find<FilterController>().apiVenueType
              : null,
          spaceType: Get.isRegistered<FilterController>()
              ? Get.find<FilterController>().apiSpaceType
              : null,
        );
      } else if (isGroupedByHotel.value) {
        // Call the new grouped search API
        result = await _searchService.searchAccommodationsGroupedByHotel(
          page: currentPage.value,
          pageSize: limit ?? pageSize,
          startDate: checkIn ??
              (calendarController.checkInDate.value != null
                  ? DateFormat('yyyy-MM-dd')
                      .format(calendarController.checkInDate.value!)
                  : null),
          endDate: checkOut ??
              (calendarController.checkOutDate.value != null
                  ? DateFormat('yyyy-MM-dd')
                      .format(calendarController.checkOutDate.value!)
                  : null),
          // Map other parameters as needed
          minPrice: minPrice ?? this.minPrice.value,
          maxPrice: maxPrice ?? this.maxPrice.value,
          propertyType: propertyType ??
              (Get.isRegistered<FilterController>()
                  ? Get.find<FilterController>().selectedPropertyType.value
                  : this.propertyType.value),
          amenities: Get.isRegistered<FilterController>()
              ? Get.find<FilterController>()
                  .amenities
                  .entries
                  .where((e) => e.value)
                  .map((e) => e.key)
                  .join(',')
              : null,
          accommodationType: Get.isRegistered<FilterController>()
              ? Get.find<FilterController>().apiAccommodationType
              : null,
          roomType: Get.isRegistered<FilterController>()
              ? Get.find<FilterController>().roomType.value
              : null,
          starRating: Get.isRegistered<FilterController>()
              ? Get.find<FilterController>().starRating.value
              : null,
          sortBy: sortBy ?? this.sortBy.value,
          search: searchLocation, // Using location as search term if needed
        );
      } else {
        // Call the existing normal search API
        result = await _searchService.searchHotels(
          page: currentPage.value,
          pageSize: limit ?? pageSize,
          location: searchLocation,
          checkIn: checkIn ??
              (calendarController.checkInDate.value != null
                  ? DateFormat('yyyy-MM-dd')
                      .format(calendarController.checkInDate.value!)
                  : null),
          checkOut: checkOut ??
              (calendarController.checkOutDate.value != null
                  ? DateFormat('yyyy-MM-dd')
                      .format(calendarController.checkOutDate.value!)
                  : null),
          guestCount: guestCount ?? guestCountVal,
          roomCount: roomCount ?? roomCountVal,
          minPrice: minPrice ?? this.minPrice.value,
          maxPrice: maxPrice ?? this.maxPrice.value,
          propertyType: propertyType ??
              (Get.isRegistered<FilterController>()
                  ? Get.find<FilterController>().selectedPropertyType.value
                  : this.propertyType.value),
          amenities: Get.isRegistered<FilterController>()
              ? Get.find<FilterController>()
                  .amenities
                  .entries
                  .where((e) => e.value)
                  .map((e) => e.key)
                  .join(',')
              : null,
          accommodationType: Get.isRegistered<FilterController>()
              ? Get.find<FilterController>().apiAccommodationType
              : null,
          roomType: Get.isRegistered<FilterController>()
              ? Get.find<FilterController>().roomType.value
              : null,
          starRating: Get.isRegistered<FilterController>()
              ? Get.find<FilterController>().starRating.value
              : null,
          sortBy: sortBy ?? this.sortBy.value,
          limit: limit,
        );
      }

      if (result != null) {
        if (!isLoadMoreAction) {
          searchResult.value = result;
        } else {
          if (result.searchResults != null &&
              result.searchResults!.isNotEmpty) {
            if (searchResult.value?.searchResults != null) {
              searchResult.value!.searchResults!.addAll(result.searchResults!);
              searchResult.refresh();
            }
          }
        }
        if (result.searchResults == null ||
            result.searchResults!.length < (limit ?? pageSize)) {
          hasMore.value = false;
        }
      } else if (!isLoadMoreAction) {
        errorMessage.value = 'Failed to fetch data';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      if (!isLoadMoreAction) {
        isLoading.value = false;
      } else {
        isLoadMore.value = false;
      }
    }
  }
}
