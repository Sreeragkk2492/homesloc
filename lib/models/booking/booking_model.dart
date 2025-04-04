class BookingModel {
  final String hotelName;
  final double totalAmount;
  final int numberOfNights;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String bookingStatus;

  BookingModel({
    required this.hotelName,
    required this.totalAmount,
    required this.numberOfNights,
    required this.checkInDate,
    required this.checkOutDate,
    this.bookingStatus = 'Active',
  });
}