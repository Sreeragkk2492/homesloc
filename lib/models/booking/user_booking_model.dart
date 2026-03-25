class UserBookingResponse {
  final List<UserBooking> bookings;
  final int totalCount;
  final int currentPage;
  final int totalPages;
  final bool hasNext;
  final bool hasPrevious;
  final String message;

  UserBookingResponse({
    required this.bookings,
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
    required this.message,
  });

  factory UserBookingResponse.fromJson(Map<String, dynamic> json) {
    return UserBookingResponse(
      bookings: (json['bookings'] as List?)
              ?.map((e) => UserBooking.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalCount: json['total_count'] ?? 0,
      currentPage: json['current_page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
      hasNext: json['has_next'] ?? false,
      hasPrevious: json['has_previous'] ?? false,
      message: json['message'] ?? '',
    );
  }
}

class UserBooking {
  final String id;
  final int bookingUniqueId;
  final String userId;
  final String propertyId;
  final String propertyType;
  final String userName;
  final String primaryEmail;
  final String primaryMobile;
  final DateTime? bookingDate;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final double totalAmount;
  final String paymentId;
  final String paymentMethod;
  final String paymentStatus;
  final String bookingStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String name;
  final String? location;
  final String? description;
  final String? coverImageUrl;
  final String? roomName;
  final List<String>? roomImages;
  final String? roomDescription;
  final String? checkinTime;
  final String? checkoutTime;
  final String? eventName;
  final String? eventDescription;
  final String? freshupName;
  final String? freshupDescription;
  final String? slotCheckIn;
  final String? slotCheckOut;
  final String? packageName;
  final String? packageDescription;
  final int cancellationDays;
  final String? message;

  UserBooking({
    required this.id,
    required this.bookingUniqueId,
    required this.userId,
    required this.propertyId,
    required this.propertyType,
    required this.userName,
    required this.primaryEmail,
    required this.primaryMobile,
    this.bookingDate,
    this.checkIn,
    this.checkOut,
    required this.totalAmount,
    required this.paymentId,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.bookingStatus,
    this.createdAt,
    this.updatedAt,
    required this.name,
    this.location,
    this.description,
    this.coverImageUrl,
    this.roomName,
    this.roomImages,
    this.roomDescription,
    this.checkinTime,
    this.checkoutTime,
    this.eventName,
    this.eventDescription,
    this.freshupName,
    this.freshupDescription,
    this.slotCheckIn,
    this.slotCheckOut,
    this.packageName,
    this.packageDescription,
    required this.cancellationDays,
    this.message,
  });

  factory UserBooking.fromJson(Map<String, dynamic> json) {
    return UserBooking(
      id: json['id'] ?? '',
      bookingUniqueId: json['booking_unique_id'] ?? 0,
      userId: json['user_id'] ?? '',
      propertyId: json['property_id'] ?? '',
      propertyType: json['property_type'] ?? '',
      userName: json['user_name'] ?? '',
      primaryEmail: json['primary_email'] ?? '',
      primaryMobile: json['primary_mobile'] ?? '',
      bookingDate: json['booking_date'] != null
          ? DateTime.tryParse(json['booking_date'])
          : null,
      checkIn:
          json['check_in'] != null ? DateTime.tryParse(json['check_in']) : null,
      checkOut: json['check_out'] != null
          ? DateTime.tryParse(json['check_out'])
          : null,
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      paymentId: json['payment_id'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      bookingStatus: json['booking_status'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      name: json['name'] ?? '',
      location: json['location'],
      description: json['description'],
      coverImageUrl: json['cover_image_url'],
      roomName: json['room_name'],
      roomImages: json['room_images'] != null
          ? List<String>.from(json['room_images'])
          : null,
      roomDescription: json['room_description'],
      checkinTime: json['checkin_time'],
      checkoutTime: json['checkout_time'],
      eventName: json['event_name'],
      eventDescription: json['event_description'],
      freshupName: json['freshup_name'],
      freshupDescription: json['freshup_description'],
      slotCheckIn: json['slot_check_in'],
      slotCheckOut: json['slot_check_out'],
      packageName: json['package_name'],
      packageDescription: json['package_description'],
      cancellationDays: json['cancellationDays'] ?? 0,
      message: json['message'],
    );
  }
}
