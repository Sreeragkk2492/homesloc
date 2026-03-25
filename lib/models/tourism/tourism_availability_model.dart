import 'package:homesloc/models/tourism/tourism_detail_model.dart';

class TourismAvailabilityModel {
  PackageDetails? packageDetails;
  AgencyDetails? agencyDetails;
  BookingDetails? bookingDetails;
  List<dynamic>? filterErrors;
  bool? isAvailable;

  TourismAvailabilityModel({
    this.packageDetails,
    this.agencyDetails,
    this.bookingDetails,
    this.filterErrors,
    this.isAvailable,
  });

  factory TourismAvailabilityModel.fromJson(Map<String, dynamic> json) {
    return TourismAvailabilityModel(
      packageDetails: json["package_details"] == null
          ? null
          : PackageDetails.fromJson(json["package_details"]),
      agencyDetails: json["agency_details"] == null
          ? null
          : AgencyDetails.fromJson(json["agency_details"]),
      bookingDetails: json["booking_details"] == null
          ? null
          : BookingDetails.fromJson(json["booking_details"]),
      filterErrors: json["filter_errors"] == null
          ? []
          : List<dynamic>.from(json["filter_errors"].map((x) => x)),
      isAvailable: json["is_available"],
    );
  }
}

class PackageDetails {
  String? id;
  String? packageName;
  String? packageType;
  String? description;
  String? startLocation;
  String? destination;
  int? totalCapacity;
  int? children;
  dynamic priceWithFlight;
  int? priceWithoutFlight;
  dynamic offerPrice;
  List<dynamic>? packageMiddlePlace;
  List<String>? tripAttractions;
  List<String>? tripExclusions;
  int? durationDays;
  int? durationNights;
  String? coverImageUrl;
  List<String>? galleryImages;
  List<dynamic>? videos;
  List<TourismAmenity>? amenities;
  List<Itinerary>? itineraries;

  PackageDetails({
    this.id,
    this.packageName,
    this.packageType,
    this.description,
    this.startLocation,
    this.destination,
    this.totalCapacity,
    this.children,
    this.priceWithFlight,
    this.priceWithoutFlight,
    this.offerPrice,
    this.packageMiddlePlace,
    this.tripAttractions,
    this.tripExclusions,
    this.durationDays,
    this.durationNights,
    this.coverImageUrl,
    this.galleryImages,
    this.videos,
    this.amenities,
    this.itineraries,
  });

  factory PackageDetails.fromJson(Map<String, dynamic> json) {
    return PackageDetails(
      id: json["id"],
      packageName: json["package_name"],
      packageType: json["package_type"],
      description: json["description"],
      startLocation: json["start_location"],
      destination: json["destination"],
      totalCapacity: (json["total_capacity"] as num?)?.toInt(),
      children: (json["children"] as num?)?.toInt(),
      priceWithFlight: json["price_with_flight"],
      priceWithoutFlight: (json["price_without_flight"] as num?)?.toInt(),
      offerPrice: json["offer_price"],
      packageMiddlePlace: json["package_middle_place"],
      tripAttractions: json["trip_attractions"] == null
          ? []
          : List<String>.from(json["trip_attractions"].map((x) => x)),
      tripExclusions: json["trip_exclusions"] == null
          ? []
          : List<String>.from(json["trip_exclusions"].map((x) => x)),
      durationDays: (json["duration_days"] as num?)?.toInt(),
      durationNights: (json["duration_nights"] as num?)?.toInt(),
      coverImageUrl: json["cover_image_url"],
      galleryImages: json["gallery_images"] == null
          ? []
          : List<String>.from(json["gallery_images"].map((x) => x)),
      videos: json["videos"],
      amenities: json["amenities"] == null
          ? []
          : List<TourismAmenity>.from(
              json["amenities"].map((x) => TourismAmenity.fromJson(x))),
      itineraries: json["itineraries"] == null
          ? []
          : List<Itinerary>.from(
              json["itineraries"].map((x) => Itinerary.fromJson(x))),
    );
  }
}

class BookingDetails {
  String? checkin;
  int? price;
  dynamic offerPrice;
  PriceSummary? priceSummary;
  DateDetails? dateDetails;

  BookingDetails({
    this.checkin,
    this.price,
    this.offerPrice,
    this.priceSummary,
    this.dateDetails,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) {
    return BookingDetails(
      checkin: json["checkin"],
      price: (json["price"] as num?)?.toInt(),
      offerPrice: json["offer_price"],
      priceSummary: json["price_summary"] == null
          ? null
          : PriceSummary.fromJson(json["price_summary"]),
      dateDetails: json["date_details"] == null
          ? null
          : DateDetails.fromJson(json["date_details"]),
    );
  }
}

class PriceSummary {
  String? packagePrice;

  PriceSummary({this.packagePrice});

  factory PriceSummary.fromJson(Map<String, dynamic> json) {
    return PriceSummary(
      packagePrice: json["package_price"],
    );
  }
}

class DateDetails {
  String? date;
  int? basePrice;
  dynamic offerPrice;
  bool? isAvailable;

  DateDetails({
    this.date,
    this.basePrice,
    this.offerPrice,
    this.isAvailable,
  });

  factory DateDetails.fromJson(Map<String, dynamic> json) {
    return DateDetails(
      date: json["date"],
      basePrice: (json["base_price"] as num?)?.toInt(),
      offerPrice: json["offer_price"],
      isAvailable: json["is_available"],
    );
  }
}
