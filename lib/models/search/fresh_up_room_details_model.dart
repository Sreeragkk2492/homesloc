// To parse this JSON data, do
//
//     final freshUpRoomDetailsModel = freshUpRoomDetailsModelFromJson(jsonString);

import 'dart:convert';

FreshUpRoomDetailsModel freshUpRoomDetailsModelFromJson(String str) => FreshUpRoomDetailsModel.fromJson(json.decode(str));

String freshUpRoomDetailsModelToJson(FreshUpRoomDetailsModel data) => json.encode(data.toJson());

class FreshUpRoomDetailsModel {
    String? priceMethod;
    PricePerHead? pricePerHead;
    PricePerRoom? pricePerRoom;
    List<String>? images;
    PropertyDetails? propertyDetails;

    FreshUpRoomDetailsModel({
        this.priceMethod,
        this.pricePerHead,
        this.pricePerRoom,
        this.images,
        this.propertyDetails,
    });

    factory FreshUpRoomDetailsModel.fromJson(Map<String, dynamic> json) => FreshUpRoomDetailsModel(
        priceMethod: json["price_method"],
        pricePerHead: json["price_per_head"] == null ? null : PricePerHead.fromJson(json["price_per_head"]),
        pricePerRoom: json["price_per_room"] == null ? null : PricePerRoom.fromJson(json["price_per_room"]),
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        propertyDetails: json["property_details"] == null ? null : PropertyDetails.fromJson(json["property_details"]),
    );

    Map<String, dynamic> toJson() => {
        "price_method": priceMethod,
        "price_per_head": pricePerHead?.toJson(),
        "price_per_room": pricePerRoom?.toJson(),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "property_details": propertyDetails?.toJson(),
    };
}

class PricePerRoom {
    String? freshupName;
    String? freshupType;
    String? bedType;
    num? availableRooms;
    num? price;
    num? offerPrice;
    num? maxPersons;
    List<String>? amenityIds;
    List<Amenity>? amenities;
    String? freshupDescription;
    String? roomSize;
    bool? smokingAllowed;
    bool? bathroomAttached;
    List<String>? roomImages;
    List<Slot>? slots;
    String? id;
    String? priceMethod;

    PricePerRoom({
        this.freshupName,
        this.freshupType,
        this.bedType,
        this.availableRooms,
        this.price,
        this.offerPrice,
        this.maxPersons,
        this.amenityIds,
        this.amenities,
        this.freshupDescription,
        this.roomSize,
        this.smokingAllowed,
        this.bathroomAttached,
        this.roomImages,
        this.slots,
        this.id,
        this.priceMethod,
    });

    factory PricePerRoom.fromJson(Map<String, dynamic> json) => PricePerRoom(
        freshupName: json["freshup_name"],
        freshupType: json["freshup_type"],
        bedType: json["bed_type"],
        availableRooms: json["available_rooms"],
        price: json["price"],
        offerPrice: json["offer_price"],
        maxPersons: json["max_persons"],
        amenityIds: json["amenity_ids"] == null ? [] : List<String>.from(json["amenity_ids"]!.map((x) => x)),
        amenities: json["amenities"] == null ? [] : List<Amenity>.from(json["amenities"]!.map((x) => Amenity.fromJson(x))),
        freshupDescription: json["freshup_description"],
        roomSize: json["room_size"],
        smokingAllowed: json["smoking_allowed"],
        bathroomAttached: json["bathroom_attached"],
        roomImages: json["room_images"] == null ? [] : List<String>.from(json["room_images"]!.map((x) => x)),
        slots: json["slots"] == null ? [] : List<Slot>.from(json["slots"]!.map((x) => Slot.fromJson(x))),
        id: json["id"],
        priceMethod: json["price_method"],
    );

    Map<String, dynamic> toJson() => {
        "freshup_name": freshupName,
        "freshup_type": freshupType,
        "bed_type": bedType,
        "available_rooms": availableRooms,
        "price": price,
        "offer_price": offerPrice,
        "max_persons": maxPersons,
        "amenity_ids": amenityIds == null ? [] : List<dynamic>.from(amenityIds!.map((x) => x)),
        "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "freshup_description": freshupDescription,
        "room_size": roomSize,
        "smoking_allowed": smokingAllowed,
        "bathroom_attached": bathroomAttached,
        "room_images": roomImages == null ? [] : List<dynamic>.from(roomImages!.map((x) => x)),
        "slots": slots == null ? [] : List<dynamic>.from(slots!.map((x) => x.toJson())),
        "id": id,
        "price_method": priceMethod,
    };
}

class PricePerHead {
    String? freshupName;
    String? freshupType;
    num? maxPersons;
    num? minPersons;
    num? perHeadPrice;
    num? price;
    num? offerPrice;
    num? totalNumber;
    List<String>? amenityIds;
    List<Amenity>? amenities;
    String? freshupDescription;
    String? roomSize;
    bool? smokingAllowed;
    bool? bathroomAttached;
    List<String>? roomImages;
    List<Slot>? slots;
    String? id;
    String? priceMethod;

    PricePerHead({
        this.freshupName,
        this.freshupType,
        this.maxPersons,
        this.minPersons,
        this.perHeadPrice,
        this.price,
        this.offerPrice,
        this.totalNumber,
        this.amenityIds,
        this.amenities,
        this.freshupDescription,
        this.roomSize,
        this.smokingAllowed,
        this.bathroomAttached,
        this.roomImages,
        this.slots,
        this.id,
        this.priceMethod,
    });

    factory PricePerHead.fromJson(Map<String, dynamic> json) => PricePerHead(
        freshupName: json["freshup_name"],
        freshupType: json["freshup_type"],
        maxPersons: json["max_persons"],
        minPersons: json["min_persons"],
        perHeadPrice: json["per_head_price"],
        price: json["price"],
        offerPrice: json["offer_price"],
        totalNumber: json["total_number"],
        amenityIds: json["amenity_ids"] == null ? [] : List<String>.from(json["amenity_ids"]!.map((x) => x)),
        amenities: json["amenities"] == null ? [] : List<Amenity>.from(json["amenities"]!.map((x) => Amenity.fromJson(x))),
        freshupDescription: json["freshup_description"],
        roomSize: json["room_size"],
        smokingAllowed: json["smoking_allowed"],
        bathroomAttached: json["bathroom_attached"],
        roomImages: json["room_images"] == null ? [] : List<String>.from(json["room_images"]!.map((x) => x)),
        slots: json["slots"] == null ? [] : List<Slot>.from(json["slots"]!.map((x) => Slot.fromJson(x))),
        id: json["id"],
        priceMethod: json["price_method"],
    );

    Map<String, dynamic> toJson() => {
        "freshup_name": freshupName,
        "freshup_type": freshupType,
        "max_persons": maxPersons,
        "min_persons": minPersons,
        "per_head_price": perHeadPrice,
        "price": price,
        "offer_price": offerPrice,
        "total_number": totalNumber,
        "amenity_ids": amenityIds == null ? [] : List<dynamic>.from(amenityIds!.map((x) => x)),
        "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "freshup_description": freshupDescription,
        "room_size": roomSize,
        "smoking_allowed": smokingAllowed,
        "bathroom_attached": bathroomAttached,
        "room_images": roomImages == null ? [] : List<dynamic>.from(roomImages!.map((x) => x)),
        "slots": slots == null ? [] : List<dynamic>.from(slots!.map((x) => x.toJson())),
        "id": id,
        "price_method": priceMethod,
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

class Slot {
    String? checkIn;
    String? checkOut;

    Slot({
        this.checkIn,
        this.checkOut,
    });

    factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        checkIn: json["check_in"],
        checkOut: json["check_out"],
    );

    Map<String, dynamic> toJson() => {
        "check_in": checkIn,
        "check_out": checkOut,
    };
}

class PropertyDetails {
    String? name;
    num? yearBuild;
    num? starRating;
    num? yearRenovated;
    String? description;
    String? email;
    String? phoneNumber;
    List<Amenity>? freshupAmenities;
    List<NearByAttraction>? nearByAttraction;
    dynamic awards;
    String? country;
    String? state;
    String? city;
    String? postcode;
    String? address;
    bool? termsandcondition;
    String? latitude;
    String? longitude;
    String? coverImageUrl;
    List<String>? videos;
    List<PricePerHead>? rooms;
    FreshupPolicies? freshupPolicies;
    FreshupLegalPolicies? freshupLegalPolicies;

    PropertyDetails({
        this.name,
        this.yearBuild,
        this.starRating,
        this.yearRenovated,
        this.description,
        this.email,
        this.phoneNumber,
        this.freshupAmenities,
        this.nearByAttraction,
        this.awards,
        this.country,
        this.state,
        this.city,
        this.postcode,
        this.address,
        this.termsandcondition,
        this.latitude,
        this.longitude,
        this.coverImageUrl,
        this.videos,
        this.rooms,
        this.freshupPolicies,
        this.freshupLegalPolicies,
    });

    factory PropertyDetails.fromJson(Map<String, dynamic> json) => PropertyDetails(
        name: json["name"],
        yearBuild: json["year_build"],
        starRating: json["star_rating"],
        yearRenovated: json["year_renovated"],
        description: json["description"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        freshupAmenities: json["freshup_amenities"] == null ? [] : List<Amenity>.from(json["freshup_amenities"]!.map((x) => Amenity.fromJson(x))),
        nearByAttraction: json["near_by_attraction"] == null ? [] : List<NearByAttraction>.from(json["near_by_attraction"]!.map((x) => NearByAttraction.fromJson(x))),
        awards: json["awards"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        postcode: json["postcode"],
        address: json["address"],
        termsandcondition: json["termsandcondition"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        coverImageUrl: json["cover_image_url"],
        videos: json["videos"] == null ? [] : List<String>.from(json["videos"]!.map((x) => x)),
        rooms: json["rooms"] == null ? [] : List<PricePerHead>.from(json["rooms"]!.map((x) => PricePerHead.fromJson(x))),
        freshupPolicies: json["freshup_policies"] == null ? null : FreshupPolicies.fromJson(json["freshup_policies"]),
        freshupLegalPolicies: json["freshup_legal_policies"] == null ? null : FreshupLegalPolicies.fromJson(json["freshup_legal_policies"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "year_build": yearBuild,
        "star_rating": starRating,
        "year_renovated": yearRenovated,
        "description": description,
        "email": email,
        "phone_number": phoneNumber,
        "freshup_amenities": freshupAmenities == null ? [] : List<dynamic>.from(freshupAmenities!.map((x) => x.toJson())),
        "near_by_attraction": nearByAttraction == null ? [] : List<dynamic>.from(nearByAttraction!.map((x) => x.toJson())),
        "awards": awards,
        "country": country,
        "state": state,
        "city": city,
        "postcode": postcode,
        "address": address,
        "termsandcondition": termsandcondition,
        "latitude": latitude,
        "longitude": longitude,
        "cover_image_url": coverImageUrl,
        "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x)),
        "rooms": rooms == null ? [] : List<dynamic>.from(rooms!.map((x) => x.toJson())),
        "freshup_policies": freshupPolicies?.toJson(),
        "freshup_legal_policies": freshupLegalPolicies?.toJson(),
    };
}

class FreshupLegalPolicies {
    String? ownershipType;
    String? panCardDetails;
    String? propertyRestrictions;
    String? gstDetails;
    BankAccountDetails? bankAccountDetails;
    List<String>? registrationDocument;
    List<String>? documentImageUrl;

    FreshupLegalPolicies({
        this.ownershipType,
        this.panCardDetails,
        this.propertyRestrictions,
        this.gstDetails,
        this.bankAccountDetails,
        this.registrationDocument,
        this.documentImageUrl,
    });

    factory FreshupLegalPolicies.fromJson(Map<String, dynamic> json) => FreshupLegalPolicies(
        ownershipType: json["ownershipType"],
        panCardDetails: json["panCardDetails"],
        propertyRestrictions: json["propertyRestrictions"],
        gstDetails: json["gstDetails"],
        bankAccountDetails: json["bankAccountDetails"] == null ? null : BankAccountDetails.fromJson(json["bankAccountDetails"]),
        registrationDocument: json["registrationDocument"] == null ? [] : List<String>.from(json["registrationDocument"]!.map((x) => x)),
        documentImageUrl: json["document_image_url"] == null ? [] : List<String>.from(json["document_image_url"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "ownershipType": ownershipType,
        "panCardDetails": panCardDetails,
        "propertyRestrictions": propertyRestrictions,
        "gstDetails": gstDetails,
        "bankAccountDetails": bankAccountDetails?.toJson(),
        "registrationDocument": registrationDocument == null ? [] : List<dynamic>.from(registrationDocument!.map((x) => x)),
        "document_image_url": documentImageUrl == null ? [] : List<dynamic>.from(documentImageUrl!.map((x) => x)),
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

class FreshupPolicies {
    List<String>? acceptableIdentityProof;
    String? cancellationPolicy;
    String? acceptedtimeslots;
    String? extraBedPolicy;
    String? propertyrules;
    num? extraBedPrice;

    FreshupPolicies({
        this.acceptableIdentityProof,
        this.cancellationPolicy,
        this.acceptedtimeslots,
        this.extraBedPolicy,
        this.propertyrules,
        this.extraBedPrice,
    });

    factory FreshupPolicies.fromJson(Map<String, dynamic> json) => FreshupPolicies(
        acceptableIdentityProof: json["acceptableIdentityProof"] == null ? [] : List<String>.from(json["acceptableIdentityProof"]!.map((x) => x)),
        cancellationPolicy: json["cancellationPolicy"],
        acceptedtimeslots: json["acceptedtimeslots"],
        extraBedPolicy: json["extraBedPolicy"],
        propertyrules: json["propertyrules"],
        extraBedPrice: json["extra_bed_price"],
    );

    Map<String, dynamic> toJson() => {
        "acceptableIdentityProof": acceptableIdentityProof == null ? [] : List<dynamic>.from(acceptableIdentityProof!.map((x) => x)),
        "cancellationPolicy": cancellationPolicy,
        "acceptedtimeslots": acceptedtimeslots,
        "extraBedPolicy": extraBedPolicy,
        "propertyrules": propertyrules,
        "extra_bed_price": extraBedPrice,
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
