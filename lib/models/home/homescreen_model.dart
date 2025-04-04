class HomescreenModel {
  List<BestHotel>? bestHotels;
  List<dynamic>? tourPackages;
  List<dynamic>? weddingPackages;
  List<dynamic>? banquetHalls;
  List<dynamic>? popularDestinations;
  List<dynamic>? latestReviews;

  HomescreenModel({
    this.bestHotels,
    this.tourPackages,
    this.weddingPackages,
    this.banquetHalls,
    this.popularDestinations,
    this.latestReviews,
  });

  factory HomescreenModel.fromJson(Map<String, dynamic> json) => HomescreenModel(
    bestHotels: json["best_hotels"] == null 
        ? [] 
        : List<BestHotel>.from(json["best_hotels"].map((x) => BestHotel.fromJson(x))),
    tourPackages: json["tour_packages"] ?? [],
    weddingPackages: json["wedding_packages"] ?? [],
    banquetHalls: json["banquet_halls"] ?? [],
    popularDestinations: json["popular_destinations"] ?? [],
    latestReviews: json["latest_reviews"] ?? [],
  );

  Map<String, dynamic> toJson() => {
    "best_hotels": bestHotels == null 
        ? [] 
        : List<dynamic>.from(bestHotels!.map((x) => x.toJson())),
    "tour_packages": tourPackages,
    "wedding_packages": weddingPackages,
    "banquet_halls": banquetHalls,
    "popular_destinations": popularDestinations,
    "latest_reviews": latestReviews,
  };
}

class BestHotel {
  String? id;
  String? serviceProviderId;
  String? name;
  String? hotelType;
  int? starRating;
  int? totalRooms;
  List<RoomType>? roomTypes;
  String? chanelManagerName;
  String? description;
  String? email;
  String? phoneNumber;
  String? country;
  String? state;
  String? city;
  String? address;
  String? postcode;
  bool? termsandcondition;
  String? location;
  String? checkInTime;
  String? checkOutTime;
  bool? cancellation;
  String? startingRange;
  String? endingRange;
  String? latitude;
  String? longitude;
  List<NearByAttraction>? nearByAttraction;
  int? yearBuild;
  int? yearRenovated;
  List<Award>? awards;
  List<dynamic>? amenities;
  String? coverImageUrl;
  List<String>? galleryImages;
  List<String>? videos;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Room>? rooms;
  Pricing? pricing;
  dynamic rating;
  int? reviewCount;

  BestHotel({
    this.id,
    this.serviceProviderId,
    this.name,
    this.hotelType,
    this.starRating,
    this.totalRooms,
    this.roomTypes,
    this.chanelManagerName,
    this.description,
    this.email,
    this.phoneNumber,
    this.country,
    this.state,
    this.city,
    this.address,
    this.postcode,
    this.termsandcondition,
    this.location,
    this.checkInTime,
    this.checkOutTime,
    this.cancellation,
    this.startingRange,
    this.endingRange,
    this.latitude,
    this.longitude,
    this.nearByAttraction,
    this.yearBuild,
    this.yearRenovated,
    this.awards,
    this.amenities,
    this.coverImageUrl,
    this.galleryImages,
    this.videos,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.rooms,
    this.pricing,
    this.rating,
    this.reviewCount,
  });

  factory BestHotel.fromJson(Map<String, dynamic> json) => BestHotel(
    id: json["id"],
    serviceProviderId: json["service_provider_id"],
    name: json["name"],
    hotelType: json["hotel_type"],
    starRating: _safeParseInt(json["star_rating"]),
    totalRooms: _safeParseInt(json["total_rooms"]),
    roomTypes: json["room_types"] == null 
        ? [] 
        : List<RoomType>.from(json["room_types"].map((x) => RoomType.fromJson(x))),
    chanelManagerName: json["chanel_manager_name"],
    description: json["description"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    address: json["address"],
    postcode: json["postcode"],
    termsandcondition: json["termsandcondition"],
    location: json["location"],
    checkInTime: json["check_in_time"],
    checkOutTime: json["check_out_time"],
    cancellation: json["cancellation"],
    startingRange: json["starting_range"],
    endingRange: json["ending_range"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    nearByAttraction: json["near_by_attraction"] == null 
        ? [] 
        : List<NearByAttraction>.from(json["near_by_attraction"].map((x) => NearByAttraction.fromJson(x))),
    yearBuild: _safeParseInt(json["year_build"]),
    yearRenovated: _safeParseInt(json["year_renovated"]),
    awards: json["awards"] == null 
        ? [] 
        : List<Award>.from(json["awards"].map((x) => Award.fromJson(x))),
    amenities: json["amenities"] ?? [],
    coverImageUrl: json["cover_image_url"],
    galleryImages: json["gallery_images"] == null 
        ? [] 
        : List<String>.from(json["gallery_images"]),
    videos: json["videos"] == null 
        ? [] 
        : List<String>.from(json["videos"]),
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    rooms: json["rooms"] == null 
        ? [] 
        : List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
    pricing: json["pricing"] == null ? null : Pricing.fromJson(json["pricing"]),
    rating: json["rating"],
    reviewCount: _safeParseInt(json["review_count"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_provider_id": serviceProviderId,
    "name": name,
    "hotel_type": hotelType,
    "star_rating": starRating,
    "total_rooms": totalRooms,
    "room_types": roomTypes == null 
        ? [] 
        : List<dynamic>.from(roomTypes!.map((x) => x.toJson())),
    "chanel_manager_name": chanelManagerName,
    "description": description,
    "email": email,
    "phone_number": phoneNumber,
    "country": country,
    "state": state,
    "city": city,
    "address": address,
    "postcode": postcode,
    "termsandcondition": termsandcondition,
    "location": location,
    "check_in_time": checkInTime,
    "check_out_time": checkOutTime,
    "cancellation": cancellation,
    "starting_range": startingRange,
    "ending_range": endingRange,
    "latitude": latitude,
    "longitude": longitude,
    "near_by_attraction": nearByAttraction == null 
        ? [] 
        : List<dynamic>.from(nearByAttraction!.map((x) => x.toJson())),
    "year_build": yearBuild,
    "year_renovated": yearRenovated,
    "awards": awards == null 
        ? [] 
        : List<dynamic>.from(awards!.map((x) => x.toJson())),
    "amenities": amenities,
    "cover_image_url": coverImageUrl,
    "gallery_images": galleryImages,
    "videos": videos,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "rooms": rooms == null 
        ? [] 
        : List<dynamic>.from(rooms!.map((x) => x.toJson())),
    "pricing": pricing?.toJson(),
    "rating": rating,
    "review_count": reviewCount,
  };

  // Helper method to safely parse integers
  static int? _safeParseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class RoomType {
  String? type;
  dynamic description;
  int? capacity;

  RoomType({
    this.type,
    this.description,
    this.capacity,
  });

  factory RoomType.fromJson(Map<String, dynamic> json) => RoomType(
    type: json["type"],
    description: json["description"],
    capacity: int.tryParse(json["capacity"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "description": description,
    "capacity": capacity,
  };
}

class NearByAttraction {
  String? name;
  String? distance;
  String? description;

  NearByAttraction({
    this.name,
    this.distance,
    this.description,
  });

  factory NearByAttraction.fromJson(Map<String, dynamic> json) => NearByAttraction(
    name: json["name"],
    distance: json["distance"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "distance": distance,
    "description": description,
  };
}

class Award {
  String? title;
  int? year;
  String? description;

  Award({
    this.title,
    this.year,
    this.description,
  });

  factory Award.fromJson(Map<String, dynamic> json) => Award(
    title: json["title"],
    year: int.tryParse(json["year"].toString()),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "year": year,
    "description": description,
  };
}

class Room {
  String? id;
  String? hotelId;
  String? roomName;
  String? roomType;
  String? bedType;
  int? maxPerson;
  String? mealOption;
  int? roomSize;
  int? quantity;
  String? price;
  dynamic offerPrice;
  String? availabilityStatus;
  String? description;
  List<String>? roomImages;
  dynamic floorPlanImageUrl;
  List<Amenity>? amenities;
  dynamic roomVideos;
  bool? smokingAllowed;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  Room({
    this.id,
    this.hotelId,
    this.roomName,
    this.roomType,
    this.bedType,
    this.maxPerson,
    this.mealOption,
    this.roomSize,
    this.quantity,
    this.price,
    this.offerPrice,
    this.availabilityStatus,
    this.description,
    this.roomImages,
    this.floorPlanImageUrl,
    this.amenities,
    this.roomVideos,
    this.smokingAllowed,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json["id"],
    hotelId: json["hotel_id"],
    roomName: json["room_name"],
    roomType: json["room_type"],
    bedType: json["bed_type"],
    maxPerson: int.tryParse(json["max_person"].toString()),
    mealOption: json["meal_option"],
    roomSize: int.tryParse(json["room_size"].toString()),
    quantity: int.tryParse(json["quantity"].toString()),
    price: json["price"],
    offerPrice: json["offer_price"],
    availabilityStatus: json["availability_status"],
    description: json["description"],
    roomImages: json["room_images"] == null 
        ? [] 
        : List<String>.from(json["room_images"]),
    floorPlanImageUrl: json["floor_plan_image_url"],
    amenities: json["amenities"] == null 
        ? [] 
        : List<Amenity>.from(json["amenities"].map((x) => Amenity.fromJson(x))),
    roomVideos: json["room_videos"],
    smokingAllowed: json["smoking_allowed"],
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hotel_id": hotelId,
    "room_name": roomName,
    "room_type": roomType,
    "bed_type": bedType,
    "max_person": maxPerson,
    "meal_option": mealOption,
    "room_size": roomSize,
    "quantity": quantity,
    "price": price,
    "offer_price": offerPrice,
    "availability_status": availabilityStatus,
    "description": description,
    "room_images": roomImages,
    "floor_plan_image_url": floorPlanImageUrl,
    "amenities": amenities == null 
        ? [] 
        : List<dynamic>.from(amenities!.map((x) => x.toJson())),
    "room_videos": roomVideos,
    "smoking_allowed": smokingAllowed,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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

class Pricing {
  String? bestPrice;
  dynamic offerPrice;
  int? availableRooms;

  Pricing({
    this.bestPrice,
    this.offerPrice,
    this.availableRooms,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
    bestPrice: json["best_price"],
    offerPrice: json["offer_price"],
    availableRooms: int.tryParse(json["available_rooms"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "best_price": bestPrice,
    "offer_price": offerPrice,
    "available_rooms": availableRooms,
  };
}