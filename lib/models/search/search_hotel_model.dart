
import 'dart:convert';

SearchHotelModel searchHotelModelFromJson(String str) => SearchHotelModel.fromJson(json.decode(str));

String searchHotelModelToJson(SearchHotelModel data) => json.encode(data.toJson());

class SearchHotelModel {
    List<Accommodation> accommodations;
    int totalCount;
    int currentPage;
    int totalPages;
    bool hasNext;
    bool hasPrevious;
    String message;

    SearchHotelModel({
        required this.accommodations,
        required this.totalCount,
        required this.currentPage,
        required this.totalPages,
        required this.hasNext,
        required this.hasPrevious,
        required this.message,
    });

    factory SearchHotelModel.fromJson(Map<String, dynamic> json) => SearchHotelModel(
        accommodations: List<Accommodation>.from(json["accommodations"].map((x) => Accommodation.fromJson(x))),
        totalCount: json["total_count"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        hasNext: json["has_next"],
        hasPrevious: json["has_previous"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "accommodations": List<dynamic>.from(accommodations.map((x) => x.toJson())),
        "total_count": totalCount,
        "current_page": currentPage,
        "total_pages": totalPages,
        "has_next": hasNext,
        "has_previous": hasPrevious,
        "message": message,
    };
}

class Accommodation {
    String id;
    String accommodationType;
    String hotelId;
    bool isActive;
    String? roomName;
    String? roomType;
    String? bedType;
    int? quantity;
    int? maxPerson; // Made nullable since API can return null
    String? price;
    String? offerPrice; // Made nullable since API can return null
    String? availabilityStatus;
    String? description;
    List<String>? roomImages;
    String? floorPlanImageUrl;
    String name;
    String hotelType;
    String city;
    String? state; // Made nullable since API can return null
    int? hotelStarRating; // Made nullable since API can return null
    String? checkInTime;
    String? checkOutTime;
    String coverImageUrl;
    List<String>? galleryImages; // Made nullable since API might return null
    String latitude;
    String longitude;
    List<NearByAttraction>? nearByAttraction; // Made nullable since API might return null
    List<Amenity>? amenities; // Made nullable since API might return null
    String? basePropertyPrice;
    String? maxPropertyPrice; // Made nullable since API can return null
    bool? smokingAllowed;
    String? mealOption;
    List<Room>? rooms;
    bool isFullProperty;

    Accommodation({
        required this.id,
        required this.accommodationType,
        required this.hotelId,
        required this.isActive,
        this.roomName,
        this.roomType,
        this.bedType,
        this.quantity,
        this.maxPerson, // Made optional
        this.price,
        this.offerPrice, // Made optional
        this.availabilityStatus,
        this.description,
        this.roomImages,
        this.floorPlanImageUrl,
        required this.name,
        required this.hotelType,
        required this.city,
        this.state, // Made optional
        this.hotelStarRating, // Made optional
        this.checkInTime,
        this.checkOutTime,
        required this.coverImageUrl,
        this.galleryImages, // Made optional
        required this.latitude,
        required this.longitude,
        this.nearByAttraction, // Made optional
        this.amenities, // Made optional
        this.basePropertyPrice,
        this.maxPropertyPrice, // Made optional
        this.smokingAllowed,
        this.mealOption,
        this.rooms,
        this.isFullProperty = true, // Default to true since all data is now full property
    });

    factory Accommodation.fromJson(Map<String, dynamic> json) => Accommodation(
        id: json["id"],
        accommodationType: json["accommodation_type"],
        hotelId: json["hotel_id"],
        isActive: json["is_active"],
        roomName: json["room_name"],
        roomType: json["room_type"],
        bedType: json["bed_type"],
        quantity: json["quantity"] != null ? (json["quantity"] is int ? json["quantity"] : (json["quantity"] as num).toInt()) : null,
        maxPerson: json["max_person"] != null ? (json["max_person"] is int ? json["max_person"] : (json["max_person"] as num).toInt()) : null,
        price: json["price"],
        offerPrice: json["offer_price"], // Can be null
        availabilityStatus: json["availability_status"],
        description: json["description"],
        roomImages: json["room_images"] == null ? [] : List<String>.from(json["room_images"]!.map((x) => x)),
        floorPlanImageUrl: json["floor_plan_image_url"],
        name: json["name"],
        hotelType: json["hotel_type"],
        city: json["city"],
        state: json["state"], // Can be null
        hotelStarRating: json["hotel_star_rating"] != null ? (json["hotel_star_rating"] is int ? json["hotel_star_rating"] : (json["hotel_star_rating"] as num).toInt()) : null,
        checkInTime: json["check_in_time"],
        checkOutTime: json["check_out_time"],
        coverImageUrl: json["cover_image_url"],
        galleryImages: json["gallery_images"] == null ? [] : List<String>.from(json["gallery_images"]!.map((x) => x)),
        latitude: json["latitude"],
        longitude: json["longitude"],
        nearByAttraction: json["near_by_attraction"] == null ? [] : List<NearByAttraction>.from(json["near_by_attraction"]!.map((x) => NearByAttraction.fromJson(x))),
        amenities: json["amenities"] == null ? [] : List<Amenity>.from(json["amenities"]!.map((x) => Amenity.fromJson(x))),
        basePropertyPrice: json["base_property_price"],
        maxPropertyPrice: json["max_property_price"], // Can be null
        smokingAllowed: json["smoking_allowed"],
        mealOption: json["meal_option"],
        rooms: json["rooms"] == null ? [] : List<Room>.from(json["rooms"]!.map((x) => Room.fromJson(x))),
        isFullProperty: json["is_full_property"] ?? true, // Default to true if not provided
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "accommodation_type": accommodationType,
        "hotel_id": hotelId,
        "is_active": isActive,
        "room_name": roomName,
        "room_type": roomType,
        "bed_type": bedType,
        "quantity": quantity,
        "max_person": maxPerson,
        "price": price,
        "offer_price": offerPrice,
        "availability_status": availabilityStatus,
        "description": description,
        "room_images": roomImages == null ? [] : List<dynamic>.from(roomImages!.map((x) => x)),
        "floor_plan_image_url": floorPlanImageUrl,
        "name": name,
        "hotel_type": hotelType,
        "city": city,
        "state": state,
        "hotel_star_rating": hotelStarRating,
        "check_in_time": checkInTime,
        "check_out_time": checkOutTime,
        "cover_image_url": coverImageUrl,
        "gallery_images": galleryImages == null ? [] : List<dynamic>.from(galleryImages!.map((x) => x)),
        "latitude": latitude,
        "longitude": longitude,
        "near_by_attraction": nearByAttraction == null ? [] : List<dynamic>.from(nearByAttraction!.map((x) => x.toJson())),
        "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "base_property_price": basePropertyPrice,
        "max_property_price": maxPropertyPrice,
        "smoking_allowed": smokingAllowed,
        "meal_option": mealOption,
        "rooms": rooms == null ? [] : List<dynamic>.from(rooms!.map((x) => x.toJson())),
        "is_full_property": isFullProperty,
    };
}

class Amenity {
    String id;
    String name;
    String description;

    Amenity({
        required this.id,
        required this.name,
        required this.description,
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
    String name;
    String distance;
    String description;

    NearByAttraction({
        required this.name,
        required this.distance,
        required this.description,
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

class Room {
    int? totalPropertyRooms; // Made nullable since API can return null
    String roomName;
    int? quantity; // Made nullable since API can return null
    String roomType;
    String bedType;
    int roomSize;
    String description;
    List<String> roomImages;
    List<String> roomVideos;

    Room({
        this.totalPropertyRooms, // Made optional
        required this.roomName,
        this.quantity, // Made optional
        required this.roomType,
        required this.bedType,
        required this.roomSize,
        required this.description,
        required this.roomImages,
        required this.roomVideos,
    });

    factory Room.fromJson(Map<String, dynamic> json) => Room(
        totalPropertyRooms: json["total_property_rooms"] != null ? (json["total_property_rooms"] is int ? json["total_property_rooms"] : (json["total_property_rooms"] as num).toInt()) : null,
        roomName: json["room_name"],
        quantity: json["quantity"] != null ? (json["quantity"] is int ? json["quantity"] : (json["quantity"] as num).toInt()) : null,
        roomType: json["room_type"],
        bedType: json["bed_type"],
        roomSize: json["room_size"] is int ? json["room_size"] : (json["room_size"] as num).toInt(),
        description: json["description"],
        roomImages: List<String>.from(json["room_images"].map((x) => x)),
        roomVideos: List<String>.from(json["room_videos"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "total_property_rooms": totalPropertyRooms,
        "room_name": roomName,
        "quantity": quantity,
        "room_type": roomType,
        "bed_type": bedType,
        "room_size": roomSize,
        "description": description,
        "room_images": List<dynamic>.from(roomImages.map((x) => x)),
        "room_videos": List<dynamic>.from(roomVideos.map((x) => x)),
    };
}
