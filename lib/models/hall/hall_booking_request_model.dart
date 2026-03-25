import 'dart:convert';

class HallBookingRequestModel {
  String? propertyId;
  String? propertyType;
  String? userName;
  String? primaryEmail;
  String? primaryMobile;
  String? couponCode;
  String? checkIn;
  String? checkOut;
  num? totalAmount;
  String? paymentId;
  String? paymentMethod;
  String? paymentStatus;
  String? bookingStatus;

  HallBookingRequestModel({
    this.propertyId,
    this.propertyType,
    this.userName,
    this.primaryEmail,
    this.primaryMobile,
    this.couponCode,
    this.checkIn,
    this.checkOut,
    this.totalAmount,
    this.paymentId,
    this.paymentMethod,
    this.paymentStatus,
    this.bookingStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      "property_id": propertyId,
      "property_type": propertyType,
      "user_name": userName,
      "primary_email": primaryEmail,
      "primary_mobile": primaryMobile,
      "coupon_code": couponCode ?? "",
      "check_in": checkIn,
      "check_out": checkOut,
      "total_amount": totalAmount,
      "payment_id": paymentId,
      "payment_method": paymentMethod,
      "payment_status": paymentStatus,
      "booking_status": bookingStatus,
    };
  }

  static String toJsonList(List<HallBookingRequestModel> bookings) {
    return jsonEncode(bookings.map((b) => b.toJson()).toList());
  }
}
