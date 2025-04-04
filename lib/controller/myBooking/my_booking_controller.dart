import 'package:get/get.dart';
import 'package:homesloc/models/booking/booking_model.dart';

class TripController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final List<String> tabs = ['Active', 'Past', 'Canceled'];
    final activeBookings = <BookingModel>[].obs;
  final pastBookings = <BookingModel>[].obs;
  final canceledBookings = <BookingModel>[].obs;

  void addBooking(BookingModel booking) {
    activeBookings.add(booking);
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}