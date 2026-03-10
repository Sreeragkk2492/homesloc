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
  List<HotelRoom>? rooms;
  String? roomName;
  String? roomDescription;
  int? yearBuild;
  int? yearRenovated;
  List<NearByAttraction>? nearByAttractions;
  bool? isFullProperty;

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
    this.rooms,
    this.roomName,
    this.roomDescription,
    this.yearBuild,
    this.yearRenovated,
    this.nearByAttractions,
    this.isFullProperty,
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
            : (json["amenity_ids"] != null ||
                    (json["amenities"] is List &&
                        (json["amenities"] as List).isNotEmpty &&
                        (json["amenities"] as List).first is Map))
                ? (json["amenities"] as List).map((e) {
                    if (e is Map && e["name"] != null)
                      return e["name"].toString();
                    return e.toString();
                  }).toList()
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
        eventAreas: json["event_areas"] != null
            ? List<EventArea>.from(
                json["event_areas"].map((x) => EventArea.fromJson(x)))
            : null,
        rooms: json["rooms"] != null
            ? List<HotelRoom>.from(
                json["rooms"].map((x) => HotelRoom.fromJson(x)))
            : (json["hotel_details"] != null &&
                    json["hotel_details"]["rooms"] != null
                ? List<HotelRoom>.from(json["hotel_details"]["rooms"]
                    .map((x) => HotelRoom.fromJson(x)))
                : []),
        yearBuild: json["year_build"] ??
            (json["hotel_details"] != null
                ? json["hotel_details"]["year_build"]
                : null),
        yearRenovated: json["year_renovated"] ??
            (json["hotel_details"] != null
                ? json["hotel_details"]["year_renovated"]
                : null),
        nearByAttractions: json["near_by_attraction"] != null
            ? List<NearByAttraction>.from(json["near_by_attraction"]
                .map((x) => NearByAttraction.fromJson(x)))
            : (json["hotel_details"] != null &&
                    json["hotel_details"]["near_by_attraction"] != null
                ? List<NearByAttraction>.from(json["hotel_details"]
                        ["near_by_attraction"]
                    .map((x) => NearByAttraction.fromJson(x)))
                : null),
        isFullProperty: json["is_full_property"] ??
            (json["hotel_details"] != null
                ? json["hotel_details"]["is_full_property"]
                : null),
      );

  factory HotelDetailModel.fromRoomJson(Map<String, dynamic> json) {
    Map<String, dynamic> hotel = json["hotel_details"] ?? {};

    // Map policies
    Policies? pol;
    if (hotel["policies"] != null) {
      pol = Policies.fromJson(hotel["policies"]);
    } else {
      pol = Policies(
        checkInTime: hotel["check_in_time"] ?? hotel["checkInTime"],
        checkOutTime: hotel["check_out_time"] ?? hotel["checkOutTime"],
        cancellationPolicy:
            hotel["cancellation_policy"] ?? hotel["cancellationPolicy"],
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
      name: hotel["name"],
      roomName: json["room_name"],
      location: hotel["location"] ??
          "${hotel["city"] ?? ''}, ${hotel["state"] ?? ''}, ${hotel["country"] ?? ''}",
      phoneNumber: hotel["phone_number"],
      // Use room images as gallery
      galleryImages: json["room_images"] != null
          ? List<String>.from(json["room_images"])
          : [],
      // Use hotel images for hotel-level fields
      coverImageUrl: hotel["cover_image_url"] ??
          ((json["room_images"] != null &&
                  (json["room_images"] as List).isNotEmpty)
              ? json["room_images"][0]
              : null),
      starRating: hotel["star_rating"],
      // reviewCount isn't explicitly in room response, maybe default to 0 or null
      description: hotel["description"] ?? json["description"],
      roomDescription: json["description"],
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
      rooms: (hotel["rooms"] != null &&
              hotel["rooms"] is List &&
              (hotel["rooms"] as List).isNotEmpty)
          ? List<HotelRoom>.from(
              hotel["rooms"].map((x) => HotelRoom.fromJson(x)))
          : [],
      yearBuild: hotel["year_build"],
      yearRenovated: hotel["year_renovated"],
      nearByAttractions: hotel["near_by_attraction"] != null
          ? List<NearByAttraction>.from(hotel["near_by_attraction"]
              .map((x) => NearByAttraction.fromJson(x)))
          : (json["near_by_attraction"] != null
              ? List<NearByAttraction>.from(json["near_by_attraction"]
                  .map((x) => NearByAttraction.fromJson(x)))
              : null),
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
        checkInTime: hotel["check_in_time"] ?? hotel["checkInTime"],
        checkOutTime: hotel["check_out_time"] ?? hotel["checkOutTime"],
        cancellationPolicy:
            hotel["cancellation_policy"] ?? hotel["cancellationPolicy"],
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

    // Fallback to hotel_details amenities if property-specific ones are missing
    if (amens.isEmpty && hotel["amenities"] != null) {
      for (var item in hotel["amenities"]) {
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
      pricing: Pricing(
        bestPrice: bestPrice,
        offerPrice: offerPrice,
      ),
      eventAreas: null,
      rooms: (json["rooms"] != null && json["rooms"] is List)
          ? List<HotelRoom>.from(
              json["rooms"].map((x) => HotelRoom.fromJson(x)))
          : (hotel["rooms"] != null && hotel["rooms"] is List
              ? List<HotelRoom>.from(
                  hotel["rooms"].map((x) => HotelRoom.fromJson(x)))
              : []),
      yearBuild: hotel["year_build"] ?? json["year_build"],
      yearRenovated: hotel["year_renovated"] ?? json["year_renovated"],
      nearByAttractions: hotel["near_by_attraction"] != null
          ? List<NearByAttraction>.from(hotel["near_by_attraction"]
              .map((x) => NearByAttraction.fromJson(x)))
          : (json["near_by_attraction"] != null
              ? List<NearByAttraction>.from(json["near_by_attraction"]
                  .map((x) => NearByAttraction.fromJson(x)))
              : null),
      isFullProperty: json["is_full_property"] ??
          hotel["is_full_property"] ??
          (hotel["room_type"] == "FULL_PROPERTY"),
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
  List<String>? accommodationPolicies;

  // Structured Policy Fields
  String? extraBedPolicy;
  String? extraBedPrice;
  List<String>? acceptableIdentityProof;

  Policies({
    this.checkInTime,
    this.checkOutTime,
    this.cancellationPolicy,
    this.accommodationPolicies,
    this.extraBedPolicy,
    this.extraBedPrice,
    this.acceptableIdentityProof,
  });

  factory Policies.fromJson(Map<String, dynamic> json) {
    List<String> policiesList = [];
    if (json["propertyrules"] != null) {
      policiesList.addAll(json["propertyrules"]
          .toString()
          .split('\n')
          .where((s) => s.trim().isNotEmpty));
    }

    Policies pol = Policies(
      checkInTime: json["check_in_time"] ?? json["checkInTime"],
      checkOutTime: json["check_out_time"] ?? json["checkOutTime"],
      cancellationPolicy:
          json["cancellation_policy"] ?? json["cancellationPolicy"],
      accommodationPolicies: policiesList.isNotEmpty ? policiesList : null,
      extraBedPolicy: json["extraBedPolicy"]?.toString(),
      extraBedPrice: json["extra_bed_price"]?.toString(),
    );

    if (json["acceptableIdentityProof"] != null &&
        json["acceptableIdentityProof"] is List) {
      pol.acceptableIdentityProof =
          List<String>.from(json["acceptableIdentityProof"]);
    }

    return pol;
  }

  Map<String, dynamic> toJson() => {
        "check_in_time": checkInTime,
        "check_out_time": checkOutTime,
        "cancellation_policy": cancellationPolicy,
        "propertyrules": accommodationPolicies?.join('\n'),
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

class HotelRoom {
  String? id;
  String? name;
  num? starRating;
  String? roomType;
  String? bedType;
  int? maxPerson;
  String? mealOption;
  int? roomSize;
  int? quantity;
  String? price;
  dynamic offerPrice;
  List<String>? images;
  String? description;
  List<String>? amenities;
  List<Map<String, dynamic>>? slots; // freshup room slots
  String? freshupType;
  int? availableRoomsCount;

  HotelRoom({
    this.id,
    this.name,
    this.starRating,
    this.roomType,
    this.bedType,
    this.maxPerson,
    this.mealOption,
    this.roomSize,
    this.quantity,
    this.price,
    this.offerPrice,
    this.images,
    this.description,
    this.amenities,
    this.slots,
    this.freshupType,
    this.availableRoomsCount,
  });

  factory HotelRoom.fromJson(Map<String, dynamic> json) {
    // Pricing extraction
    String? basePrice;
    if (json["price"] != null) {
      basePrice = json["price"].toString();
    } else if (json["base_property_price"] != null) {
      basePrice = json["base_property_price"].toString();
    }

    // Image extraction
    List<String> roomImages = [];
    if (json["room_images"] != null) {
      roomImages = List<String>.from(json["room_images"]);
    } else if (json["images"] != null) {
      roomImages = List<String>.from(json["images"]);
    }

    // Amenities extraction
    List<String> amens = [];
    if (json["amenities"] != null && json["amenities"] is List) {
      for (var item in json["amenities"]) {
        if (item is String) {
          amens.add(item);
        } else if (item is Map && item["name"] != null) {
          amens.add(item["name"]);
        }
      }
    }

    return HotelRoom(
      id: json["id"]?.toString(),
      name: json["room_name"] ?? json["freshup_name"] ?? json["name"] ?? "Room",
      starRating: json["star_rating"] ?? 5,
      roomType: json["room_type"],
      bedType: json["bed_type"],
      maxPerson: json["max_person"] is int
          ? json["max_person"]
          : (json["max_persons"] is int
              ? json["max_persons"]
              : int.tryParse(
                  (json["max_person"] ?? json["max_persons"])?.toString() ??
                      '')),
      mealOption: json["meal_option"],
      roomSize: json["room_size"] is int
          ? json["room_size"]
          : int.tryParse(json["room_size"]?.toString() ?? ''),
      quantity: json["quantity"] is int
          ? json["quantity"]
          : int.tryParse(json["quantity"]?.toString() ?? ''),
      price: basePrice,
      offerPrice: json["offer_price"],
      images: roomImages,
      description: json["description"] ?? json["freshup_description"],
      amenities: amens,
      freshupType: json["freshup_type"],
      availableRoomsCount: json["available_rooms"] is int
          ? json["available_rooms"]
          : int.tryParse(json["available_rooms"]?.toString() ?? ''),
      slots: json["slots"] != null && json["slots"] is List
          ? List<Map<String, dynamic>>.from(
              json["slots"].map((s) => Map<String, dynamic>.from(s)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "room_name": name,
        "star_rating": starRating,
        "room_type": roomType,
        "bed_type": bedType,
        "max_person": maxPerson,
        "meal_option": mealOption,
        "room_size": roomSize,
        "quantity": quantity,
        "price": price,
        "offer_price": offerPrice,
        "room_images": images,
        "description": description,
        "amenities": amenities,
      };
}

class NearByAttraction {
  String? name;
  String? distance;
  String? description;

  NearByAttraction({this.name, this.distance, this.description});

  factory NearByAttraction.fromJson(Map<String, dynamic> json) =>
      NearByAttraction(
        name: json["name"],
        distance: json["distance"]?.toString(),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "distance": distance,
        "description": description,
      };
}
