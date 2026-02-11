import 'package:get/get.dart';
import 'package:homesloc/apis/search/search_hotel_api.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/models/search/search_hotel_model.dart';
import 'package:intl/intl.dart';

class SearchHotelController extends GetxController {
  final SearchHotelService _searchService = SearchHotelService();

  final CalendarController calendarController = Get.find<CalendarController>();

  // Observable variables
  final isLoading = false.obs;
  final errorMessage = RxString('');
  final searchResult = Rx<SearchHotelModel?>(null);

  // Filter observables
  final location = "".obs;
  final propertyType = "".obs;
  final minPrice = Rx<int?>(null);
  final maxPrice = Rx<int?>(null);
  final sortBy = "created_at".obs;

  // Use getters to sync with CalendarController
  int get guestCountVal => calendarController.guestCount.value;
  int get roomCountVal => calendarController.roomCount.value;

  // Search hotels with current parameters
  Future<void> searchHotels({
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
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _searchService.searchHotels(
        location: location ?? this.location.value,
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
        propertyType: propertyType ?? this.propertyType.value,
        sortBy: sortBy ?? this.sortBy.value,
        limit: limit,
      );

      if (result != null) {
        searchResult.value = result;
      } else {
        errorMessage.value = 'Failed to fetch hotel data';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}
