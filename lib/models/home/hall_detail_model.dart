class HallDetailModel {
  String? id;
  PropertyInfo? propertyInfo;
  LocationInfo? locationInfo;
  MediaInfo? mediaInfo;
  List<EventArea>? eventAreas;
  BanquetPolicies? banquetPolicies;
  FinanceAndLegal? financeAndLegal;
  String? message;

  HallDetailModel({
    this.id,
    this.propertyInfo,
    this.locationInfo,
    this.mediaInfo,
    this.eventAreas,
    this.banquetPolicies,
    this.financeAndLegal,
    this.message,
  });

  factory HallDetailModel.fromJson(Map<String, dynamic> json) =>
      HallDetailModel(
        id: json["id"],
        propertyInfo: json["propertyInfo"] == null
            ? null
            : PropertyInfo.fromJson(json["propertyInfo"]),
        locationInfo: json["locationInfo"] == null
            ? null
            : LocationInfo.fromJson(json["locationInfo"]),
        mediaInfo: json["mediaInfo"] == null
            ? null
            : MediaInfo.fromJson(json["mediaInfo"]),
        eventAreas: json["eventAreas"] == null
            ? []
            : List<EventArea>.from(
                json["eventAreas"]!.map((x) => EventArea.fromJson(x))),
        banquetPolicies: json["banquetPolicies"] == null
            ? null
            : BanquetPolicies.fromJson(json["banquetPolicies"]),
        financeAndLegal: json["financeAndLegal"] == null
            ? null
            : FinanceAndLegal.fromJson(json["financeAndLegal"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "propertyInfo": propertyInfo?.toJson(),
        "locationInfo": locationInfo?.toJson(),
        "mediaInfo": mediaInfo?.toJson(),
        "eventAreas": eventAreas == null
            ? []
            : List<dynamic>.from(eventAreas!.map((x) => x.toJson())),
        "banquetPolicies": banquetPolicies?.toJson(),
        "financeAndLegal": financeAndLegal?.toJson(),
        "message": message,
      };

  // Helper getters for UI consistency
  String get name => propertyInfo?.name ?? '';
  String get location =>
      "${locationInfo?.city ?? ''}, ${locationInfo?.state ?? ''}";
  List<String> get galleryImages => mediaInfo?.galleryImages ?? [];
  String? get coverImageUrl => mediaInfo?.coverImageUrl;
  String? get description => propertyInfo?.description;
  String? get bestPrice {
    if (eventAreas == null || eventAreas!.isEmpty) return null;
    double? minPrice;
    for (var area in eventAreas!) {
      if (area.price != null) {
        if (minPrice == null || area.price! < minPrice) {
          minPrice = area.price;
        }
      }
    }
    return minPrice?.toString();
  }

  List<String> get amenities {
    if (eventAreas == null || eventAreas!.isEmpty) return [];
    final Set<String> uniqueAmenities = {};
    for (var area in eventAreas!) {
      if (area.amenities != null) {
        for (var amenity in area.amenities!) {
          if (amenity.name != null) {
            uniqueAmenities.add(amenity.name!);
          }
        }
      }
    }
    return uniqueAmenities.toList();
  }
}

class PropertyInfo {
  String? name;
  List<String>? eventType;
  List<String>? businessType;
  String? yearBuild;
  String? yearRenovated;
  String? description;

  PropertyInfo({
    this.name,
    this.eventType,
    this.businessType,
    this.yearBuild,
    this.yearRenovated,
    this.description,
  });

  factory PropertyInfo.fromJson(Map<String, dynamic> json) => PropertyInfo(
        name: json["name"],
        eventType: json["event_type"] == null
            ? []
            : List<String>.from(json["event_type"]!.map((x) => x)),
        businessType: json["Business_type"] == null
            ? []
            : List<String>.from(json["Business_type"]!.map((x) => x)),
        yearBuild: json["Year_build"],
        yearRenovated: json["year_renovated"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "event_type": eventType == null
            ? []
            : List<dynamic>.from(eventType!.map((x) => x)),
        "Business_type": businessType == null
            ? []
            : List<dynamic>.from(businessType!.map((x) => x)),
        "Year_build": yearBuild,
        "year_renovated": yearRenovated,
        "description": description,
      };
}

class LocationInfo {
  String? city;
  String? state;
  String? country;
  String? postcode;
  String? address;
  String? latitude;
  String? longitude;
  bool? termsandcondition;

  LocationInfo({
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.address,
    this.latitude,
    this.longitude,
    this.termsandcondition,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) => LocationInfo(
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postcode: json["postcode"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        termsandcondition: json["termsandcondition"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "country": country,
        "postcode": postcode,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "termsandcondition": termsandcondition,
      };
}

class MediaInfo {
  String? coverImageUrl;
  List<String>? galleryImages;
  List<String>? videos;

  MediaInfo({
    this.coverImageUrl,
    this.galleryImages,
    this.videos,
  });

  factory MediaInfo.fromJson(Map<String, dynamic> json) => MediaInfo(
        coverImageUrl: json["cover_image_url"],
        galleryImages: json["gallery_images"] == null
            ? []
            : List<String>.from(json["gallery_images"]!.map((x) => x)),
        videos: json["videos"] == null
            ? []
            : List<String>.from(json["videos"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "cover_image_url": coverImageUrl,
        "gallery_images": galleryImages == null
            ? []
            : List<dynamic>.from(galleryImages!.map((x) => x)),
        "videos":
            videos == null ? [] : List<dynamic>.from(videos!.map((x) => x)),
      };
}

class EventArea {
  String? id;
  String? eventName;
  String? venueType;
  int? seatingCapacity;
  int? floatingCapacity;
  int? totalArea;
  int? totalRooms;
  bool? airConditioned;
  String? spaceType;
  String? description;
  double? price;
  dynamic offerPrice;
  bool? hasDining;
  int? diningCapacity;
  bool? isActive;
  List<Amenity>? amenities;

  EventArea({
    this.id,
    this.eventName,
    this.venueType,
    this.seatingCapacity,
    this.floatingCapacity,
    this.totalArea,
    this.totalRooms,
    this.airConditioned,
    this.spaceType,
    this.description,
    this.price,
    this.offerPrice,
    this.hasDining,
    this.diningCapacity,
    this.isActive,
    this.amenities,
  });

  factory EventArea.fromJson(Map<String, dynamic> json) => EventArea(
        id: json["id"],
        eventName: json["event_name"],
        venueType: json["venue_type"],
        seatingCapacity: (json["seating_capacity"] as num?)?.toInt(),
        floatingCapacity: (json["floating_capacity"] as num?)?.toInt(),
        totalArea: (json["total_area"] as num?)?.toInt(),
        totalRooms: (json["total_rooms"] as num?)?.toInt(),
        airConditioned: json["air_conditioned"],
        spaceType: json["space_type"],
        description: json["description"],
        price: json["price"] != null
            ? double.tryParse(json["price"].toString())
            : null,
        offerPrice: json["offer_price"],
        hasDining: json["has_dining"],
        diningCapacity: (json["dining_capacity"] as num?)?.toInt(),
        isActive: json["is_active"],
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
        "total_rooms": totalRooms,
        "air_conditioned": airConditioned,
        "space_type": spaceType,
        "description": description,
        "price": price,
        "offer_price": offerPrice,
        "has_dining": hasDining,
        "dining_capacity": diningCapacity,
        "is_active": isActive,
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

class BanquetPolicies {
  String? id;
  String? hallId;
  String? checkInTime;
  String? checkOutTime;
  List<String>? acceptableIdentityProofs;
  String? cancellationPolicy;
  int? cancellationDays;
  int? parkingCapacity;
  int? propertyExtraCharges;
  bool? decorationAllowed;
  bool? valetParkingAvailable;
  bool? isActive;

  BanquetPolicies({
    this.id,
    this.hallId,
    this.checkInTime,
    this.checkOutTime,
    this.acceptableIdentityProofs,
    this.cancellationPolicy,
    this.cancellationDays,
    this.parkingCapacity,
    this.propertyExtraCharges,
    this.decorationAllowed,
    this.valetParkingAvailable,
    this.isActive,
  });

  factory BanquetPolicies.fromJson(Map<String, dynamic> json) =>
      BanquetPolicies(
        id: json["id"],
        hallId: json["hall_id"],
        checkInTime: json["check_in_time"],
        checkOutTime: json["check_out_time"],
        acceptableIdentityProofs: json["acceptable_identity_proofs"] == null
            ? []
            : List<String>.from(
                json["acceptable_identity_proofs"]!.map((x) => x)),
        cancellationPolicy: json["cancellation_policy"],
        cancellationDays: (json["cancellationDays"] as num?)?.toInt(),
        parkingCapacity: (json["parking_capacity"] as num?)?.toInt(),
        propertyExtraCharges: (json["property_extra_charges"] as num?)?.toInt(),
        decorationAllowed: json["decoration_allowed"],
        valetParkingAvailable: json["valet_parking_available"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hall_id": hallId,
        "check_in_time": checkInTime,
        "check_out_time": checkOutTime,
        "acceptable_identity_proofs": acceptableIdentityProofs == null
            ? []
            : List<dynamic>.from(acceptableIdentityProofs!.map((x) => x)),
        "cancellation_policy": cancellationPolicy,
        "cancellationDays": cancellationDays,
        "parking_capacity": parkingCapacity,
        "property_extra_charges": propertyExtraCharges,
        "decoration_allowed": decorationAllowed,
        "valet_parking_available": valetParkingAvailable,
        "is_active": isActive,
      };
}

class FinanceAndLegal {
  String? id;
  String? hallId;
  String? ownershipType;
  String? panCardDetails;
  String? gstDetails;
  String? propertyRestrictions;
  List<String>? registrationDocument;
  List<String>? documentImageUrl;
  bool? isActive;

  FinanceAndLegal({
    this.id,
    this.hallId,
    this.ownershipType,
    this.panCardDetails,
    this.gstDetails,
    this.propertyRestrictions,
    this.registrationDocument,
    this.documentImageUrl,
    this.isActive,
  });

  factory FinanceAndLegal.fromJson(Map<String, dynamic> json) =>
      FinanceAndLegal(
        id: json["id"],
        hallId: json["hall_id"],
        ownershipType: json["ownershipType"],
        panCardDetails: json["panCardDetails"],
        gstDetails: json["gstDetails"],
        propertyRestrictions: json["propertyRestrictions"],
        registrationDocument: json["registrationDocument"] == null
            ? []
            : List<String>.from(json["registrationDocument"]!.map((x) => x)),
        documentImageUrl: json["document_image_url"] == null
            ? []
            : List<String>.from(json["document_image_url"]!.map((x) => x)),
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hall_id": hallId,
        "ownershipType": ownershipType,
        "panCardDetails": panCardDetails,
        "gstDetails": gstDetails,
        "propertyRestrictions": propertyRestrictions,
        "registrationDocument": registrationDocument == null
            ? []
            : List<dynamic>.from(registrationDocument!.map((x) => x)),
        "document_image_url": documentImageUrl == null
            ? []
            : List<dynamic>.from(documentImageUrl!.map((x) => x)),
        "is_active": isActive,
      };
}
