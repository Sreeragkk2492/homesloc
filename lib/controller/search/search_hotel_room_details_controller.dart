import 'package:get/get.dart';
import 'package:homesloc/apis/search/search_hotel_room_details_api.dart';
import 'package:homesloc/models/search/room_details_model.dart';

class SearchHotelRoomDetailsController extends GetxController {
  final SearchHotelRoomDetailsApi _api = SearchHotelRoomDetailsApi();
  
  // Reactive variables
  final Rx<RoomDetailsModel?> roomDetails = Rx<RoomDetailsModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Method to fetch room details
  Future<void> fetchRoomDetails({
    required String roomId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      // Reset state
      isLoading.value = true;
      errorMessage.value = '';
      roomDetails.value = null;

      // Fetch data
      final response = await _api.getRoomDetails(
        roomId: roomId,
        startDate: startDate,
        endDate: endDate,
      );

      // Update state
      roomDetails.value = response;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Clear the current room details
  void clearRoomDetails() {
    roomDetails.value = null;
    errorMessage.value = '';
  }
}
