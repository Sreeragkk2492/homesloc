class HallAvailabilityModel {
  EventDetails? eventDetails;
  HallDetails? hallDetails;
  BookingDetails? bookingDetails;
  bool? isAvailable;
  List<String>? filterErrors;

  HallAvailabilityModel({
    this.eventDetails,
    this.hallDetails,
    this.bookingDetails,
    this.isAvailable,
    this.filterErrors,
  });

  factory HallAvailabilityModel.fromJson(Map<String, dynamic> json) =>
      HallAvailabilityModel(
        eventDetails: json["event_details"] == null
            ? null
            : EventDetails.fromJson(json["event_details"]),
        hallDetails: json["hall_details"] == null
            ? null
            : HallDetails.fromJson(json["hall_details"]),
        bookingDetails: json["booking_details"] == null
            ? null
            : BookingDetails.fromJson(json["booking_details"]),
        isAvailable: json["is_available"],
        filterErrors: json["filter_errors"] == null
            ? []
            : List<String>.from(json["filter_errors"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "event_details": eventDetails?.toJson(),
        "hall_details": hallDetails?.toJson(),
        "booking_details": bookingDetails?.toJson(),
        "is_available": isAvailable,
        "filter_errors": filterErrors == null
            ? []
            : List<dynamic>.from(filterErrors!.map((x) => x)),
      };
}

class BookingDetails {
  String? startDate;
  String? endDate;
  int? days;
  double? price;
  double? offerPrice;
  PriceSummary? priceSummary;
  List<DateDetail>? dateDetails;

  BookingDetails({
    this.startDate,
    this.endDate,
    this.days,
    this.price,
    this.offerPrice,
    this.priceSummary,
    this.dateDetails,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
        startDate: json["start_date"],
        endDate: json["end_date"],
        days: json["days"],
        price: (json["price"] as num?)?.toDouble(),
        offerPrice: (json["offer_price"] as num?)?.toDouble(),
        priceSummary: json["price_summary"] == null
            ? null
            : PriceSummary.fromJson(json["price_summary"]),
        dateDetails: json["date_details"] == null
            ? []
            : List<DateDetail>.from(
                json["date_details"]!.map((x) => DateDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "start_date": startDate,
        "end_date": endDate,
        "days": days,
        "price": price,
        "offer_price": offerPrice,
        "price_summary": priceSummary?.toJson(),
        "date_details": dateDetails == null
            ? []
            : List<dynamic>.from(dateDetails!.map((x) => x.toJson())),
      };
}

class DateDetail {
  String? date;
  double? basePrice;
  double? offerPrice;
  bool? isAvailable;

  DateDetail({
    this.date,
    this.basePrice,
    this.offerPrice,
    this.isAvailable,
  });

  factory DateDetail.fromJson(Map<String, dynamic> json) => DateDetail(
        date: json["date"],
        basePrice: (json["base_price"] as num?)?.toDouble(),
        offerPrice: (json["offer_price"] as num?)?.toDouble(),
        isAvailable: json["is_available"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "base_price": basePrice,
        "offer_price": offerPrice,
        "is_available": isAvailable,
      };
}

class PriceSummary {
  String? nightsPrice;

  PriceSummary({
    this.nightsPrice,
  });

  factory PriceSummary.fromJson(Map<String, dynamic> json) => PriceSummary(
        nightsPrice: json["nights_price"],
      );

  Map<String, dynamic> toJson() => {
        "nights_price": nightsPrice,
      };
}

class EventDetails {
  String? id;
  String? eventName;
  String? venueType;
  int? seatingCapacity;
  int? floatingCapacity;
  int? totalArea;
  String? spaceType;
  bool? airConditioned;
  bool? hasDining;
  int? diningCapacity;
  String? description;
  List<Amenity>? amenities;

  EventDetails({
    this.id,
    this.eventName,
    this.venueType,
    this.seatingCapacity,
    this.floatingCapacity,
    this.totalArea,
    this.spaceType,
    this.airConditioned,
    this.hasDining,
    this.diningCapacity,
    this.description,
    this.amenities,
  });

  factory EventDetails.fromJson(Map<String, dynamic> json) => EventDetails(
        id: json["id"],
        eventName: json["event_name"],
        venueType: json["venue_type"],
        seatingCapacity: (json["seating_capacity"] as num?)?.toInt(),
        floatingCapacity: (json["floating_capacity"] as num?)?.toInt(),
        totalArea: (json["total_area"] as num?)?.toInt(),
        spaceType: json["space_type"],
        airConditioned: json["air_conditioned"],
        hasDining: json["has_dining"],
        diningCapacity: (json["dining_capacity"] as num?)?.toInt(),
        description: json["description"],
        amenities: json["amenities"] == null
            ? []
            : List<Amenity>.from(
                json["amenities"]!.map((x) => Amenity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_name": eventName,
        "venue_type": venueType,
        "seating_capacity": seatingCapacity,
        "floating_capacity": floatingCapacity,
        "total_area": totalArea,
        "space_type": spaceType,
        "air_conditioned": airConditioned,
        "has_dining": hasDining,
        "dining_capacity": diningCapacity,
        "description": description,
        "amenities": amenities == null
            ? []
            : List<dynamic>.from(amenities!.map((x) => x.toJson())),
      };
}

class Amenity {
  String? id;
  String? name;
  String? description;

  Amenity({
    this.id,
    this.name,
    this.description,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}

class HallDetails {
  String? id;
  String? name;
  String? location;
  List<String>? eventType;
  List<String>? businessType;
  String? coverImageUrl;
  List<String>? galleryImages;
  String? floorPlanImageUrl;

  HallDetails({
    this.id,
    this.name,
    this.location,
    this.eventType,
    this.businessType,
    this.coverImageUrl,
    this.galleryImages,
    this.floorPlanImageUrl,
  });

  factory HallDetails.fromJson(Map<String, dynamic> json) => HallDetails(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        eventType: json["event_type"] == null
            ? []
            : List<String>.from(json["event_type"]!.map((x) => x)),
        businessType: json["business_type"] == null
            ? []
            : List<String>.from(json["business_type"]!.map((x) => x)),
        coverImageUrl: json["cover_image_url"],
        galleryImages: json["gallery_images"] == null
            ? []
            : List<String>.from(json["gallery_images"]!.map((x) => x)),
        floorPlanImageUrl: json["floor_plan_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "event_type": eventType == null
            ? []
            : List<dynamic>.from(eventType!.map((x) => x)),
        "business_type": businessType == null
            ? []
            : List<dynamic>.from(businessType!.map((x) => x)),
        "cover_image_url": coverImageUrl,
        "gallery_images": galleryImages == null
            ? []
            : List<dynamic>.from(galleryImages!.map((x) => x)),
        "floor_plan_image_url": floorPlanImageUrl,
      };
}
