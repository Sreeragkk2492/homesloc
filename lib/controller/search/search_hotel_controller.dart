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

  // Search hotels with current parameters
  Future<void> searchHotels() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _searchService.searchHotels(
        checkIn: DateFormat('yyyy-MM-dd')
            .format(calendarController.checkInDate.value!),
        checkOut: DateFormat('yyyy-MM-dd')
            .format(calendarController.checkOutDate.value!),
        // // Other parameters can be null or default values
        // location: '',
        // name: '',
        // guestCount: 0,
        // minPrice: 0,
        // maxPrice: 0,
        // starRating: 0,
        // page: 1,
        // pageSize: 10,
        sortBy: 'created_at',
        sortOrder: 'desc',
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
