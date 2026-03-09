import 'package:get/get.dart';
import 'package:homesloc/apis/home/home_screen_api.dart';
import 'package:homesloc/models/home/homescreen_model.dart';

class HomeScreenController extends GetxController {
  // Observable variables
  var location = "".obs;
  var checkInDate = Rx<DateTime?>(null);
  var checkOutDate = Rx<DateTime?>(null);
  var guestCount = 1.obs;
  var roomCount = 1.obs;

  var homeScreenData = HomescreenModel().obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  List<BestHotel> get bestHotels => homeScreenData.value.bestHotels ?? [];
  List<TourPackage> get tourPackages => homeScreenData.value.tourPackages ?? [];
  List<WeddingPackage> get weddingPackages =>
      homeScreenData.value.weddingPackages ?? [];
  List<BanquetHall> get banquetHalls => homeScreenData.value.banquetHalls ?? [];
  List<PopularDestination> get popularDestinations =>
      homeScreenData.value.popularDestinations ?? [];
  List<LatestReview> get latestReviews =>
      homeScreenData.value.latestReviews ?? [];

  final HomeScreenService _homeScreenService = HomeScreenService();

  @override
  void onInit() {
    super.onInit();
    fetchData(50); // Default limit
  }

  // Format date as "dd MMM"
  String formatDateShort(DateTime? date) {
    if (date == null) return "";
    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return "${date.day} ${months[date.month - 1]}";
  }

  // Format date for display in search results
  String getFormattedDateRange() {
    if (checkInDate.value != null && checkOutDate.value != null) {
      return "${formatDateShort(checkInDate.value)} - ${formatDateShort(checkOutDate.value)}";
    }
    return "";
  }

  // Format guest and room information
  String getGuestRoomInfo() {
    return "${guestCount.value} guest, ${roomCount.value} room";
  }

  // Method to set search data
  void setSearchData({
    required String locationValue,
    required DateTime? checkIn,
    required DateTime? checkOut,
    required int guests,
    required int rooms,
  }) {
    location.value = locationValue;
    checkInDate.value = checkIn;
    checkOutDate.value = checkOut;
    guestCount.value = guests;
    roomCount.value = rooms;
  }

  Future<void> fetchData(int limit) async {
    isLoading(true);
    errorMessage('');
    try {
      final data = await _homeScreenService.fetchHomeScreenData(limit);
      if (data != null) {
        homeScreenData(data);
      } else {
        errorMessage('Failed to fetch data');
      }
    } catch (e) {
      errorMessage('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
