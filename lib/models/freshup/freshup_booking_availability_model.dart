import 'package:homesloc/models/freshup/freshup_availability_model.dart';
import 'package:homesloc/models/booking/room_availability_model.dart';

class FreshupBookingAvailabilityModel {
  FreshupSearchDetails? freshupDetails;
  List<FreshupSlot>? slotDetails;
  FreshupServiceDetails? serviceDetails;
  BookingDetails? bookingDetails;
  bool? isAvailable;
  List<dynamic>? filterErrors;

  FreshupBookingAvailabilityModel({
    this.freshupDetails,
    this.slotDetails,
    this.serviceDetails,
    this.bookingDetails,
    this.isAvailable,
    this.filterErrors,
  });

  factory FreshupBookingAvailabilityModel.fromJson(Map<String, dynamic> json) {
    return FreshupBookingAvailabilityModel(
      freshupDetails: json['freshup_details'] != null
          ? FreshupSearchDetails.fromJson(json['freshup_details'])
          : null,
      slotDetails: json['slot_details'] != null
          ? List<FreshupSlot>.from(
              json['slot_details'].map((x) => FreshupSlot.fromJson(x)))
          : null,
      serviceDetails: json['service_details'] != null
          ? FreshupServiceDetails.fromJson(json['service_details'])
          : null,
      bookingDetails: json['booking_details'] != null
          ? BookingDetails.fromJson(json['booking_details'])
          : null,
      isAvailable: json['is_available'],
      filterErrors: json['filter_errors'] ?? [],
    );
  }
}

class FreshupSearchDetails {
  String? id;
  String? freshupName;
  String? freshupDescription;
  String? priceMethod;
  num? baseRoomPrice;
  num? perHeadPrice;
  num? offerPrice;
  int? maxPersons;
  int? availableRooms;
  List<FreshupAmenity>? amenities;

  FreshupSearchDetails({
    this.id,
    this.freshupName,
    this.freshupDescription,
    this.priceMethod,
    this.baseRoomPrice,
    this.perHeadPrice,
    this.offerPrice,
    this.maxPersons,
    this.availableRooms,
    this.amenities,
  });

  factory FreshupSearchDetails.fromJson(Map<String, dynamic> json) {
    return FreshupSearchDetails(
      id: json['id'],
      freshupName: json['freshup_name'],
      freshupDescription: json['freshup_description'],
      priceMethod: json['price_method'],
      baseRoomPrice: json['base_room_price'],
      perHeadPrice: json['per_head_price'],
      offerPrice: json['offer_price'],
      maxPersons: json['max_persons'],
      availableRooms: json['available_rooms'],
      amenities: json['amenities'] != null
          ? List<FreshupAmenity>.from(
              json['amenities'].map((x) => FreshupAmenity.fromJson(x)))
          : null,
    );
  }
}

class FreshupServiceDetails {
  String? id;
  String? name;
  String? location;
  String? coverImageUrl;
  List<String>? galleryImages;
  FreshupPolicies? policies;
  // Legal policies can be added if needed, but for PaymentScreen, policies are usually enough.

  FreshupServiceDetails({
    this.id,
    this.name,
    this.location,
    this.coverImageUrl,
    this.galleryImages,
    this.policies,
  });

  factory FreshupServiceDetails.fromJson(Map<String, dynamic> json) {
    return FreshupServiceDetails(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      coverImageUrl: json['cover_image_url'],
      galleryImages: json['gallery_images'] != null
          ? List<String>.from(json['gallery_images'])
          : null,
      policies: json['policies'] != null
          ? FreshupPolicies.fromJson(json['policies'])
          : null,
    );
  }
}

class FreshupPolicies {
  String? id;
  List<String>? acceptableIdentityProof;
  String? acceptedtimeslots;
  String? cancellationPolicy;
  int? cancellationDays;
  String? extraBedPolicy;
  String? propertyrules;
  num? extraBedPrice;

  FreshupPolicies({
    this.id,
    this.acceptableIdentityProof,
    this.acceptedtimeslots,
    this.cancellationPolicy,
    this.cancellationDays,
    this.extraBedPolicy,
    this.propertyrules,
    this.extraBedPrice,
  });

  factory FreshupPolicies.fromJson(Map<String, dynamic> json) {
    return FreshupPolicies(
      id: json['id'],
      acceptableIdentityProof: json['acceptableIdentityProof'] != null
          ? List<String>.from(json['acceptableIdentityProof'])
          : null,
      acceptedtimeslots: json['acceptedtimeslots'],
      cancellationPolicy: json['cancellationPolicy'],
      cancellationDays: json['cancellationDays'],
      extraBedPolicy: json['extraBedPolicy'],
      propertyrules: json['propertyrules'],
      extraBedPrice: json['extra_bed_price'],
    );
  }
}
