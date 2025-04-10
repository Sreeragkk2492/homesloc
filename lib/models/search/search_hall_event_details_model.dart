// To parse this JSON data, do
//
//     final hallEventDetailsModel = hallEventDetailsModelFromJson(jsonString);

import 'dart:convert';

HallEventDetailsModel hallEventDetailsModelFromJson(String str) => HallEventDetailsModel.fromJson(json.decode(str));

String hallEventDetailsModelToJson(HallEventDetailsModel data) => json.encode(data.toJson());

class HallDetails {
    String? id;
    String? name;
    List<String>? eventType;
    List<String>? businessType;
    String? description;
    String? country;
    String? state;
    String? city;
    String? address;
    String? postcode;
    bool? termsandcondition;
    dynamic location;
    String? checkInTime;
    String? checkOutTime;
    bool? cancellation;
    dynamic startingRange;
    dynamic endingRange;
    String? latitude;
    String? longitude;
    List<dynamic>? nearByAttraction;
    int? yearBuild;
    dynamic yearRenovated;
    dynamic availability;
    String? coverImageUrl;
    List<String>? galleryImages;
    List<String>? videos;
    bool? isActive;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<HallEventDetailsModel>? events;
    BanquetPolicies? banquetPolicies;
    FinanceAndLegal? financeAndLegal;

    HallDetails({
        this.id,
        this.name,
        this.eventType,
        this.businessType,
        this.description,
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
        this.availability,
        this.coverImageUrl,
        this.galleryImages,
        this.videos,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.events,
        this.banquetPolicies,
        this.financeAndLegal,
    });

    factory HallDetails.fromJson(Map<String, dynamic> json) => HallDetails(
        id: json["id"],
        name: json["name"],
        eventType: json["event_type"] == null ? [] : List<String>.from(json["event_type"]!.map((x) => x)),
        businessType: json["business_type"] == null ? [] : List<String>.from(json["business_type"]!.map((x) => x)),
        description: json["description"],
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
        nearByAttraction: json["near_by_attraction"] == null ? [] : List<dynamic>.from(json["near_by_attraction"]!.map((x) => x)),
        yearBuild: json["year_build"],
        yearRenovated: json["year_renovated"],
        availability: json["availability"],
        coverImageUrl: json["cover_image_url"],
        galleryImages: json["gallery_images"] == null ? [] : List<String>.from(json["gallery_images"]!.map((x) => x)),
        videos: json["videos"] == null ? [] : List<String>.from(json["videos"]!.map((x) => x)),
        isActive: json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        events: json["events"] == null ? [] : List<HallEventDetailsModel>.from(json["events"]!.map((x) => HallEventDetailsModel.fromJson(x))),
        banquetPolicies: json["banquet_policies"] == null ? null : BanquetPolicies.fromJson(json["banquet_policies"]),
        financeAndLegal: json["finance_and_legal"] == null ? null : FinanceAndLegal.fromJson(json["finance_and_legal"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "event_type": eventType == null ? [] : List<dynamic>.from(eventType!.map((x) => x)),
        "business_type": businessType == null ? [] : List<dynamic>.from(businessType!.map((x) => x)),
        "description": description,
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
        "near_by_attraction": nearByAttraction == null ? [] : List<dynamic>.from(nearByAttraction!.map((x) => x)),
        "year_build": yearBuild,
        "year_renovated": yearRenovated,
        "availability": availability,
        "cover_image_url": coverImageUrl,
        "gallery_images": galleryImages == null ? [] : List<dynamic>.from(galleryImages!.map((x) => x)),
        "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x)),
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "events": events == null ? [] : List<dynamic>.from(events!.map((x) => x.toJson())),
        "banquet_policies": banquetPolicies?.toJson(),
        "finance_and_legal": financeAndLegal?.toJson(),
    };
}

class HallEventDetailsModel {
    String? id;
    String? eventName;
    String? venueType;
    dynamic seatingCapacity;
    dynamic floatingCapacity;
    dynamic totalArea;
    dynamic totalRooms;
    bool? airConditioned;
    String? spaceType;
    String? description;
    String? price;
    dynamic offerPrice;
    bool? hasDining;
    dynamic diningCapacity;
    bool? isActive;
    List<Amenity>? amenities;
    List<String>? images;
    HallDetails? hallDetails;

    HallEventDetailsModel({
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
        this.images,
        this.hallDetails,
    });

    factory HallEventDetailsModel.fromJson(Map<String, dynamic> json) => HallEventDetailsModel(
        id: json["id"],
        eventName: json["event_name"],
        venueType: json["venue_type"],
        seatingCapacity: json["seating_capacity"],
        floatingCapacity: json["floating_capacity"],
        totalArea: json["total_area"],
        totalRooms: json["total_rooms"],
        airConditioned: json["air_conditioned"],
        spaceType: json["space_type"],
        description: json["description"],
        price: json["price"],
        offerPrice: json["offer_price"],
        hasDining: json["has_dining"],
        diningCapacity: json["dining_capacity"],
        isActive: json["is_active"],
        amenities: json["amenities"] == null ? [] : List<Amenity>.from(json["amenities"]!.map((x) => Amenity.fromJson(x))),
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        hallDetails: json["hall_details"] == null ? null : HallDetails.fromJson(json["hall_details"]),
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
        "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "hall_details": hallDetails?.toJson(),
    };
}

class BanquetPolicies {
    String? id;
    String? hallId;
    List<String>? acceptableIdentityProofs;
    String? checkInTime;
    String? checkOutTime;
    int? parkingCapacity;
    String? cancellationPolicy;
    String? propertyRestrictions;
    bool? decorationAllowed;
    bool? valetParkingAvailable;
    dynamic propertyExtraCharges;
    DateTime? updatedAt;

    BanquetPolicies({
        this.id,
        this.hallId,
        this.acceptableIdentityProofs,
        this.checkInTime,
        this.checkOutTime,
        this.parkingCapacity,
        this.cancellationPolicy,
        this.propertyRestrictions,
        this.decorationAllowed,
        this.valetParkingAvailable,
        this.propertyExtraCharges,
        this.updatedAt,
    });

    factory BanquetPolicies.fromJson(Map<String, dynamic> json) => BanquetPolicies(
        id: json["id"],
        hallId: json["hall_id"],
        acceptableIdentityProofs: json["acceptable_identity_proofs"] == null ? [] : List<String>.from(json["acceptable_identity_proofs"]!.map((x) => x)),
        checkInTime: json["check_in_time"],
        checkOutTime: json["check_out_time"],
        parkingCapacity: json["parking_capacity"],
        cancellationPolicy: json["cancellation_policy"],
        propertyRestrictions: json["property_restrictions"],
        decorationAllowed: json["decoration_allowed"],
        valetParkingAvailable: json["valet_parking_available"],
        propertyExtraCharges: json["property_extra_charges"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "hall_id": hallId,
        "acceptable_identity_proofs": acceptableIdentityProofs == null ? [] : List<dynamic>.from(acceptableIdentityProofs!.map((x) => x)),
        "check_in_time": checkInTime,
        "check_out_time": checkOutTime,
        "parking_capacity": parkingCapacity,
        "cancellation_policy": cancellationPolicy,
        "property_restrictions": propertyRestrictions,
        "decoration_allowed": decorationAllowed,
        "valet_parking_available": valetParkingAvailable,
        "property_extra_charges": propertyExtraCharges,
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class FinanceAndLegal {
    String? id;
    String? hallId;
    String? ownershipType;
    BankAccountDetails? bankAccountDetails;
    String? panCardDetails;
    String? gstDetails;
    List<String>? registrationDocument;
    List<String>? documentImageUrl;
    String? propertyRestrictions;
    DateTime? updatedAt;

    FinanceAndLegal({
        this.id,
        this.hallId,
        this.ownershipType,
        this.bankAccountDetails,
        this.panCardDetails,
        this.gstDetails,
        this.registrationDocument,
        this.documentImageUrl,
        this.propertyRestrictions,
        this.updatedAt,
    });

    factory FinanceAndLegal.fromJson(Map<String, dynamic> json) => FinanceAndLegal(
        id: json["id"],
        hallId: json["hall_id"],
        ownershipType: json["ownershipType"],
        bankAccountDetails: json["bankAccountDetails"] == null ? null : BankAccountDetails.fromJson(json["bankAccountDetails"]),
        panCardDetails: json["panCardDetails"],
        gstDetails: json["gstDetails"],
        registrationDocument: json["registrationDocument"] == null ? [] : List<String>.from(json["registrationDocument"]!.map((x) => x)),
        documentImageUrl: json["document_image_url"] == null ? [] : List<String>.from(json["document_image_url"]!.map((x) => x)),
        propertyRestrictions: json["propertyRestrictions"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "hall_id": hallId,
        "ownershipType": ownershipType,
        "bankAccountDetails": bankAccountDetails?.toJson(),
        "panCardDetails": panCardDetails,
        "gstDetails": gstDetails,
        "registrationDocument": registrationDocument == null ? [] : List<dynamic>.from(registrationDocument!.map((x) => x)),
        "document_image_url": documentImageUrl == null ? [] : List<dynamic>.from(documentImageUrl!.map((x) => x)),
        "propertyRestrictions": propertyRestrictions,
        "updated_at": updatedAt?.toIso8601String(),
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
