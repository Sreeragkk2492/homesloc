// To parse this JSON data, do
//
//     final searchFreshUpModel = searchFreshUpModelFromJson(jsonString);

import 'dart:convert';

SearchFreshUpModel searchFreshUpModelFromJson(String str) => SearchFreshUpModel.fromJson(json.decode(str));

String searchFreshUpModelToJson(SearchFreshUpModel data) => json.encode(data.toJson());

class SearchFreshUpModel {
    List<Accommodation>? accommodations;
    int? totalCount;
    int? currentPage;
    int? totalPages;
    bool? hasNext;
    bool? hasPrevious;
    String? message;

    SearchFreshUpModel({
        this.accommodations,
        this.totalCount,
        this.currentPage,
        this.totalPages,
        this.hasNext,
        this.hasPrevious,
        this.message,
    });

    factory SearchFreshUpModel.fromJson(Map<String, dynamic> json) => SearchFreshUpModel(
        accommodations: json["accommodations"] == null ? [] : List<Accommodation>.from(json["accommodations"]!.map((x) => Accommodation.fromJson(x))),
        totalCount: json["total_count"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        hasNext: json["has_next"],
        hasPrevious: json["has_previous"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "accommodations": accommodations == null ? [] : List<dynamic>.from(accommodations!.map((x) => x.toJson())),
        "total_count": totalCount,
        "current_page": currentPage,
        "total_pages": totalPages,
        "has_next": hasNext,
        "has_previous": hasPrevious,
        "message": message,
    };
}

class Accommodation {
    String? id;
    String? priceMethod;
    String? freshupId;
    bool? isActive;
    String? freshupName;
    String? freshupType;
    int? totalNumber;
    int? maxPerson;
    int? minPersons;
    String? price;
    String? offerPrice;
    String? roomSize;
    String? freshupDescription;
    bool? smokingAllowed;
    bool? bathroomAttached;
    List<String>? roomImages;
    List<dynamic>? roomVideos;
    List<Amenity>? amenities;
    String? name;
    int? starRating;
    String? coverImageUrl;
    List<String>? galleryImages;
    String? city;
    String? state;
    String? latitude;
    String? longitude;
    List<NearByAttraction>? nearByAttraction;
    List<Slot>? slots;
    bool? allSlotsBooked;
    String? bedType;
    int? availableRooms;

    Accommodation({
        this.id,
        this.priceMethod,
        this.freshupId,
        this.isActive,
        this.freshupName,
        this.freshupType,
        this.totalNumber,
        this.maxPerson,
        this.minPersons,
        this.price,
        this.offerPrice,
        this.roomSize,
        this.freshupDescription,
        this.smokingAllowed,
        this.bathroomAttached,
        this.roomImages,
        this.roomVideos,
        this.amenities,
        this.name,
        this.starRating,
        this.coverImageUrl,
        this.galleryImages,
        this.city,
        this.state,
        this.latitude,
        this.longitude,
        this.nearByAttraction,
        this.slots,
        this.allSlotsBooked,
        this.bedType,
        this.availableRooms,
    });

    factory Accommodation.fromJson(Map<String, dynamic> json) => Accommodation(
        id: json["id"],
        priceMethod: json["price_method"],
        freshupId: json["freshup_id"],
        isActive: json["is_active"],
        freshupName: json["freshup_name"],
        freshupType: json["freshup_type"],
        totalNumber: json["total_number"],
        maxPerson: json["max_person"],
        minPersons: json["min_persons"],
        price: json["price"],
        offerPrice: json["offer_price"],
        roomSize: json["room_size"],
        freshupDescription: json["freshup_description"],
        smokingAllowed: json["smoking_allowed"],
        bathroomAttached: json["bathroom_attached"],
        roomImages: json["room_images"] == null ? [] : List<String>.from(json["room_images"]!.map((x) => x)),
        roomVideos: json["room_videos"] == null ? [] : List<dynamic>.from(json["room_videos"]!.map((x) => x)),
        amenities: json["amenities"] == null ? [] : List<Amenity>.from(json["amenities"]!.map((x) => Amenity.fromJson(x))),
        name: json["name"],
        starRating: json["star_rating"],
        coverImageUrl: json["cover_image_url"],
        galleryImages: json["gallery_images"] == null ? [] : List<String>.from(json["gallery_images"]!.map((x) => x)),
        city: json["city"],
        state: json["state"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        nearByAttraction: json["near_by_attraction"] == null ? [] : List<NearByAttraction>.from(json["near_by_attraction"]!.map((x) => NearByAttraction.fromJson(x))),
        slots: json["slots"] == null ? [] : List<Slot>.from(json["slots"]!.map((x) => Slot.fromJson(x))),
        allSlotsBooked: json["all_slots_booked"],
        bedType: json["bed_type"],
        availableRooms: json["available_rooms"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "price_method": priceMethod,
        "freshup_id": freshupId,
        "is_active": isActive,
        "freshup_name": freshupName,
        "freshup_type": freshupType,
        "total_number": totalNumber,
        "max_person": maxPerson,
        "min_persons": minPersons,
        "price": price,
        "offer_price": offerPrice,
        "room_size": roomSize,
        "freshup_description": freshupDescription,
        "smoking_allowed": smokingAllowed,
        "bathroom_attached": bathroomAttached,
        "room_images": roomImages == null ? [] : List<dynamic>.from(roomImages!.map((x) => x)),
        "room_videos": roomVideos == null ? [] : List<dynamic>.from(roomVideos!.map((x) => x)),
        "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "name": name,
        "star_rating": starRating,
        "cover_image_url": coverImageUrl,
        "gallery_images": galleryImages == null ? [] : List<dynamic>.from(galleryImages!.map((x) => x)),
        "city": city,
        "state": state,
        "latitude": latitude,
        "longitude": longitude,
        "near_by_attraction": nearByAttraction == null ? [] : List<dynamic>.from(nearByAttraction!.map((x) => x.toJson())),
        "slots": slots == null ? [] : List<dynamic>.from(slots!.map((x) => x.toJson())),
        "all_slots_booked": allSlotsBooked,
        "bed_type": bedType,
        "available_rooms": availableRooms,
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

class Slot {
    String? id;
    String? checkIn;
    String? checkOut;

    Slot({
        this.id,
        this.checkIn,
        this.checkOut,
    });

    factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        id: json["id"],
        checkIn: json["check_in"],
        checkOut: json["check_out"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "check_in": checkIn,
        "check_out": checkOut,
    };
}
