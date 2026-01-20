import 'package:get/get.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';

class CalendarController extends GetxController {
  // Observable variables for dates
  Rx<DateTime?> checkInDate = Rx<DateTime?>(null);
  Rx<DateTime?> checkOutDate = Rx<DateTime?>(null);
  RxInt totalDays = 0.obs;
  // Add these new properties
  var guestCount = 2.obs;
  var roomCount = 1.obs;

  // Calendar controller
  late CleanCalendarController calendarController;

  @override
  void onInit() {
    super.onInit();
    initCalendarController();
  }

  String formatDateShort(DateTime? date) {
    if (date == null) return "Select";
    return "${date.day}/${date.month}/${date.year.toString().substring(2)}";
  }

  void initCalendarController() {
    calendarController = CleanCalendarController(
      minDate: DateTime.now(),
      maxDate: DateTime.now().add(const Duration(days: 365)),
      weekdayStart: DateTime.monday,
      onRangeSelected: updateSelectedDateRange,
      onDayTapped: handleDayTapped,
    );
  }

  // Handle single day tap
  void handleDayTapped(DateTime date) {
    // If no date selected yet or both dates are selected, start new selection
    if (checkInDate.value == null || checkOutDate.value != null) {
      checkInDate.value = date;
      checkOutDate.value = null;
      totalDays.value = 0;
    }
    // If only check-in is selected and tapped date is after check-in
    else if (date.isAfter(checkInDate.value!)) {
      checkOutDate.value = date;
      calculateTotalDays();
    }
    // If tapped date is before or same as check-in, update check-in
    else {
      checkInDate.value = date;
      checkOutDate.value = null;
      totalDays.value = 0;
    }
  }

  // Handle range selection callback
  void updateSelectedDateRange(DateTime? start, DateTime? end) {
    if (start != null) {
      checkInDate.value = start;
    }
    if (end != null) {
      checkOutDate.value = end;
      calculateTotalDays();
    }
  }

  // Calculate number of days between dates
  void calculateTotalDays() {
    if (checkInDate.value != null && checkOutDate.value != null) {
      totalDays.value =
          checkOutDate.value!.difference(checkInDate.value!).inDays + 1;
    } else {
      totalDays.value = 0;
    }
  }

  // Format date for display (e.g., "8 Jan Wed 2025")
  String formatDate(DateTime? date) {
    if (date == null) return "Select Date";

    final months = [
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
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    final day = date.day;
    final month = months[date.month - 1];
    final weekday = days[date.weekday - 1];
    final year = date.year;

    return "$day $month $weekday $year";
  }

  // Add this new method
  void updateGuestInfo(int guests, int rooms) {
    guestCount.value = guests;
    roomCount.value = rooms;
  }

  // If you want to access the guest info easily
  String getGuestRoomInfo() {
    return "${guestCount.value} guest${guestCount.value > 1 ? 's' : ''}, ${roomCount.value} room${roomCount.value > 1 ? 's' : ''}";
  }

  void clearDates() {
    checkInDate.value = null;
    checkOutDate.value = null;
    totalDays.value = 0;
    guestCount.value = 2;
    roomCount.value = 1;
    initCalendarController(); // Re-initialize to clear visual selection
  }
}
