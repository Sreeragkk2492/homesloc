// To parse this JSON data, do
//
//     final searchFreshUpModel = searchFreshUpModelFromJson(jsonString);

import 'dart:convert';

SearchFreshUpModel searchFreshUpModelFromJson(String str) => SearchFreshUpModel.fromJson(json.decode(str));

String searchFreshUpModelToJson(SearchFreshUpModel data) => json.encode(data.toJson());

class SearchFreshUpModel {
    List<Service>? services;
    int? totalCount;
    int? currentPage;
    int? totalPages;
    bool? hasNext;
    bool? hasPrevious;
    String? message;

    SearchFreshUpModel({
        this.services,
        this.totalCount,
        this.currentPage,
        this.totalPages,
        this.hasNext,
        this.hasPrevious,
        this.message,
    });

    factory SearchFreshUpModel.fromJson(Map<String, dynamic> json) => SearchFreshUpModel(
        services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
        totalCount: json["total_count"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        hasNext: json["has_next"],
        hasPrevious: json["has_previous"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
        "total_count": totalCount,
        "current_page": currentPage,
        "total_pages": totalPages,
        "has_next": hasNext,
        "has_previous": hasPrevious,
        "message": message,
    };
}

class Service {
    String? id;
    String? serviceProviderId;
    String? name;
    String? location;
    String? checkInTime;
    String? checkOutTime;
    bool? cancellation;
    String? startingRange;
    String? endingRange;
    String? latitude;
    String? longitude;
    List<NearByAttraction>? nearByAttraction;
    String? serviceType;
    String? price;
    String? availability;
    String? description;
    List<Amenity>? amenities;
    String? coverImageUrl;
    List<String>? galleryImages;
    bool? isActive;
    DateTime? createdAt;
    String? createdBy;
    DateTime? updatedAt;

    Service({
        this.id,
        this.serviceProviderId,
        this.name,
        this.location,
        this.checkInTime,
        this.checkOutTime,
        this.cancellation,
        this.startingRange,
        this.endingRange,
        this.latitude,
        this.longitude,
        this.nearByAttraction,
        this.serviceType,
        this.price,
        this.availability,
        this.description,
        this.amenities,
        this.coverImageUrl,
        this.galleryImages,
        this.isActive,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        serviceProviderId: json["service_provider_id"],
        name: json["name"],
        location: json["location"],
        checkInTime: json["check_in_time"],
        checkOutTime: json["check_out_time"],
        cancellation: json["cancellation"],
        startingRange: json["starting_range"],
        endingRange: json["ending_range"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        nearByAttraction: json["near_by_attraction"] == null ? [] : List<NearByAttraction>.from(json["near_by_attraction"]!.map((x) => NearByAttraction.fromJson(x))),
        serviceType: json["service_type"],
        price: json["price"],
        availability: json["availability"],
        description: json["description"],
        amenities: json["amenities"] == null ? [] : List<Amenity>.from(json["amenities"]!.map((x) => Amenity.fromJson(x))),
        coverImageUrl: json["cover_image_url"],
        galleryImages: json["gallery_images"] == null ? [] : List<String>.from(json["gallery_images"]!.map((x) => x)),
        isActive: json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "service_provider_id": serviceProviderId,
        "name": name,
        "location": location,
        "check_in_time": checkInTime,
        "check_out_time": checkOutTime,
        "cancellation": cancellation,
        "starting_range": startingRange,
        "ending_range": endingRange,
        "latitude": latitude,
        "longitude": longitude,
        "near_by_attraction": nearByAttraction == null ? [] : List<dynamic>.from(nearByAttraction!.map((x) => x.toJson())),
        "service_type": serviceType,
        "price": price,
        "availability": availability,
        "description": description,
        "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "cover_image_url": coverImageUrl,
        "gallery_images": galleryImages == null ? [] : List<dynamic>.from(galleryImages!.map((x) => x)),
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
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

class NearByAttraction {
    AdditionalProp1? additionalProp1;

    NearByAttraction({
        this.additionalProp1,
    });

    factory NearByAttraction.fromJson(Map<String, dynamic> json) => NearByAttraction(
        additionalProp1: json["additionalProp1"] == null ? null : AdditionalProp1.fromJson(json["additionalProp1"]),
    );

    Map<String, dynamic> toJson() => {
        "additionalProp1": additionalProp1?.toJson(),
    };
}

class AdditionalProp1 {
    AdditionalProp1();

    factory AdditionalProp1.fromJson(Map<String, dynamic> json) => AdditionalProp1(
    );

    Map<String, dynamic> toJson() => {
    };
}
