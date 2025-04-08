// To parse this JSON data, do
//
//     final hallModel = hallModelFromJson(jsonString);

import 'dart:convert';

HallModel hallModelFromJson(String str) => HallModel.fromJson(json.decode(str));

String hallModelToJson(HallModel data) => json.encode(data.toJson());

class HallModel {
    List<Hall>? halls;
    int? totalCount;
    int? currentPage;
    int? totalPages;
    bool? hasNext;
    bool? hasPrevious;
    String? message;

    HallModel({
        this.halls,
        this.totalCount,
        this.currentPage,
        this.totalPages,
        this.hasNext,
        this.hasPrevious,
        this.message,
    });

    factory HallModel.fromJson(Map<String, dynamic> json) => HallModel(
        halls: json["halls"] == null ? [] : List<Hall>.from(json["halls"]!.map((x) => Hall.fromJson(x))),
        totalCount: json["total_count"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        hasNext: json["has_next"],
        hasPrevious: json["has_previous"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "halls": halls == null ? [] : List<dynamic>.from(halls!.map((x) => x.toJson())),
        "total_count": totalCount,
        "current_page": currentPage,
        "total_pages": totalPages,
        "has_next": hasNext,
        "has_previous": hasPrevious,
        "message": message,
    };
}

class Hall {
    String? id;
    String? name;
    LocationInfo? locationInfo;
    List<HallType>? hallType;
    String? priceRange;
    String? coverImage;
    BanquetPolicies? banquetPolicies;
    FinanceAndLegal? financeAndLegal;

    Hall({
        this.id,
        this.name,
        this.locationInfo,
        this.hallType,
        this.priceRange,
        this.coverImage,
        this.banquetPolicies,
        this.financeAndLegal,
    });

    factory Hall.fromJson(Map<String, dynamic> json) => Hall(
        id: json["id"],
        name: json["name"],
        locationInfo: json["locationInfo"] == null ? null : LocationInfo.fromJson(json["locationInfo"]),
        hallType: json["hall_type"] == null ? [] : List<HallType>.from(json["hall_type"]!.map((x) => HallType.fromJson(x))),
        priceRange: json["priceRange"],
        coverImage: json["coverImage"],
        banquetPolicies: json["banquetPolicies"] == null ? null : BanquetPolicies.fromJson(json["banquetPolicies"]),
        financeAndLegal: json["financeAndLegal"] == null ? null : FinanceAndLegal.fromJson(json["financeAndLegal"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "locationInfo": locationInfo?.toJson(),
        "hall_type": hallType == null ? [] : List<dynamic>.from(hallType!.map((x) => x.toJson())),
        "priceRange": priceRange,
        "coverImage": coverImage,
        "banquetPolicies": banquetPolicies?.toJson(),
        "financeAndLegal": financeAndLegal?.toJson(),
    };
}

class BanquetPolicies {
    String? id;
    String? hallId;
    String? checkInTime;
    String? checkOutTime;
    List<String>? acceptableIdentityProofs;
    String? cancellationPolicy;
    int? parkingCapacity;
    String? propertyRestrictions;
    int? propertyExtraCharges;
    bool? decorationAllowed;
    bool? valetParkingAvailable;
    bool? isActive;

    BanquetPolicies({
        this.id,
        this.hallId,
        this.checkInTime,
        this.checkOutTime,
        this.acceptableIdentityProofs,
        this.cancellationPolicy,
        this.parkingCapacity,
        this.propertyRestrictions,
        this.propertyExtraCharges,
        this.decorationAllowed,
        this.valetParkingAvailable,
        this.isActive,
    });

    factory BanquetPolicies.fromJson(Map<String, dynamic> json) => BanquetPolicies(
        id: json["id"],
        hallId: json["hall_id"],
        checkInTime: json["check_in_time"],
        checkOutTime: json["check_out_time"],
        acceptableIdentityProofs: json["acceptable_identity_proofs"] == null ? [] : List<String>.from(json["acceptable_identity_proofs"]!.map((x) => x)),
        cancellationPolicy: json["cancellation_policy"],
        parkingCapacity: json["parking_capacity"],
        propertyRestrictions: json["property_restrictions"],
        propertyExtraCharges: json["property_extra_charges"],
        decorationAllowed: json["decoration_allowed"],
        valetParkingAvailable: json["valet_parking_available"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "hall_id": hallId,
        "check_in_time": checkInTime,
        "check_out_time": checkOutTime,
        "acceptable_identity_proofs": acceptableIdentityProofs == null ? [] : List<dynamic>.from(acceptableIdentityProofs!.map((x) => x)),
        "cancellation_policy": cancellationPolicy,
        "parking_capacity": parkingCapacity,
        "property_restrictions": propertyRestrictions,
        "property_extra_charges": propertyExtraCharges,
        "decoration_allowed": decorationAllowed,
        "valet_parking_available": valetParkingAvailable,
        "is_active": isActive,
    };
}

class FinanceAndLegal {
    String? id;
    String? hallId;
    String? ownershipType;
    String? panCardDetails;
    String? gstDetails;
    BankAccountDetails? bankAccountDetails;
    String? propertyRestrictions;
    List<String>? registrationDocument;
    List<String>? documentImageUrl;
    List<dynamic>? videos;
    bool? isActive;

    FinanceAndLegal({
        this.id,
        this.hallId,
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

    factory FinanceAndLegal.fromJson(Map<String, dynamic> json) => FinanceAndLegal(
        id: json["id"],
        hallId: json["hall_id"],
        ownershipType: json["ownershipType"],
        panCardDetails: json["panCardDetails"],
        gstDetails: json["gstDetails"],
        bankAccountDetails: json["bankAccountDetails"] == null ? null : BankAccountDetails.fromJson(json["bankAccountDetails"]),
        propertyRestrictions: json["propertyRestrictions"],
        registrationDocument: json["registrationDocument"] == null ? [] : List<String>.from(json["registrationDocument"]!.map((x) => x)),
        documentImageUrl: json["document_image_url"] == null ? [] : List<String>.from(json["document_image_url"]!.map((x) => x)),
        videos: json["videos"] == null ? [] : List<dynamic>.from(json["videos"]!.map((x) => x)),
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "hall_id": hallId,
        "ownershipType": ownershipType,
        "panCardDetails": panCardDetails,
        "gstDetails": gstDetails,
        "bankAccountDetails": bankAccountDetails?.toJson(),
        "propertyRestrictions": propertyRestrictions,
        "registrationDocument": registrationDocument == null ? [] : List<dynamic>.from(registrationDocument!.map((x) => x)),
        "document_image_url": documentImageUrl == null ? [] : List<dynamic>.from(documentImageUrl!.map((x) => x)),
        "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x)),
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

class HallType {
    String? id;
    String? eventName;
    int? seatingCapacity;
    int? floatingCapacity;
    String? venueType;
    String? spaceType;
    String? price;
    String? offerPrice;
    List<Amenity>? amenities;
    bool? isActive;

    HallType({
        this.id,
        this.eventName,
        this.seatingCapacity,
        this.floatingCapacity,
        this.venueType,
        this.spaceType,
        this.price,
        this.offerPrice,
        this.amenities,
        this.isActive,
    });

    factory HallType.fromJson(Map<String, dynamic> json) => HallType(
        id: json["id"],
        eventName: json["event_name"],
        seatingCapacity: json["seating_capacity"],
        floatingCapacity: json["floating_capacity"],
        venueType: json["venue_type"],
        spaceType: json["space_type"],
        price: json["price"],
        offerPrice: json["offer_price"],
        amenities: json["amenities"] == null ? [] : List<Amenity>.from(json["amenities"]!.map((x) => Amenity.fromJson(x))),
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "event_name": eventName,
        "seating_capacity": seatingCapacity,
        "floating_capacity": floatingCapacity,
        "venue_type": venueType,
        "space_type": spaceType,
        "price": price,
        "offer_price": offerPrice,
        "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "is_active": isActive,
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

class LocationInfo {
    String? city;
    String? state;
    String? country;
    String? postcode;
    String? address;

    LocationInfo({
        this.city,
        this.state,
        this.country,
        this.postcode,
        this.address,
    });

    factory LocationInfo.fromJson(Map<String, dynamic> json) => LocationInfo(
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postcode: json["postcode"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "country": country,
        "postcode": postcode,
        "address": address,
    };
}
