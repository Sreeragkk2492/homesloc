class TourismDetailModel {
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
  String? description;
  String? priceWithoutFlight;
  dynamic priceWithFlight;
  dynamic offerPrice;
  List<String>? galleryImages;
  List<TourismAmenity>? amenities;
  List<Itinerary>? itinerary;
  List<String>? images;
  AgencyDetails? agencyDetails;
  String? message;

  TourismDetailModel({
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
    this.description,
    this.priceWithoutFlight,
    this.priceWithFlight,
    this.offerPrice,
    this.galleryImages,
    this.amenities,
    this.itinerary,
    this.images,
    this.agencyDetails,
    this.message,
  });

  factory TourismDetailModel.fromJson(Map<String, dynamic> json) {
    return TourismDetailModel(
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
      description: json["description"],
      priceWithoutFlight: json["price_without_flight"]?.toString(),
      priceWithFlight: json["price_with_flight"],
      offerPrice: json["offer_price"],
      galleryImages: json["gallery_images"] == null
          ? []
          : List<String>.from(json["gallery_images"].map((x) => x)),
      amenities: json["amenities"] == null
          ? []
          : List<TourismAmenity>.from(
              json["amenities"].map((x) => TourismAmenity.fromJson(x))),
      itinerary: json["itinerary"] == null
          ? []
          : List<Itinerary>.from(
              json["itinerary"].map((x) => Itinerary.fromJson(x))),
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"].map((x) => x)),
      agencyDetails: json["agency_details"] == null
          ? null
          : AgencyDetails.fromJson(json["agency_details"]),
      message: json["message"],
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
        "description": description,
        "price_without_flight": priceWithoutFlight,
        "price_with_flight": priceWithFlight,
        "offer_price": offerPrice,
        "gallery_images": galleryImages,
        "amenities": amenities == null
            ? []
            : List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "itinerary": itinerary == null
            ? []
            : List<dynamic>.from(itinerary!.map((x) => x.toJson())),
        "images": images,
        "agency_details": agencyDetails?.toJson(),
        "message": message,
      };
}

class MiddlePlace {
  String? place;
  MiddlePlace({this.place});
  factory MiddlePlace.fromJson(Map<String, dynamic> json) =>
      MiddlePlace(place: json["place"]);
  Map<String, dynamic> toJson() => {"place": place};
}

class TripAttraction {
  String? attractions;
  TripAttraction({this.attractions});
  factory TripAttraction.fromJson(Map<String, dynamic> json) =>
      TripAttraction(attractions: json["attractions"]);
  Map<String, dynamic> toJson() => {"attractions": attractions};
}

class TripExclusion {
  String? exclusions;
  TripExclusion({this.exclusions});
  factory TripExclusion.fromJson(Map<String, dynamic> json) =>
      TripExclusion(exclusions: json["exclusions"]);
  Map<String, dynamic> toJson() => {"exclusions": exclusions};
}

class TourismAmenity {
  String? id;
  String? name;
  String? description;
  TourismAmenity({this.id, this.name, this.description});
  factory TourismAmenity.fromJson(Map<String, dynamic> json) => TourismAmenity(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );
  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "description": description};
}

class Itinerary {
  String? id;
  String? day;
  String? description;
  String? location;
  String? mealPlan;

  Itinerary(
      {this.id, this.day, this.description, this.location, this.mealPlan});

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      id: json["id"],
      day: json["day"],
      description: json["description"],
      location: json["location"],
      mealPlan: json["meal_plan"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "description": description,
        "location": location,
        "meal_plan": mealPlan,
      };
}

class AgencyDetails {
  String? id;
  String? name;
  String? startedSince;
  String? email;
  String? phoneNumber;
  String? coverImageUrl;
  String? description;
  List<String>? videos;
  List<dynamic>? amenities;
  List<dynamic>? packages;
  Policies? policies;

  AgencyDetails({
    this.id,
    this.name,
    this.startedSince,
    this.email,
    this.phoneNumber,
    this.coverImageUrl,
    this.description,
    this.videos,
    this.amenities,
    this.packages,
    this.policies,
  });

  factory AgencyDetails.fromJson(Map<String, dynamic> json) {
    return AgencyDetails(
      id: json["id"],
      name: json["name"],
      startedSince: json["started_since"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      coverImageUrl: json["cover_image_url"],
      description: json["description"],
      videos: json["videos"] == null
          ? []
          : List<String>.from(json["videos"].map((x) => x)),
      amenities: json["amenities"],
      packages: json["packages"],
      policies:
          json["policies"] == null ? null : Policies.fromJson(json["policies"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "started_since": startedSince,
        "email": email,
        "phone_number": phoneNumber,
        "cover_image_url": coverImageUrl,
        "description": description,
        "videos": videos,
        "amenities": amenities,
        "packages": packages,
        "policies": policies?.toJson(),
      };
}

class Policies {
  String? id;
  String? cancellationPolicy;
  int? cancellationDays;
  String? paymentPolicy;
  List<String>? acceptableIdentityProof;
  List<String>? tripTermsConditions;

  Policies({
    this.id,
    this.cancellationPolicy,
    this.cancellationDays,
    this.paymentPolicy,
    this.acceptableIdentityProof,
    this.tripTermsConditions,
  });

  factory Policies.fromJson(Map<String, dynamic> json) {
    return Policies(
      id: json["id"],
      cancellationPolicy: json["cancellationPolicy"],
      cancellationDays: (json["cancellationDays"] as num?)?.toInt(),
      paymentPolicy: json["paymentPolicy"],
      acceptableIdentityProof: json["acceptableIdentityProof"] == null
          ? []
          : List<String>.from(json["acceptableIdentityProof"].map((x) => x)),
      tripTermsConditions: json["tripTermsConditions"] == null
          ? []
          : List<String>.from(json["tripTermsConditions"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cancellationPolicy": cancellationPolicy,
        "cancellationDays": cancellationDays,
        "paymentPolicy": paymentPolicy,
        "acceptableIdentityProof": acceptableIdentityProof,
        "tripTermsConditions": tripTermsConditions,
      };
}
