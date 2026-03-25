import 'package:homesloc/models/freshup/freshup_availability_model.dart';
import 'package:homesloc/models/freshup/freshup_booking_details_model.dart';

class FreshupBookingAvailabilityModel {
  FreshupSearchDetails? freshupDetails;
  List<FreshupSlot>? slotDetails;
  FreshupServiceDetails? serviceDetails;
  FreshupBookingDetails? bookingDetails;
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
    // Parse freshup_details first
    FreshupSearchDetails? freshupDetails = json['freshup_details'] != null
        ? FreshupSearchDetails.fromJson(json['freshup_details'])
        : null;

    // Parse booking_details or create from freshup_details if missing
    FreshupBookingDetails? bookingDetails;
    if (json['booking_details'] != null) {
      bookingDetails = FreshupBookingDetails.fromJson(json['booking_details']);

      // If booking_details has zero or null price, use freshup_details price as fallback
      if ((bookingDetails.price == null || bookingDetails.price == 0) &&
          freshupDetails != null) {
        bookingDetails = FreshupBookingDetails(
          checkin: bookingDetails.checkin,
          slots: bookingDetails.slots,
          days: bookingDetails.days,
          adults: bookingDetails.adults,
          children: bookingDetails.children,
          totalGuests: bookingDetails.totalGuests,
          price: freshupDetails.offerPrice ?? freshupDetails.baseRoomPrice,
          offerPrice: freshupDetails.offerPrice,
          priceSummary: bookingDetails.priceSummary,
          dateDetails: bookingDetails.dateDetails,
        );
        print(
            '📊 Using freshup_details price as fallback: price=${bookingDetails.price}, offerPrice=${bookingDetails.offerPrice}');
      } else {
        print(
            '📊 Parsed booking_details from API: price=${bookingDetails.price}, offerPrice=${bookingDetails.offerPrice}');
      }
    } else if (freshupDetails != null) {
      // Create BookingDetails from freshup_details when API doesn't provide booking_details
      bookingDetails = FreshupBookingDetails(
        price: freshupDetails.offerPrice ?? freshupDetails.baseRoomPrice,
        offerPrice: freshupDetails.offerPrice,
      );
      print(
          '📊 Created booking_details from freshup_details: price=${bookingDetails.price}, offerPrice=${bookingDetails.offerPrice}');
    }

    return FreshupBookingAvailabilityModel(
      freshupDetails: freshupDetails,
      slotDetails: json['slot_details'] != null
          ? List<FreshupSlot>.from(
              json['slot_details'].map((x) => FreshupSlot.fromJson(x)))
          : null,
      serviceDetails: json['service_details'] != null
          ? FreshupServiceDetails.fromJson(json['service_details'])
          : null,
      bookingDetails: bookingDetails,
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
      id: json['id']?.toString(),
      freshupName: json['freshup_name'],
      freshupDescription: json['freshup_description'],
      priceMethod: json['price_method'],
      baseRoomPrice: num.tryParse(json['base_room_price']?.toString() ?? ''),
      perHeadPrice: num.tryParse(json['per_head_price']?.toString() ?? ''),
      offerPrice: num.tryParse(json['offer_price']?.toString() ?? ''),
      maxPersons: int.tryParse(json['max_persons']?.toString() ?? ''),
      availableRooms: int.tryParse(json['available_rooms']?.toString() ?? ''),
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
      id: json['id']?.toString(),
      acceptableIdentityProof: json['acceptableIdentityProof'] != null
          ? List<String>.from(json['acceptableIdentityProof'])
          : null,
      acceptedtimeslots: json['acceptedtimeslots']?.toString(),
      cancellationPolicy: json['cancellationPolicy']?.toString(),
      cancellationDays:
          int.tryParse(json['cancellationDays']?.toString() ?? ''),
      extraBedPolicy: json['extraBedPolicy']?.toString(),
      propertyrules: json['propertyrules']?.toString(),
      extraBedPrice: num.tryParse(json['extra_bed_price']?.toString() ?? ''),
    );
  }
}
