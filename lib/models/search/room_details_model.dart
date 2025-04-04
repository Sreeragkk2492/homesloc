// To parse this JSON data, do
//
//     final roomDetailsModel = roomDetailsModelFromJson(jsonString);

import 'dart:convert';

RoomDetailsModel roomDetailsModelFromJson(String str) => RoomDetailsModel.fromJson(json.decode(str));

String roomDetailsModelToJson(RoomDetailsModel data) => json.encode(data.toJson());

class RoomDetailsModel {
    String? roomName;
    int? quantity;
    String? roomType;
    String? bedType;
    int? maxPerson;
    String? mealOption;
    int? roomSize;
    String? price;
    String? offerPrice;
    String? description;
    List<Amenity>? amenities;
    String? availabilityStatus;
    List<String>? roomImages;
    String? floorPlanImageUrl;
    List<String>? roomVideos;
    bool? smokingAllowed;
    List<String>? images;
    HotelDetails? hotelDetails;

    RoomDetailsModel({
        this.roomName,
        this.quantity,
        this.roomType,
        this.bedType,
        this.maxPerson,
        this.mealOption,
        this.roomSize,
        this.price,
        this.offerPrice,
        this.description,
        this.amenities,
        this.availabilityStatus,
        this.roomImages,
        this.floorPlanImageUrl,
        this.roomVideos,
        this.smokingAllowed,
        this.images,
        this.hotelDetails,
    });

    factory RoomDetailsModel.fromJson(Map<String, dynamic> json) => RoomDetailsModel(
        roomName: json["room_name"]?.toString(),
        quantity: json["quantity"]?.toInt(),
        roomType: json["room_type"]?.toString(),
        bedType: json["bed_type"]?.toString(),
        maxPerson: json["max_person"]?.toInt(),
        mealOption: json["meal_option"]?.toString(),
        roomSize: json["room_size"]?.toInt(),
        price: json["price"]?.toString(),
        offerPrice: json["offer_price"]?.toString(),
        description: json["description"]?.toString(),
        amenities: json["amenities"] == null ? [] : List<Amenity>.from(json["amenities"]!.map((x) => Amenity.fromJson(x))),
        availabilityStatus: json["availability_status"]?.toString(),
        roomImages: json["room_images"] == null ? [] : List<String>.from(json["room_images"]!.map((x) => x.toString())),
        floorPlanImageUrl: json["floor_plan_image_url"]?.toString(),
        roomVideos: json["room_videos"] == null ? [] : List<String>.from(json["room_videos"]?.map((x) => x.toString()) ?? []),
        smokingAllowed: json["smoking_allowed"] as bool?,
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x.toString())),
        hotelDetails: json["hotel_details"] == null ? null : HotelDetails.fromJson(json["hotel_details"]),
    );

    Map<String, dynamic> toJson() => {
        "room_name": roomName,
        "quantity": quantity,
        "room_type": roomType,
        "bed_type": bedType,
        "max_person": maxPerson,
        "meal_option": mealOption,
        "room_size": roomSize,
        "price": price,
        "offer_price": offerPrice,
        "description": description,
        "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "availability_status": availabilityStatus,
        "room_images": roomImages == null ? [] : List<dynamic>.from(roomImages!.map((x) => x)),
        "floor_plan_image_url": floorPlanImageUrl,
        "room_videos": roomVideos == null ? [] : List<dynamic>.from(roomVideos!.map((x) => x)),
        "smoking_allowed": smokingAllowed,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "hotel_details": hotelDetails?.toJson(),
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
        id: json["id"]?.toString(),
        name: json["name"]?.toString(),
        description: json["description"]?.toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
    };
}

class HotelDetails {
    String? id;
    String? name;
    String? hotelType;
    int? starRating;
    int? totalRooms;
    String? roomType;
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
    dynamic startingRange;
    dynamic endingRange;
    String? latitude;
    String? longitude;
    List<NearByAttraction>? nearByAttraction;
    int? yearBuild;
    int? yearRenovated;
    List<dynamic>? awards;
    List<Amenity>? amenities;
    String? coverImageUrl;
    List<String>? galleryImages;
    List<String>? videos;
    bool? isFullProperty;
    bool? isActive;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<Room>? rooms;
    Policies? policies;
    LegalPolicies? legalPolicies;

    HotelDetails({
        this.id,
        this.name,
        this.hotelType,
        this.starRating,
        this.totalRooms,
        this.roomType,
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
        this.isFullProperty,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.rooms,
        this.policies,
        this.legalPolicies,
    });

    factory HotelDetails.fromJson(Map<String, dynamic> json) => HotelDetails(
        id: json["id"]?.toString(),
        name: json["name"]?.toString(),
        hotelType: json["hotel_type"]?.toString(),
        starRating: json["star_rating"]?.toInt(),
        totalRooms: json["total_rooms"]?.toInt(),
        roomType: json["room_type"]?.toString(),
        chanelManagerName: json["chanel_manager_name"]?.toString(),
        description: json["description"]?.toString(),
        email: json["email"]?.toString(),
        phoneNumber: json["phone_number"]?.toString(),
        country: json["country"]?.toString(),
        state: json["state"]?.toString(),
        city: json["city"]?.toString(),
        address: json["address"]?.toString(),
        postcode: json["postcode"]?.toString(),
        termsandcondition: json["termsandcondition"] as bool?,
        location: json["location"]?.toString(),
        checkInTime: json["check_in_time"]?.toString(),
        checkOutTime: json["check_out_time"]?.toString(),
        cancellation: json["cancellation"] as bool?,
        startingRange: json["starting_range"],
        endingRange: json["ending_range"],
        latitude: json["latitude"]?.toString(),
        longitude: json["longitude"]?.toString(),
        nearByAttraction: json["near_by_attraction"] == null ? [] : List<NearByAttraction>.from(json["near_by_attraction"]!.map((x) => NearByAttraction.fromJson(x))),
        yearBuild: json["year_build"]?.toInt(),
        yearRenovated: json["year_renovated"]?.toInt(),
        awards: json["awards"] == null ? [] : List<dynamic>.from(json["awards"]!.map((x) => x)),
        amenities: json["amenities"] == null ? [] : List<Amenity>.from(json["amenities"]!.map((x) => Amenity.fromJson(x))),
        coverImageUrl: json["cover_image_url"]?.toString(),
        galleryImages: json["gallery_images"] == null ? [] : List<String>.from(json["gallery_images"]!.map((x) => x.toString())),
        videos: json["videos"] == null ? [] : List<String>.from(json["videos"]!.map((x) => x.toString())),
        isFullProperty: json["is_full_property"] as bool?,
        isActive: json["is_active"] as bool?,
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        rooms: json["rooms"] == null ? [] : List<Room>.from(json["rooms"]!.map((x) => Room.fromJson(x))),
        policies: json["policies"] == null ? null : Policies.fromJson(json["policies"]),
        legalPolicies: json["legal_policies"] == null ? null : LegalPolicies.fromJson(json["legal_policies"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "hotel_type": hotelType,
        "star_rating": starRating,
        "total_rooms": totalRooms,
        "room_type": roomType,
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
        "near_by_attraction": nearByAttraction == null ? [] : List<dynamic>.from(nearByAttraction!.map((x) => x.toJson())),
        "year_build": yearBuild,
        "year_renovated": yearRenovated,
        "awards": awards == null ? [] : List<dynamic>.from(awards!.map((x) => x)),
        "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "cover_image_url": coverImageUrl,
        "gallery_images": galleryImages == null ? [] : List<dynamic>.from(galleryImages!.map((x) => x)),
        "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x)),
        "is_full_property": isFullProperty,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "rooms": rooms == null ? [] : List<dynamic>.from(rooms!.map((x) => x.toJson())),
        "policies": policies?.toJson(),
        "legal_policies": legalPolicies?.toJson(),
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
        name: json["name"]?.toString(),
        distance: json["distance"]?.toString(),
        description: json["description"]?.toString(),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "distance": distance,
        "description": description,
    };
}

class Room {
    String? id;
    String? roomName;
    List<String>? roomImages;
    String? price;
    String? offerPrice;
    int? roomSize;
    int? quantity;
    String? bedType;
    int? maxPerson;
    String? mealOption;
    String? roomType;
    String? description;
    List<Amenity>? amenities;

    Room({
        this.id,
        this.roomName,
        this.roomImages,
        this.price,
        this.offerPrice,
        this.roomSize,
        this.quantity,
        this.bedType,
        this.maxPerson,
        this.mealOption,
        this.roomType,
        this.description,
        this.amenities,
    });

    factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"]?.toString(),
        roomName: json["room_name"]?.toString(),
        roomImages: json["room_images"] == null ? [] : List<String>.from(json["room_images"]!.map((x) => x.toString())),
        price: json["price"]?.toString(),
        offerPrice: json["offer_price"]?.toString(),
        roomSize: json["room_size"]?.toInt(),
        quantity: json["quantity"]?.toInt(),
        bedType: json["bed_type"]?.toString(),
        maxPerson: json["max_person"]?.toInt(),
        mealOption: json["meal_option"]?.toString(),
        roomType: json["room_type"]?.toString(),
        description: json["description"]?.toString(),
        amenities: json["amenities"] == null ? [] : List<Amenity>.from(json["amenities"]!.map((x) => Amenity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "room_name": roomName,
        "room_images": roomImages == null ? [] : List<dynamic>.from(roomImages!.map((x) => x)),
        "price": price,
        "offer_price": offerPrice,
        "room_size": roomSize,
        "quantity": quantity,
        "bed_type": bedType,
        "max_person": maxPerson,
        "meal_option": mealOption,
        "room_type": roomType,
        "description": description,
        "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
    };
}

class Policies {
    String? id;
    String? checkInTime;
    String? checkOutTime;
    List<String>? acceptableIdentityProof;
    String? cancellationPolicy;
    bool? outsideVisitorAllowed;
    bool? partiesOrEventsAllowed;
    bool? extraBedPolicy;
    String? extraBedRate;
    MealRates? mealRates;
    bool? isActive;
    DateTime? createdAt;
    DateTime? updatedAt;

    Policies({
        this.id,
        this.checkInTime,
        this.checkOutTime,
        this.acceptableIdentityProof,
        this.cancellationPolicy,
        this.outsideVisitorAllowed,
        this.partiesOrEventsAllowed,
        this.extraBedPolicy,
        this.extraBedRate,
        this.mealRates,
        this.isActive,
        this.createdAt,
        this.updatedAt,
    });

    factory Policies.fromJson(Map<String, dynamic> json) => Policies(
        id: json["id"]?.toString(),
        checkInTime: json["checkInTime"]?.toString(),
        checkOutTime: json["checkOutTime"]?.toString(),
        acceptableIdentityProof: json["acceptableIdentityProof"] == null ? [] : List<String>.from(json["acceptableIdentityProof"]!.map((x) => x.toString())),
        cancellationPolicy: json["cancellationPolicy"]?.toString(),
        outsideVisitorAllowed: json["outsideVisitorAllowed"] as bool?,
        partiesOrEventsAllowed: json["partiesOrEventsAllowed"] as bool?,
        extraBedPolicy: json["extraBedPolicy"] as bool?,
        extraBedRate: json["extraBedRate"]?.toString(),
        mealRates: json["mealRates"] == null ? null : MealRates.fromJson(json["mealRates"]),
        isActive: json["is_active"] as bool?,
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "checkInTime": checkInTime,
        "checkOutTime": checkOutTime,
        "acceptableIdentityProof": acceptableIdentityProof == null ? [] : List<dynamic>.from(acceptableIdentityProof!.map((x) => x)),
        "cancellationPolicy": cancellationPolicy,
        "outsideVisitorAllowed": outsideVisitorAllowed,
        "partiesOrEventsAllowed": partiesOrEventsAllowed,
        "extraBedPolicy": extraBedPolicy,
        "extraBedRate": extraBedRate,
        "mealRates": mealRates?.toJson(),
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class MealRates {
    int? breakfast;
    int? lunch;
    int? dinner;

    MealRates({
        this.breakfast,
        this.lunch,
        this.dinner,
    });

    factory MealRates.fromJson(Map<String, dynamic> json) => MealRates(
        breakfast: json["breakfast"]?.toInt(),
        lunch: json["lunch"]?.toInt(),
        dinner: json["dinner"]?.toInt(),
    );

    Map<String, dynamic> toJson() => {
        "breakfast": breakfast,
        "lunch": lunch,
        "dinner": dinner,
    };
}

class LegalPolicies {
    String? id;
    String? ownershipType;
    String? panCardDetails;
    String? gstDetails;
    BankAccountDetails? bankAccountDetails;
    String? propertyRestrictions;
    List<String>? registrationDocument;
    List<String>? documentImageUrl;
    dynamic videos;
    bool? isActive;

    LegalPolicies({
        this.id,
        this.ownershipType,
        this.panCardDetails,
        this.gstDetails,
        this.bankAccountDetails,
        this.propertyRestrictions,
        this.registrationDocument,
        this.documentImageUrl,
        this.videos,
        this.isActive,
    });

    factory LegalPolicies.fromJson(Map<String, dynamic> json) => LegalPolicies(
        id: json["id"]?.toString(),
        ownershipType: json["ownershipType"]?.toString(),
        panCardDetails: json["panCardDetails"]?.toString(),
        gstDetails: json["gstDetails"]?.toString(),
        bankAccountDetails: json["bankAccountDetails"] == null ? null : BankAccountDetails.fromJson(json["bankAccountDetails"]),
        propertyRestrictions: json["propertyRestrictions"]?.toString(),
        registrationDocument: json["registrationDocument"] == null ? [] : List<String>.from(json["registrationDocument"]!.map((x) => x.toString())),
        documentImageUrl: json["document_image_url"] == null ? [] : List<String>.from(json["document_image_url"]!.map((x) => x.toString())),
        videos: json["videos"],
        isActive: json["is_active"] as bool?,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ownershipType": ownershipType,
        "panCardDetails": panCardDetails,
        "gstDetails": gstDetails,
        "bankAccountDetails": bankAccountDetails?.toJson(),
        "propertyRestrictions": propertyRestrictions,
        "registrationDocument": registrationDocument == null ? [] : List<dynamic>.from(registrationDocument!.map((x) => x)),
        "document_image_url": documentImageUrl == null ? [] : List<dynamic>.from(documentImageUrl!.map((x) => x)),
        "videos": videos,
        "is_active": isActive,
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
        accountNumber: json["account_number"]?.toString(),
        ifscCode: json["ifsc_code"]?.toString(),
        bankName: json["bank_name"]?.toString(),
        accountHolderName: json["account_holder_name"]?.toString(),
    );

    Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "ifsc_code": ifscCode,
        "bank_name": bankName,
        "account_holder_name": accountHolderName,
    };
} 
