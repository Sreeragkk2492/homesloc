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
        hotels: json["hotels"] == null ? [] : List<Hotel>.from(json["hotels"].map((x) => Hotel.fromJson(x))),
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
    List<Room>? rooms;
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
        starRating: json["star_rating"],
        isActive: json["is_active"],
        isFullProperty: json["is_full_property"],
        locationInfo: json["locationInfo"] == null ? null : LocationInfo.fromJson(json["locationInfo"]),
        policies: json["policies"] == null ? null : Policies.fromJson(json["policies"]),
        legalPolicies: json["legal_policies"] == null ? null : LegalPolicies.fromJson(json["legal_policies"]),
        rooms: json["rooms"] == null ? [] : List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
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
    String? offerPrice;
    bool? smokingAllowed;
    int? maxPerson;
    String? mealOption;
    List<dynamic>? rooms;

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
        maxPerson: json["max_person"],
        mealOption: json["meal_option"],
        rooms: json["rooms"] == null ? [] : List<dynamic>.from(json["rooms"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "base_property_price": basePropertyPrice,
        "max_property_price": maxPropertyPrice,
        "offer_price": offerPrice,
        "smoking_allowed": smokingAllowed,
        "max_person": maxPerson,
        "meal_option": mealOption,
        "rooms": rooms == null ? [] : List<dynamic>.from(rooms!.map((x) => x)),
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
        registrationDocument: json["registrationDocument"] == null ? [] : List<String>.from(json["registrationDocument"].map((x) => x)),
        documentImageUrl: json["document_image_url"] == null ? [] : List<String>.from(json["document_image_url"].map((x) => x)),
        videos: json["videos"] == null ? [] : List<String>.from(json["videos"].map((x) => x)),
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
    String? country;
    String? latitude;
    String? longitude;
    String? state;
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
        country: json["country"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        state: json["state"],
        city: json["city"],
        postcode: json["postcode"],
        address: json["address"],
        termsandcondition: json["termsandcondition"],
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "state": state,
        "city": city,
        "postcode": postcode,
        "address": address,
        "termsandcondition": termsandcondition,
    };
}

class Policies {
    String? checkInTime;
    String? checkOutTime;
    List<dynamic>? acceptableIdentityProof;
    String? cancellationPolicy;
    int? cancellationDays;
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
        this.cancellationDays,
        this.outsideVisitorAllowed,
        this.partiesOrEventsAllowed,
        this.extraBedPolicy,
        this.extraBedRate,
        this.mealRates,
    });

    factory Policies.fromJson(Map<String, dynamic> json) => Policies(
        checkInTime: json["checkInTime"],
        checkOutTime: json["checkOutTime"],
        acceptableIdentityProof: json["acceptableIdentityProof"] == null ? [] : List<dynamic>.from(json["acceptableIdentityProof"].map((x) => x)),
        cancellationPolicy: json["cancellationPolicy"],
        cancellationDays: json["cancellationDays"],
        outsideVisitorAllowed: json["outsideVisitorAllowed"],
        partiesOrEventsAllowed: json["partiesOrEventsAllowed"],
        extraBedPolicy: json["extraBedPolicy"],
        extraBedRate: json["extraBedRate"],
        mealRates: json["mealRates"] == null ? null : MealRates.fromJson(json["mealRates"]),
    );

    Map<String, dynamic> toJson() => {
        "checkInTime": checkInTime,
        "checkOutTime": checkOutTime,
        "acceptableIdentityProof": acceptableIdentityProof == null ? [] : List<dynamic>.from(acceptableIdentityProof!.map((x) => x)),
        "cancellationPolicy": cancellationPolicy,
        "cancellationDays": cancellationDays,
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
        totalRooms: json["total_rooms"],
        amenities: json["amenities"] == null ? [] : List<Amenity>.from(json["amenities"].map((x) => Amenity.fromJson(x))),
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

class Room {
    String? id;
    String? roomName;
    int? quantity;
    String? roomType;
    String? bedType;
    int? maxPerson;
    String? price;
    int? roomSize;
    String? description;
    List<dynamic>? roomImages;
    List<dynamic>? roomVideos;

    Room({
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

    factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        roomName: json["room_name"],
        quantity: json["quantity"],
        roomType: json["room_type"],
        bedType: json["bed_type"],
        maxPerson: json["max_person"],
        price: json["price"],
        roomSize: json["room_size"],
        description: json["description"],
        roomImages: json["room_images"] == null ? [] : List<dynamic>.from(json["room_images"].map((x) => x)),
        roomVideos: json["room_videos"] == null ? [] : List<dynamic>.from(json["room_videos"].map((x) => x)),
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
        totalCount: json["total_count"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
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