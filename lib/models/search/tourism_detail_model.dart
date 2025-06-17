// To parse this JSON data, do
//
//     final tourismDetailsModel = tourismDetailsModelFromJson(jsonString);

import 'dart:convert';

TourismDetailsModel tourismDetailsModelFromJson(String str) => TourismDetailsModel.fromJson(json.decode(str));

String tourismDetailsModelToJson(TourismDetailsModel data) => json.encode(data.toJson());

class TourismDetailsModel {
    String id;
    String packageName;
    String packageType;
    String startLocation;
    String destination;
    List<dynamic> packageMiddlePlace;
    List<dynamic> tripAttractions;
    int durationDays;
    int durationNights;
    String description;
    String priceWithoutFlight;
    dynamic priceWithFlight;
    dynamic offerPrice;
    List<String> galleryImages;
    List<Amenity> amenities;
    List<Itinerary> itinerary;
    List<String> images;
    AgencyDetails agencyDetails;
    String message;

    TourismDetailsModel({
        required this.id,
        required this.packageName,
        required this.packageType,
        required this.startLocation,
        required this.destination,
        required this.packageMiddlePlace,
        required this.tripAttractions,
        required this.durationDays,
        required this.durationNights,
        required this.description,
        required this.priceWithoutFlight,
        required this.priceWithFlight,
        required this.offerPrice,
        required this.galleryImages,
        required this.amenities,
        required this.itinerary,
        required this.images,
        required this.agencyDetails,
        required this.message,
    });

    factory TourismDetailsModel.fromJson(Map<String, dynamic> json) => TourismDetailsModel(
        id: json["id"],
        packageName: json["package_name"],
        packageType: json["package_type"],
        startLocation: json["start_location"],
        destination: json["destination"],
        packageMiddlePlace: List<dynamic>.from(json["package_middle_place"].map((x) => x)),
        tripAttractions: List<dynamic>.from(json["trip_attractions"].map((x) => x)),
        durationDays: json["duration_days"],
        durationNights: json["duration_nights"],
        description: json["description"],
        priceWithoutFlight: json["price_without_flight"],
        priceWithFlight: json["price_with_flight"],
        offerPrice: json["offer_price"],
        galleryImages: List<String>.from(json["gallery_images"].map((x) => x)),
        amenities: List<Amenity>.from(json["amenities"].map((x) => Amenity.fromJson(x))),
        itinerary: List<Itinerary>.from(json["itinerary"].map((x) => Itinerary.fromJson(x))),
        images: List<String>.from(json["images"].map((x) => x)),
        agencyDetails: AgencyDetails.fromJson(json["agency_details"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "package_name": packageName,
        "package_type": packageType,
        "start_location": startLocation,
        "destination": destination,
        "package_middle_place": List<dynamic>.from(packageMiddlePlace.map((x) => x)),
        "trip_attractions": List<dynamic>.from(tripAttractions.map((x) => x)),
        "duration_days": durationDays,
        "duration_nights": durationNights,
        "description": description,
        "price_without_flight": priceWithoutFlight,
        "price_with_flight": priceWithFlight,
        "offer_price": offerPrice,
        "gallery_images": List<dynamic>.from(galleryImages.map((x) => x)),
        "amenities": List<dynamic>.from(amenities.map((x) => x.toJson())),
        "itinerary": List<dynamic>.from(itinerary.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x)),
        "agency_details": agencyDetails.toJson(),
        "message": message,
    };
}

class AgencyDetails {
    String id;
    String name;
    String startedSince;
    String email;
    String phoneNumber;
    String coverImageUrl;
    String description;
    List<dynamic> videos;
    List<dynamic> amenities;
    List<dynamic> packages;
    Policies policies;
    LegalPolicies legalPolicies;

    AgencyDetails({
        required this.id,
        required this.name,
        required this.startedSince,
        required this.email,
        required this.phoneNumber,
        required this.coverImageUrl,
        required this.description,
        required this.videos,
        required this.amenities,
        required this.packages,
        required this.policies,
        required this.legalPolicies,
    });

    factory AgencyDetails.fromJson(Map<String, dynamic> json) => AgencyDetails(
        id: json["id"],
        name: json["name"],
        startedSince: json["started_since"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        coverImageUrl: json["cover_image_url"],
        description: json["description"],
        videos: List<dynamic>.from(json["videos"].map((x) => x)),
        amenities: List<dynamic>.from(json["amenities"].map((x) => x)),
        packages: List<dynamic>.from(json["packages"].map((x) => x)),
        policies: Policies.fromJson(json["policies"]),
        legalPolicies: LegalPolicies.fromJson(json["legal_policies"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "started_since": startedSince,
        "email": email,
        "phone_number": phoneNumber,
        "cover_image_url": coverImageUrl,
        "description": description,
        "videos": List<dynamic>.from(videos.map((x) => x)),
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
        "packages": List<dynamic>.from(packages.map((x) => x)),
        "policies": policies.toJson(),
        "legal_policies": legalPolicies.toJson(),
    };
}

class LegalPolicies {
    String id;
    String ownershipType;
    String panCardDetails;
    String propertyRestrictions;
    String gstDetails;
    BankAccountDetails bankAccountDetails;
    List<String> registrationDocument;
    List<String> documentImageUrl;
    List<dynamic> videos;

    LegalPolicies({
        required this.id,
        required this.ownershipType,
        required this.panCardDetails,
        required this.propertyRestrictions,
        required this.gstDetails,
        required this.bankAccountDetails,
        required this.registrationDocument,
        required this.documentImageUrl,
        required this.videos,
    });

    factory LegalPolicies.fromJson(Map<String, dynamic> json) => LegalPolicies(
        id: json["id"],
        ownershipType: json["ownershipType"],
        panCardDetails: json["panCardDetails"],
        propertyRestrictions: json["propertyRestrictions"],
        gstDetails: json["gstDetails"],
        bankAccountDetails: BankAccountDetails.fromJson(json["bankAccountDetails"]),
        registrationDocument: List<String>.from(json["registrationDocument"].map((x) => x)),
        documentImageUrl: List<String>.from(json["document_image_url"].map((x) => x)),
        videos: List<dynamic>.from(json["videos"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ownershipType": ownershipType,
        "panCardDetails": panCardDetails,
        "propertyRestrictions": propertyRestrictions,
        "gstDetails": gstDetails,
        "bankAccountDetails": bankAccountDetails.toJson(),
        "registrationDocument": List<dynamic>.from(registrationDocument.map((x) => x)),
        "document_image_url": List<dynamic>.from(documentImageUrl.map((x) => x)),
        "videos": List<dynamic>.from(videos.map((x) => x)),
    };
}

class BankAccountDetails {
    String accountNumber;
    String ifscCode;
    String bankName;
    String accountHolderName;

    BankAccountDetails({
        required this.accountNumber,
        required this.ifscCode,
        required this.bankName,
        required this.accountHolderName,
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

class Policies {
    String id;
    String cancellationPolicy;
    int cancellationDays;
    String paymentPolicy;
    List<String> acceptableIdentityProof;
    List<String> tripTermsConditions;

    Policies({
        required this.id,
        required this.cancellationPolicy,
        required this.cancellationDays,
        required this.paymentPolicy,
        required this.acceptableIdentityProof,
        required this.tripTermsConditions,
    });

    factory Policies.fromJson(Map<String, dynamic> json) => Policies(
        id: json["id"],
        cancellationPolicy: json["cancellationPolicy"],
        cancellationDays: json["cancellationDays"],
        paymentPolicy: json["paymentPolicy"],
        acceptableIdentityProof: List<String>.from(json["acceptableIdentityProof"].map((x) => x)),
        tripTermsConditions: List<String>.from(json["tripTermsConditions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cancellationPolicy": cancellationPolicy,
        "cancellationDays": cancellationDays,
        "paymentPolicy": paymentPolicy,
        "acceptableIdentityProof": List<dynamic>.from(acceptableIdentityProof.map((x) => x)),
        "tripTermsConditions": List<dynamic>.from(tripTermsConditions.map((x) => x)),
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

class Itinerary {
    String id;
    String day;
    String description;
    dynamic location;
    dynamic mealPlan;

    Itinerary({
        required this.id,
        required this.day,
        required this.description,
        required this.location,
        required this.mealPlan,
    });

    factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
        id: json["id"],
        day: json["day"],
        description: json["description"],
        location: json["location"],
        mealPlan: json["meal_plan"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "description": description,
        "location": location,
        "meal_plan": mealPlan,
    };
}
