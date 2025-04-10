import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homesloc/apis/search/search_freshup_api.dart';
import 'package:homesloc/models/search/search_fresh_up_model.dart';

class SearchFreshUpController extends GetxController {
  final SearchFreshUpApi _searchFreshUpApi = SearchFreshUpApi();

  // Observable variables
  final RxList<Service> services = <Service>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxInt totalCount = 0.obs;
  final RxBool hasNextPage = false.obs;
  final RxBool hasPreviousPage = false.obs;

  // Search parameters
  final RxString checkInDate = ''.obs;
  final RxString checkOutDate = ''.obs;
  final RxBool isActive = true.obs;
  final RxString sortBy = ''.obs;
  final RxString sortOrder = ''.obs;

  // Search fresh up services with current parameters
  Future<void> searchFreshUp({bool refresh = false}) async {
    try {
      // Reset page if refreshing
      if (refresh) {
        currentPage.value = 1;
      }

      // Show loading indicator
      isLoading.value = true;
      errorMessage.value = '';

      // Call the API
      final SearchFreshUpModel result = await _searchFreshUpApi.searchFreshUp(
        checkIn: checkInDate.value,
        checkOut: checkOutDate.value,
        isActive: isActive.value,
        page: currentPage.value,
        sortBy: sortBy.value,
        sortOrder: sortOrder.value,
      );

      // Update the observable variables
      if (refresh) {
        services.clear();
      }

      if (result.services != null) {
        services.addAll(result.services!);
      }

      totalPages.value = result.totalPages ?? 1;
      totalCount.value = result.totalCount ?? 0;
      hasNextPage.value = result.hasNext ?? false;
      hasPreviousPage.value = result.hasPrevious ?? false;
    } catch (e) {
      errorMessage.value = e.toString();
      print('Error searching fresh up services: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Load next page
  Future<void> loadNextPage() async {
    if (hasNextPage.value && !isLoading.value) {
      currentPage.value++;
      await searchFreshUp();
    }
  }

  // Load previous page
  Future<void> loadPreviousPage() async {
    if (hasPreviousPage.value && !isLoading.value) {
      currentPage.value--;
      await searchFreshUp();
    }
  }

  // Set search parameters
  void setCheckInDate(String value) {
    checkInDate.value = value;
  }

  void setCheckOutDate(String value) {
    checkOutDate.value = value;
  }

  void setIsActive(bool value) {
    isActive.value = value;
  }

  void setSortBy(String value) {
    sortBy.value = value;
  }

  void setSortOrder(String value) {
    sortOrder.value = value;
  }

  // Reset search parameters
  void resetSearch() {
    checkInDate.value = '';
    checkOutDate.value = '';
    isActive.value = true;
    sortBy.value = '';
    sortOrder.value = '';
    currentPage.value = 1;
    services.clear();
  }
}
