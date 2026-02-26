class HotelDetailModel {
  String? id;
  String? uniqueId;
  String? name;
  String? location;
  String? phoneNumber;
  String? coverImageUrl;
  List<String>? galleryImages;
  num? starRating;
  num? reviewCount;
  String? description;
  String? latitude;
  String? longitude;
  List<String>? amenities;
  List<TransportationInfo>? transportationInfo;
  Policies? policies;
  Pricing? pricing;
  List<dynamic>? reviews;
  bool? isFavorite;
  List<EventArea>? eventAreas;

  HotelDetailModel({
    this.id,
    this.uniqueId,
    this.name,
    this.location,
    this.phoneNumber,
    this.coverImageUrl,
    this.galleryImages,
    this.starRating,
    this.reviewCount,
    this.description,
    this.latitude,
    this.longitude,
    this.amenities,
    this.transportationInfo,
    this.policies,
    this.pricing,
    this.reviews,
    this.isFavorite,
    this.eventAreas,
  });

  factory HotelDetailModel.fromJson(Map<String, dynamic> json) =>
      HotelDetailModel(
        id: json["id"],
        uniqueId: json["unique_id"],
        name: json["name"],
        location: json["location"],
        phoneNumber: json["phone_number"],
        coverImageUrl: json["cover_image_url"],
        galleryImages: json["gallery_images"] == null
            ? []
            : List<String>.from(json["gallery_images"]),
        starRating: json["star_rating"],
        reviewCount: json["review_count"],
        description: json["description"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        amenities: json["amenities"] == null
            ? []
            : List<String>.from(json["amenities"]),
        transportationInfo: json["transportation_info"] == null
            ? []
            : List<TransportationInfo>.from(json["transportation_info"]
                .map((x) => TransportationInfo.fromJson(x))),
        policies: json["policies"] == null
            ? null
            : Policies.fromJson(json["policies"]),
        pricing:
            json["pricing"] == null ? null : Pricing.fromJson(json["pricing"]),
        reviews:
            json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]),
        isFavorite: json["is_favorite"],
        eventAreas: null,
      );

  factory HotelDetailModel.fromRoomJson(Map<String, dynamic> json) {
    Map<String, dynamic> hotel = json["hotel_details"] ?? {};

    // Map policies
    Policies? pol;
    if (hotel["policies"] != null) {
      pol = Policies.fromJson(hotel["policies"]);
    } else {
      pol = Policies(
        checkInTime: hotel["check_in_time"],
        checkOutTime: hotel["check_out_time"],
      );
    }

    // Map amenities from the room level
    List<String> amens = [];
    if (json["amenities"] != null) {
      for (var item in json["amenities"]) {
        if (item is Map && item["name"] != null) {
          amens.add(item["name"]);
        }
      }
    }

    String? roomId;

    // Check hotel_details['rooms'] as priority
    if (hotel["rooms"] != null &&
        hotel["rooms"] is List &&
        (hotel["rooms"] as List).isNotEmpty) {
      roomId = hotel["rooms"][0]["id"];
    }
    // Fallback to json['rooms']
    else if (json["rooms"] != null &&
        json["rooms"] is List &&
        (json["rooms"] as List).isNotEmpty) {
      roomId = json["rooms"][0]["id"];
    }
    // Fallback to direct ID
    else {
      roomId = json["id"] ?? hotel["id"];
    }

    return HotelDetailModel(
      id: roomId,
      name: json["room_name"] ?? hotel["name"],
      location: hotel["location"] ??
          "${hotel["city"] ?? ''}, ${hotel["state"] ?? ''}, ${hotel["country"] ?? ''}",
      phoneNumber: hotel["phone_number"],
      // Use room images as gallery
      galleryImages: json["room_images"] != null
          ? List<String>.from(json["room_images"])
          : [],
      // Use the first room image as cover if available
      coverImageUrl: (json["room_images"] != null &&
              (json["room_images"] as List).isNotEmpty)
          ? json["room_images"][0]
          : hotel["cover_image_url"],
      starRating: hotel["star_rating"],
      // reviewCount isn't explicitly in room response, maybe default to 0 or null
      description: json["description"] ?? hotel["description"],
      latitude: hotel["latitude"] ?? json["latitude"],
      longitude: hotel["longitude"] ?? json["longitude"],
      amenities: amens,
      policies: pol,
      // Pricing requires careful mapping
      pricing: Pricing(
        bestPrice: json["price"]?.toString(),
        offerPrice: json["offer_price"],
      ),
      eventAreas: null,
    );
  }

  factory HotelDetailModel.fromFullPropertyJson(Map<String, dynamic> json) {
    Map<String, dynamic> hotel = json["hotel_details"] ?? {};
    Map<String, dynamic> property = json["property_details"] ?? {};
    List<dynamic> fullProperty =
        hotel["full_property"] ?? json["full_property"] ?? [];

    // Map policies
    Policies? pol;
    if (hotel["policies"] != null) {
      pol = Policies.fromJson(hotel["policies"]);
    } else {
      pol = Policies(
        checkInTime: hotel["check_in_time"],
        checkOutTime: hotel["check_out_time"],
      );
    }

    // Map amenities from the top-level amenity_ids
    List<String> amens = [];
    if (json["amenity_ids"] != null) {
      for (var item in json["amenity_ids"]) {
        if (item is Map && item["name"] != null) {
          amens.add(item["name"]);
        }
      }
    }

    // Map images
    List<String> images = [];
    if (json["images"] != null) {
      images = List<String>.from(json["images"]);
    }

    // Determine ID (Priority: full_property[0].id -> property_details.id -> hotel_details.id)
    String? finalId;
    if (fullProperty.isNotEmpty && fullProperty[0] is Map) {
      finalId = fullProperty[0]["id"];
    }
    finalId ??= property["id"] ?? hotel["id"] ?? json["id"];

    // Determine Pricing (Priority: full_property -> property_details -> json root)
    String? bestPrice;
    dynamic offerPrice;

    if (fullProperty.isNotEmpty && fullProperty[0] is Map) {
      bestPrice = fullProperty[0]["base_property_price"]?.toString();
      offerPrice = fullProperty[0]["offer_price"];
    }

    // Fallback pricing
    bestPrice ??= property["base_property_price"]?.toString() ??
        json["base_property_price"]?.toString();
    offerPrice ??= property["offer_price"] ?? json["offer_price"];

    return HotelDetailModel(
      id: finalId,
      name: hotel["name"],
      location: hotel["location"] ??
          "${hotel["city"] ?? ''}, ${hotel["state"] ?? ''}, ${hotel["country"] ?? ''}",
      phoneNumber: hotel["phone_number"],
      galleryImages: images,
      coverImageUrl: images.isNotEmpty ? images[0] : hotel["cover_image_url"],
      starRating: hotel["star_rating"],
      description: hotel["description"],
      latitude: hotel["latitude"] ?? property["latitude"] ?? json["latitude"],
      longitude:
          hotel["longitude"] ?? property["longitude"] ?? json["longitude"],
      amenities: amens,
      policies: pol,
      // Pricing requires careful mapping
      pricing: Pricing(
        bestPrice: bestPrice,
        offerPrice: offerPrice,
      ),
      eventAreas: null,
    );
  }

  factory HotelDetailModel.fromHallJson(Map<String, dynamic> json) {
    final propInfo = json["propertyInfo"] ?? {};
    final locInfo = json["locationInfo"] ?? {};
    final mediaInfo = json["mediaInfo"] ?? {};
    final policies = json["banquetPolicies"] ?? {};

    // Map policies
    Policies pol = Policies(
      checkInTime: policies["check_in_time"],
      checkOutTime: policies["check_out_time"],
      cancellationPolicy: policies["cancellation_policy"],
    );

    // Map images
    List<String> images = [];
    if (mediaInfo["gallery_images"] != null) {
      images = List<String>.from(mediaInfo["gallery_images"]);
    }

    // Map Event Areas
    List<EventArea> events = [];
    if (json["eventAreas"] != null) {
      events = List<EventArea>.from(
          json["eventAreas"].map((x) => EventArea.fromJson(x)));
    }

    // Calculate best price from events (min price)
    double? minPrice;
    Set<String> uniqueAmenities = {};

    for (var event in events) {
      if (event.price != null) {
        if (minPrice == null || event.price! < minPrice) {
          minPrice = event.price;
        }
      }
      if (event.amenities != null) {
        uniqueAmenities.addAll(event.amenities!);
      }
    }

    return HotelDetailModel(
      id: json["id"],
      name: propInfo["name"],
      location:
          "${locInfo["city"] ?? ''}, ${locInfo["state"] ?? ''}, ${locInfo["country"] ?? ''}",
      phoneNumber: null, // Phone not in JSON example
      coverImageUrl: mediaInfo["cover_image_url"],
      galleryImages: images,
      starRating: 5, // Default or derived
      reviewCount: 0,
      description: propInfo["description"],
      latitude: locInfo["latitude"],
      longitude: locInfo["longitude"],
      amenities: uniqueAmenities.toList(),
      policies: pol,
      pricing: Pricing(
        bestPrice: minPrice?.toString(),
        offerPrice: null,
      ),
      eventAreas: events,
      isFavorite: false, // Default to false if not provided
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "unique_id": uniqueId,
        "name": name,
        "location": location,
        "phone_number": phoneNumber,
        "cover_image_url": coverImageUrl,
        "gallery_images": galleryImages == null
            ? []
            : List<dynamic>.from(galleryImages!.map((x) => x)),
        "star_rating": starRating,
        "review_count": reviewCount,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
        "amenities": amenities == null
            ? []
            : List<dynamic>.from(amenities!.map((x) => x)),
        "transportation_info": transportationInfo == null
            ? []
            : List<dynamic>.from(transportationInfo!.map((x) => x.toJson())),
        "policies": policies?.toJson(),
        "pricing": pricing?.toJson(),
        "reviews":
            reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
        "is_favorite": isFavorite,
        "event_areas": eventAreas == null
            ? []
            : List<dynamic>.from(eventAreas!.map((x) => x.toJson())),
      };
}

class TransportationInfo {
  String? type;
  String? distance;

  TransportationInfo({this.type, this.distance});

  factory TransportationInfo.fromJson(Map<String, dynamic> json) =>
      TransportationInfo(
        type: json["type"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "distance": distance,
      };
}

class Policies {
  String? checkInTime;
  String? checkOutTime;
  String? cancellationPolicy;

  Policies({this.checkInTime, this.checkOutTime, this.cancellationPolicy});

  factory Policies.fromJson(Map<String, dynamic> json) => Policies(
        checkInTime: json["check_in_time"],
        checkOutTime: json["check_out_time"],
        cancellationPolicy: json["cancellation_policy"],
      );

  Map<String, dynamic> toJson() => {
        "check_in_time": checkInTime,
        "check_out_time": checkOutTime,
        "cancellation_policy": cancellationPolicy,
      };
}

class Pricing {
  String? bestPrice;
  dynamic offerPrice;
  String? taxInfo;

  Pricing({this.bestPrice, this.offerPrice, this.taxInfo});

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
        bestPrice: json["best_price"],
        offerPrice: json["offer_price"],
        taxInfo: json["tax_info"],
      );

  Map<String, dynamic> toJson() => {
        "best_price": bestPrice,
        "offer_price": offerPrice,
        "tax_info": taxInfo,
      };
}

class EventArea {
  String? id;
  String? eventName;
  String? venueType;
  int? seatingCapacity;
  int? floatingCapacity;
  String? spaceType;
  double? price;
  String? description;
  List<String>? amenities;

  EventArea({
    this.id,
    this.eventName,
    this.venueType,
    this.seatingCapacity,
    this.floatingCapacity,
    this.spaceType,
    this.price,
    this.description,
    this.amenities,
  });

  factory EventArea.fromJson(Map<String, dynamic> json) {
    List<String> amens = [];
    if (json["amenities"] != null) {
      for (var item in json["amenities"]) {
        if (item is Map && item["name"] != null) {
          amens.add(item["name"]);
        }
      }
    }

    return EventArea(
      id: json["id"],
      eventName: json["event_name"],
      venueType: json["venue_type"],
      seatingCapacity: json["seating_capacity"],
      floatingCapacity: json["floating_capacity"],
      spaceType: json["space_type"],
      price: json["price"] != null
          ? double.tryParse(json["price"].toString())
          : null,
      description: json["description"],
      amenities: amens,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_name": eventName,
        "venue_type": venueType,
        "seating_capacity": seatingCapacity,
        "floating_capacity": floatingCapacity,
        "space_type": spaceType,
        "price": price,
        "description": description,
        "amenities": amenities,
      };
}
