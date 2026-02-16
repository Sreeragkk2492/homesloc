class TourismSearchModel {
  List<TourismPackage>? packages;
  int? totalCount;
  int? currentPage;
  int? totalPages;
  bool? hasNext;
  bool? hasPrevious;
  String? message;

  TourismSearchModel({
    this.packages,
    this.totalCount,
    this.currentPage,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
    this.message,
  });

  factory TourismSearchModel.fromJson(Map<String, dynamic> json) {
    return TourismSearchModel(
      packages: json["packages"] == null
          ? []
          : List<TourismPackage>.from(
              json["packages"].map((x) => TourismPackage.fromJson(x))),
      totalCount: (json["total_count"] as num?)?.toInt(),
      currentPage: (json["current_page"] as num?)?.toInt(),
      totalPages: (json["total_pages"] as num?)?.toInt(),
      hasNext: json["has_next"],
      hasPrevious: json["has_previous"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "packages": packages == null
            ? []
            : List<dynamic>.from(packages!.map((x) => x.toJson())),
        "total_count": totalCount,
        "current_page": currentPage,
        "total_pages": totalPages,
        "has_next": hasNext,
        "has_previous": hasPrevious,
        "message": message,
      };
}

class TourismPackage {
  String? id;
  String? packageName;
  String? packageType;
  String? startLocation;
  String? destination;
  int? totalCapacity;
  int? children;
  List<MiddlePlace>? packageMiddlePlace;
  List<TripAttraction>? tripAttractions;
  List<TripExclusion>? tripExclusions;
  int? durationDays;
  int? durationNights;
  int? priceWithoutFlight;
  dynamic priceWithFlight;
  dynamic offerPrice;
  List<String>? galleryImages;
  List<TourismAmenity>? amenities;
  String? agencyName;

  TourismPackage({
    this.id,
    this.packageName,
    this.packageType,
    this.startLocation,
    this.destination,
    this.totalCapacity,
    this.children,
    this.packageMiddlePlace,
    this.tripAttractions,
    this.tripExclusions,
    this.durationDays,
    this.durationNights,
    this.priceWithoutFlight,
    this.priceWithFlight,
    this.offerPrice,
    this.galleryImages,
    this.amenities,
    this.agencyName,
  });

  factory TourismPackage.fromJson(Map<String, dynamic> json) {
    return TourismPackage(
      id: json["id"],
      packageName: json["package_name"],
      packageType: json["package_type"],
      startLocation: json["start_location"],
      destination: json["destination"],
      totalCapacity: (json["total_capacity"] as num?)?.toInt(),
      children: (json["children"] as num?)?.toInt(),
      packageMiddlePlace: json["package_middle_place"] == null
          ? []
          : List<MiddlePlace>.from(
              json["package_middle_place"].map((x) => MiddlePlace.fromJson(x))),
      tripAttractions: json["trip_attractions"] == null
          ? []
          : List<TripAttraction>.from(
              json["trip_attractions"].map((x) => TripAttraction.fromJson(x))),
      tripExclusions: json["trip_exclusions"] == null
          ? []
          : List<TripExclusion>.from(
              json["trip_exclusions"].map((x) => TripExclusion.fromJson(x))),
      durationDays: (json["duration_days"] as num?)?.toInt(),
      durationNights: (json["duration_nights"] as num?)?.toInt(),
      priceWithoutFlight: (json["price_without_flight"] as num?)?.toInt(),
      priceWithFlight: json["price_with_flight"],
      offerPrice: json["offer_price"],
      galleryImages: json["gallery_images"] == null
          ? []
          : List<String>.from(json["gallery_images"].map((x) => x)),
      amenities: json["amenities"] == null
          ? []
          : List<TourismAmenity>.from(
              json["amenities"].map((x) => TourismAmenity.fromJson(x))),
      agencyName: json["agencyname"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "package_name": packageName,
        "package_type": packageType,
        "start_location": startLocation,
        "destination": destination,
        "total_capacity": totalCapacity,
        "children": children,
        "package_middle_place": packageMiddlePlace == null
            ? []
            : List<dynamic>.from(packageMiddlePlace!.map((x) => x.toJson())),
        "trip_attractions": tripAttractions == null
            ? []
            : List<dynamic>.from(tripAttractions!.map((x) => x.toJson())),
        "trip_exclusions": tripExclusions == null
            ? []
            : List<dynamic>.from(tripExclusions!.map((x) => x.toJson())),
        "duration_days": durationDays,
        "duration_nights": durationNights,
        "price_without_flight": priceWithoutFlight,
        "price_with_flight": priceWithFlight,
        "offer_price": offerPrice,
        "gallery_images": galleryImages,
        "amenities": amenities == null
            ? []
            : List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "agencyname": agencyName,
      };
}

class MiddlePlace {
  String? place;

  MiddlePlace({this.place});

  factory MiddlePlace.fromJson(Map<String, dynamic> json) {
    return MiddlePlace(place: json["place"]);
  }

  Map<String, dynamic> toJson() => {"place": place};
}

class TripAttraction {
  String? attractions;

  TripAttraction({this.attractions});

  factory TripAttraction.fromJson(Map<String, dynamic> json) {
    return TripAttraction(attractions: json["attractions"]);
  }

  Map<String, dynamic> toJson() => {"attractions": attractions};
}

class TripExclusion {
  String? exclusions;

  TripExclusion({this.exclusions});

  factory TripExclusion.fromJson(Map<String, dynamic> json) {
    return TripExclusion(exclusions: json["exclusions"]);
  }

  Map<String, dynamic> toJson() => {"exclusions": exclusions};
}

class TourismAmenity {
  String? id;
  String? name;
  String? description;

  TourismAmenity({this.id, this.name, this.description});

  factory TourismAmenity.fromJson(Map<String, dynamic> json) {
    return TourismAmenity(
      id: json["id"],
      name: json["name"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
