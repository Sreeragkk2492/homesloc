class SearchHotelModel {
  String? message;
  List<Hotel>? hotels;
  Pagination? pagination;

  SearchHotelModel({
    this.message,
    this.hotels,
    this.pagination,
  });

  factory SearchHotelModel.fromJson(Map<String, dynamic> json) => SearchHotelModel(
    message: json["message"],
    hotels: json["hotels"] == null ? [] : List<Hotel>.from(json["hotels"]!.map((x) => Hotel.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "hotels": hotels == null ? [] : List<dynamic>.from(hotels!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Hotel {
  String? id;
  String? name;
  String? coverImageUrl;
  int? starRating;
  bool? isActive;
  bool? isFullProperty;
  LocationInfo? locationInfo;
  Policies? policies;
  LegalPolicies? legalPolicies;
  List<HotelRoom>? rooms;
  FullProperty? fullProperty;
  PriceRange? priceRange;
  QuickInfo? quickInfo;

  Hotel({
    this.id,
    this.name,
    this.coverImageUrl,
    this.starRating,
    this.isActive,
    this.isFullProperty,
    this.locationInfo,
    this.policies,
    this.legalPolicies,
    this.rooms,
    this.fullProperty,
    this.priceRange,
    this.quickInfo,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
    id: json["id"],
    name: json["name"],
    coverImageUrl: json["cover_image_url"],
    starRating: (json["star_rating"] as num?)?.toInt(), // Ensure star_rating is parsed as int
    isActive: json["is_active"],
    isFullProperty: json["is_full_property"],
    locationInfo: json["locationInfo"] == null ? null : LocationInfo.fromJson(json["locationInfo"]),
    policies: json["policies"] == null ? null : Policies.fromJson(json["policies"]),
    legalPolicies: json["legal_policies"] == null ? null : LegalPolicies.fromJson(json["legal_policies"]),
    rooms: json["rooms"] == null ? [] : List<HotelRoom>.from(json["rooms"]!.map((x) => HotelRoom.fromJson(x))),
    fullProperty: json["full_property"] == null ? null : FullProperty.fromJson(json["full_property"]),
    priceRange: json["price_range"] == null ? null : PriceRange.fromJson(json["price_range"]),
    quickInfo: json["quick_info"] == null ? null : QuickInfo.fromJson(json["quick_info"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cover_image_url": coverImageUrl,
    "star_rating": starRating,
    "is_active": isActive,
    "is_full_property": isFullProperty,
    "locationInfo": locationInfo?.toJson(),
    "policies": policies?.toJson(),
    "legal_policies": legalPolicies?.toJson(),
    "rooms": rooms == null ? [] : List<dynamic>.from(rooms!.map((x) => x.toJson())),
    "full_property": fullProperty?.toJson(),
    "price_range": priceRange?.toJson(),
    "quick_info": quickInfo?.toJson(),
  };
}

class FullProperty {
  String? id;
  String? basePropertyPrice;
  String? maxPropertyPrice;
  dynamic offerPrice;
  bool? smokingAllowed;
  int? maxPerson;
  String? mealOption;
  List<FullPropertyRoom>? rooms;

  FullProperty({
    this.id,
    this.basePropertyPrice,
    this.maxPropertyPrice,
    this.offerPrice,
    this.smokingAllowed,
    this.maxPerson,
    this.mealOption,
    this.rooms,
  });

  factory FullProperty.fromJson(Map<String, dynamic> json) => FullProperty(
    id: json["id"],
    basePropertyPrice: json["base_property_price"],
    maxPropertyPrice: json["max_property_price"],
    offerPrice: json["offer_price"],
    smokingAllowed: json["smoking_allowed"],
    maxPerson: (json["max_person"] as num?)?.toInt(), // Ensure max_person is parsed as int
    mealOption: json["meal_option"],
    rooms: json["rooms"] == null ? [] : List<FullPropertyRoom>.from(json["rooms"]!.map((x) => FullPropertyRoom.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "base_property_price": basePropertyPrice,
    "max_property_price": maxPropertyPrice,
    "offer_price": offerPrice,
    "smoking_allowed": smokingAllowed,
    "max_person": maxPerson,
    "meal_option": mealOption,
    "rooms": rooms == null ? [] : List<dynamic>.from(rooms!.map((x) => x.toJson())),
  };
}

class FullPropertyRoom {
  dynamic totalPropertyRooms;
  String? roomName;
  dynamic quantity;
  String? roomType;
  String? bedType;
  int? roomSize;
  String? description;
  List<String>? roomImages;
  List<dynamic>? roomVideos;

  FullPropertyRoom({
    this.totalPropertyRooms,
    this.roomName,
    this.quantity,
    this.roomType,
    this.bedType,
    this.roomSize,
    this.description,
    this.roomImages,
    this.roomVideos,
  });

  factory FullPropertyRoom.fromJson(Map<String, dynamic> json) => FullPropertyRoom(
    totalPropertyRooms: json["total_property_rooms"],
    roomName: json["room_name"],
    quantity: json["quantity"],
    roomType: json["room_type"],
    bedType: json["bed_type"],
    roomSize: (json["room_size"] as num?)?.toInt(), // Ensure room_size is parsed as int
    description: json["description"],
    roomImages: json["room_images"] == null ? [] : List<String>.from(json["room_images"]!.map((x) => x)),
    roomVideos: json["room_videos"] == null ? [] : List<dynamic>.from(json["room_videos"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "total_property_rooms": totalPropertyRooms,
    "room_name": roomName,
    "quantity": quantity,
    "room_type": roomType,
    "bed_type": bedType,
    "room_size": roomSize,
    "description": description,
    "room_images": roomImages == null ? [] : List<dynamic>.from(roomImages!.map((x) => x)),
    "room_videos": roomVideos == null ? [] : List<dynamic>.from(roomVideos!.map((x) => x)),
  };
}

class LegalPolicies {
  String? ownershipType;
  String? panCardDetails;
  String? gstDetails;
  BankAccountDetails? bankAccountDetails;
  String? propertyRestrictions;
  List<String>? registrationDocument;
  List<String>? documentImageUrl;
  List<String>? videos;

  LegalPolicies({
    this.ownershipType,
    this.panCardDetails,
    this.gstDetails,
    this.bankAccountDetails,
    this.propertyRestrictions,
    this.registrationDocument,
    this.documentImageUrl,
    this.videos,
  });

  factory LegalPolicies.fromJson(Map<String, dynamic> json) => LegalPolicies(
    ownershipType: json["ownershipType"],
    panCardDetails: json["panCardDetails"],
    gstDetails: json["gstDetails"],
    bankAccountDetails: json["bankAccountDetails"] == null ? null : BankAccountDetails.fromJson(json["bankAccountDetails"]),
    propertyRestrictions: json["propertyRestrictions"],
    registrationDocument: json["registrationDocument"] == null ? [] : List<String>.from(json["registrationDocument"]!.map((x) => x)),
    documentImageUrl: json["document_image_url"] == null ? [] : List<String>.from(json["document_image_url"]!.map((x) => x)),
    videos: json["videos"] == null ? [] : List<String>.from(json["videos"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "ownershipType": ownershipType,
    "panCardDetails": panCardDetails,
    "gstDetails": gstDetails,
    "bankAccountDetails": bankAccountDetails?.toJson(),
    "propertyRestrictions": propertyRestrictions,
    "registrationDocument": registrationDocument == null ? [] : List<dynamic>.from(registrationDocument!.map((x) => x)),
    "document_image_url": documentImageUrl == null ? [] : List<dynamic>.from(documentImageUrl!.map((x) => x)),
    "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x)),
  };
}

class BankAccountDetails {
  String? accountNumber;
  String? ifscCode;
  String? bankName;
  String? accountHolderName;

  BankAccountDetails({
    this.accountNumber,
    this.ifscCode,
    this.bankName,
    this.accountHolderName,
  });

  factory BankAccountDetails.fromJson(Map<String, dynamic> json) => BankAccountDetails(
    accountNumber: json["account_number"],
    ifscCode: json["ifsc_code"],
    bankName: json["bank_name"],
    accountHolderName: json["account_holder_name"],
  );

  Map<String, dynamic> toJson() => {
    "account_number": accountNumber,
    "ifsc_code": ifscCode,
    "bank_name": bankName,
    "account_holder_name": accountHolderName,
  };
}

class LocationInfo {
  Country? country;
  String? latitude;
  String? longitude;
  State? state;
  String? city;
  String? postcode;
  String? address;
  bool? termsandcondition;

  LocationInfo({
    this.country,
    this.latitude,
    this.longitude,
    this.state,
    this.city,
    this.postcode,
    this.address,
    this.termsandcondition,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) => LocationInfo(
    country: countryValues.map[json["country"]]!,
    latitude: json["latitude"],
    longitude: json["longitude"],
    state: stateValues.map[json["state"]]!,
    city: json["city"],
    postcode: json["postcode"],
    address: json["address"],
    termsandcondition: json["termsandcondition"],
  );

  Map<String, dynamic> toJson() => {
    "country": countryValues.reverse[country],
    "latitude": latitude,
    "longitude": longitude,
    "state": stateValues.reverse[state],
    "city": city,
    "postcode": postcode,
    "address": address,
    "termsandcondition": termsandcondition,
  };
}

enum Country {
  INDIA
}

final countryValues = EnumValues({
  "India": Country.INDIA
});

enum State {
  KARNATAKA,
  KERALA,
  MAHARASHTRA
}

final stateValues = EnumValues({
  "Karnataka": State.KARNATAKA,
  "Kerala": State.KERALA,
  "Maharashtra": State.MAHARASHTRA
});

class Policies {
  String? checkInTime;
  String? checkOutTime;
  List<String>? acceptableIdentityProof;
  String? cancellationPolicy;
  bool? outsideVisitorAllowed;
  bool? partiesOrEventsAllowed;
  bool? extraBedPolicy;
  int? extraBedRate;
  MealRates? mealRates;

  Policies({
    this.checkInTime,
    this.checkOutTime,
    this.acceptableIdentityProof,
    this.cancellationPolicy,
    this.outsideVisitorAllowed,
    this.partiesOrEventsAllowed,
    this.extraBedPolicy,
    this.extraBedRate,
    this.mealRates,
  });

  factory Policies.fromJson(Map<String, dynamic> json) => Policies(
    checkInTime: json["checkInTime"],
    checkOutTime: json["checkOutTime"],
    acceptableIdentityProof: json["acceptableIdentityProof"] == null ? [] : List<String>.from(json["acceptableIdentityProof"]!.map((x) => x)),
    cancellationPolicy: json["cancellationPolicy"],
    outsideVisitorAllowed: json["outsideVisitorAllowed"],
    partiesOrEventsAllowed: json["partiesOrEventsAllowed"],
    extraBedPolicy: json["extraBedPolicy"],
    extraBedRate: (json["extraBedRate"] as num?)?.toInt(), // Ensure extraBedRate is parsed as int
    mealRates: json["mealRates"] == null ? null : MealRates.fromJson(json["mealRates"]),
  );

  Map<String, dynamic> toJson() => {
    "checkInTime": checkInTime,
    "checkOutTime": checkOutTime,
    "acceptableIdentityProof": acceptableIdentityProof == null ? [] : List<dynamic>.from(acceptableIdentityProof!.map((x) => x)),
    "cancellationPolicy": cancellationPolicy,
    "outsideVisitorAllowed": outsideVisitorAllowed,
    "partiesOrEventsAllowed": partiesOrEventsAllowed,
    "extraBedPolicy": extraBedPolicy,
    "extraBedRate": extraBedRate,
    "mealRates": mealRates?.toJson(),
  };
}

class MealRates {
  String? breakfast;
  String? lunch;
  String? dinner;

  MealRates({
    this.breakfast,
    this.lunch,
    this.dinner,
  });

  factory MealRates.fromJson(Map<String, dynamic> json) => MealRates(
    breakfast: json["breakfast"],
    lunch: json["lunch"],
    dinner: json["dinner"],
  );

  Map<String, dynamic> toJson() => {
    "breakfast": breakfast,
    "lunch": lunch,
    "dinner": dinner,
  };
}

class PriceRange {
  String? min;
  String? max;

  PriceRange({
    this.min,
    this.max,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
    min: json["min"],
    max: json["max"],
  );

  Map<String, dynamic> toJson() => {
    "min": min,
    "max": max,
  };
}

class QuickInfo {
  int? totalRooms;
  List<Amenity>? amenities;

  QuickInfo({
    this.totalRooms,
    this.amenities,
  });

  factory QuickInfo.fromJson(Map<String, dynamic> json) => QuickInfo(
    totalRooms: (json["total_rooms"] as num?)?.toInt(), // Ensure total_rooms is parsed as int
    amenities: json["amenities"] == null ? [] : List<Amenity>.from(json["amenities"]!.map((x) => Amenity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_rooms": totalRooms,
    "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
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

class HotelRoom {
  String? id;
  String? roomName;
  int? quantity;
  String? roomType;
  String? bedType;
  int? maxPerson;
  String? price;
  int? roomSize;
  String? description;
  List<String>? roomImages;
  List<String>? roomVideos;

  HotelRoom({
    this.id,
    this.roomName,
    this.quantity,
    this.roomType,
    this.bedType,
    this.maxPerson,
    this.price,
    this.roomSize,
    this.description,
    this.roomImages,
    this.roomVideos,
  });

  factory HotelRoom.fromJson(Map<String, dynamic> json) => HotelRoom(
    id: json["id"],
    roomName: json["room_name"],
    quantity: (json["quantity"] as num?)?.toInt(), // Ensure quantity is parsed as int
    roomType: json["room_type"],
    bedType: json["bed_type"],
    maxPerson: (json["max_person"] as num?)?.toInt(), // Ensure max_person is parsed as int
    price: json["price"],
    roomSize: (json["room_size"] as num?)?.toInt(), // Ensure room_size is parsed as int
    description: json["description"],
    roomImages: json["room_images"] == null ? [] : List<String>.from(json["room_images"]!.map((x) => x)),
    roomVideos: json["room_videos"] == null ? [] : List<String>.from(json["room_videos"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "room_name": roomName,
    "quantity": quantity,
    "room_type": roomType,
    "bed_type": bedType,
    "max_person": maxPerson,
    "price": price,
    "room_size": roomSize,
    "description": description,
    "room_images": roomImages == null ? [] : List<dynamic>.from(roomImages!.map((x) => x)),
    "room_videos": roomVideos == null ? [] : List<dynamic>.from(roomVideos!.map((x) => x)),
  };
}

class Pagination {
  int? totalCount;
  int? currentPage;
  int? totalPages;
  bool? hasNext;
  bool? hasPrevious;

  Pagination({
    this.totalCount,
    this.currentPage,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalCount: (json["total_count"] as num?)?.toInt(), // Ensure total_count is parsed as int
    currentPage: (json["current_page"] as num?)?.toInt(), // Ensure current_page is parsed as int
    totalPages: (json["total_pages"] as num?)?.toInt(), // Ensure total_pages is parsed as int
    hasNext: json["has_next"],
    hasPrevious: json["has_previous"],
  );

  Map<String, dynamic> toJson() => {
    "total_count": totalCount,
    "current_page": currentPage,
    "total_pages": totalPages,
    "has_next": hasNext,
    "has_previous": hasPrevious,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
 