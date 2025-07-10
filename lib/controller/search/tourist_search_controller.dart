import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homesloc/apis/search/search_tourism_api.dart';
import 'package:homesloc/apis/search/tourism_details_api.dart';
import 'package:homesloc/models/search/search_tourist_package_model.dart';
import 'package:homesloc/models/search/tourism_detail_model.dart';

class TouristSearchController extends GetxController {

  // Observable variables
  final RxList<Package> tourism = <Package>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxInt totalCount = 0.obs;
  final RxBool hasNextPage = false.obs;
  final RxBool hasPreviousPage = false.obs;


  // Room details observable variables
  final Rx<TourismDetailsModel?> tourismDetails = Rx<TourismDetailsModel?>(null);
  final RxBool isLoadingTourismDetails = false.obs;
  final RxString tourismDetailsErrorMessage = ''.obs;
  

  // Search parameters
  final RxString location = ''.obs;
  final RxString checkInDate = ''.obs;
  final RxString checkOutDate = ''.obs;
  final RxInt guests = 0.obs;
  final RxString sortBy = ''.obs;
  final RxString sortOrder = ''.obs;

   // Fetch tourism details
  Future<void> fetchTourismDetails({
    required String packageId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      // Show loading indicator
      isLoadingTourismDetails.value = true;
      tourismDetailsErrorMessage.value = '';

      // Call the API
      final api = TourismDetailsApi();
      final TourismDetailsModel result = await api.fetchTourismDetails(
        packageId: packageId,
        startDate: startDate,
        endDate: endDate,
      );

      // Update the observable variable 
      tourismDetails.value = result; 
    } catch (e) {
      tourismDetailsErrorMessage.value = e.toString();
      print('Error fetching fresh up room details: $e');
    } finally {
      isLoadingTourismDetails.value = false;
    }
  }

  // Search halls with current parameters
  Future<void> searchtourism({bool refresh = false}) async {
    try {
      // Reset page if refreshing
      if (refresh) {
        currentPage.value = 1;
      }

      // Show loading indicator
      isLoading.value = true;
      errorMessage.value = '';

      // Call the API
      final SearchTouristPackageModel result = await SearchTourismApi().searchTourism(
       
        destination: location.value,
        startDate: checkInDate.value,
        endDate: checkOutDate.value,
        page: currentPage.value,
        sortBy: sortBy.value,
        sortOrder: sortOrder.value,
      );

      // Update the observable variables
      if (refresh) {
        tourism.clear();
      }

      if (result.packages != null) {
        tourism.addAll(result.packages!);
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
      await searchtourism();
    }
  }

  // Load previous page
  Future<void> loadPreviousPage() async {
    if (hasPreviousPage.value && !isLoading.value) {
      currentPage.value--;
      await searchtourism();
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
    tourism.clear();
  }
  void resetTourismDetails() {
    tourismDetails.value = null;
    isLoadingTourismDetails.value = false;
    tourismDetailsErrorMessage.value = '';
  }
}
