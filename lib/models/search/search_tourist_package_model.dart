// // To parse this JSON data, do
// //
// //     final searchTouristPackageModel = searchTouristPackageModelFromJson(jsonString);

// import 'dart:convert';

// SearchTouristPackageModel searchTouristPackageModelFromJson(String str) => SearchTouristPackageModel.fromJson(json.decode(str));

// String searchTouristPackageModelToJson(SearchTouristPackageModel data) => json.encode(data.toJson());

// class SearchTouristPackageModel {
//     List<Package>? packages;
//     int? totalCount;
//     int? currentPage;
//     int? totalPages;
//     bool? hasNext;
//     bool? hasPrevious;
//     String? message;

//     SearchTouristPackageModel({
//         this.packages,
//         this.totalCount,
//         this.currentPage,
//         this.totalPages,
//         this.hasNext,
//         this.hasPrevious,
//         this.message,
//     });

//     factory SearchTouristPackageModel.fromJson(Map<String, dynamic> json) => SearchTouristPackageModel(
//         packages: (json["packages"] as List?)?.map((x) => Package.fromJson(x)).toList(),
//         totalCount: json["total_count"] as int?,
//         currentPage: json["current_page"] as int?,
//         totalPages: json["total_pages"] as int?,
//         hasNext: json["has_next"] as bool?,
//         hasPrevious: json["has_previous"] as bool?,
//         message: json["message"] as String?,
//     );

//     Map<String, dynamic> toJson() => {
//         "packages": packages?.map((x) => x.toJson()).toList(),
//         "total_count": totalCount,
//         "current_page": currentPage,
//         "total_pages": totalPages,
//         "has_next": hasNext,
//         "has_previous": hasPrevious,
//         "message": message,
//     };
// }

// class Package {
//     String? id;
//     String? serviceProviderId;
//     String? packageName;
//     String? description;
//     String? destination;
//     String? price;
//     String? discountedPrice;
//     String? currency;
//     int? durationDays;
//     int? durationNights;
//     String? startDate;
//     String? endDate;
//     List<String>? servicesIncluded;
//     String? cancellationPolicy;
//     String? termsAndConditions;
//     String? coverImageUrl;
//     List<String>? galleryImages;
//     String? createdBy;
//     bool? isActive;
//     String? createdAt;
//     String? updatedAt;
//     List<Itinerary>? itineraries;

//     Package({
//         this.id,
//         this.serviceProviderId,
//         this.packageName,
//         this.description,
//         this.destination,
//         this.price,
//         this.discountedPrice,
//         this.currency,
//         this.durationDays,
//         this.durationNights,
//         this.startDate,
//         this.endDate,
//         this.servicesIncluded,
//         this.cancellationPolicy,
//         this.termsAndConditions,
//         this.coverImageUrl,
//         this.galleryImages,
//         this.createdBy,
//         this.isActive,
//         this.createdAt,
//         this.updatedAt,
//         this.itineraries,
//     });

//     factory Package.fromJson(Map<String, dynamic> json) => Package(
//         id: json["id"] as String?,
//         serviceProviderId: json["service_provider_id"] as String?,
//         packageName: json["package_name"] as String?,
//         description: json["description"] as String?,
//         destination: json["destination"] as String?,
//         price: json["price"] as String?,
//         discountedPrice: json["discounted_price"] as String?,
//         currency: json["currency"] as String?,
//         durationDays: json["duration_days"] as int?,
//         durationNights: json["duration_nights"] as int?,
//         startDate: json["start_date"] as String?,
//         endDate: json["end_date"] as String?,
//         servicesIncluded: (json["services_included"] as List?)?.map((x) => x as String).toList(),
//         cancellationPolicy: json["cancellation_policy"] as String?,
//         termsAndConditions: json["terms_and_conditions"] as String?,
//         coverImageUrl: json["cover_image_url"] as String?,
//         galleryImages: (json["gallery_images"] as List?)?.map((x) => x as String).toList(),
//         createdBy: json["created_by"] as String?,
//         isActive: json["is_active"] as bool?,
//         createdAt: json["created_at"] as String?,
//         updatedAt: json["updated_at"] as String?,
//         itineraries: (json["itineraries"] as List?)?.map((x) => Itinerary.fromJson(x)).toList(),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "service_provider_id": serviceProviderId,
//         "package_name": packageName,
//         "description": description,
//         "destination": destination,
//         "price": price,
//         "discounted_price": discountedPrice,
//         "currency": currency,
//         "duration_days": durationDays,
//         "duration_nights": durationNights,
//         "start_date": startDate,
//         "end_date": endDate,
//         "services_included": servicesIncluded,
//         "cancellation_policy": cancellationPolicy,
//         "terms_and_conditions": termsAndConditions,
//         "cover_image_url": coverImageUrl,
//         "gallery_images": galleryImages,
//         "created_by": createdBy,
//         "is_active": isActive,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "itineraries": itineraries?.map((x) => x.toJson()).toList(),
//     };
// }

// class Itinerary {
//     int? dayNumber;
//     String? itineraryDescription;
//     String? location;
//     String? mealPlan;

//     Itinerary({
//         this.dayNumber,
//         this.itineraryDescription,
//         this.location,
//         this.mealPlan,
//     });

//     factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
//         dayNumber: json["day_number"] as int?,
//         itineraryDescription: json["itinerary_description"] as String?,
//         location: json["location"] as String?,
//         mealPlan: json["meal_plan"] as String?,
//     );

//     Map<String, dynamic> toJson() => {
//         "day_number": dayNumber,
//         "itinerary_description": itineraryDescription,
//         "location": location,
//         "meal_plan": mealPlan,
//     };
// }

// To parse this JSON data, do
//
//     final searchTouristPackageModel = searchTouristPackageModelFromJson(jsonString);

import 'dart:convert';

SearchTouristPackageModel searchTouristPackageModelFromJson(String str) => SearchTouristPackageModel.fromJson(json.decode(str));

String searchTouristPackageModelToJson(SearchTouristPackageModel data) => json.encode(data.toJson());

class SearchTouristPackageModel {
    List<Package> packages;
    int totalCount;
    int currentPage;
    int totalPages;
    bool hasNext;
    bool hasPrevious;
    String message;

    SearchTouristPackageModel({
        required this.packages,
        required this.totalCount,
        required this.currentPage,
        required this.totalPages,
        required this.hasNext,
        required this.hasPrevious,
        required this.message,
    });

    factory SearchTouristPackageModel.fromJson(Map<String, dynamic> json) => SearchTouristPackageModel(
        packages: List<Package>.from(json["packages"].map((x) => Package.fromJson(x))),
        totalCount: json["total_count"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        hasNext: json["has_next"],
        hasPrevious: json["has_previous"], 
        message: json["message"],
    ); 

    Map<String, dynamic> toJson() => {
        "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
        "total_count": totalCount,
        "current_page": currentPage,
        "total_pages": totalPages,
        "has_next": hasNext,
        "has_previous": hasPrevious,
        "message": message,
    };
}

// Helper to safely parse int fields from JSON (handles int, double, String, null)
int? parseJsonToInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

class Package {
    String id;
    String packageName;
    String packageType;
    String startLocation;
    String destination;
    List<dynamic> packageMiddlePlace;
    List<TripAttraction> tripAttractions;
    int durationDays;
    int durationNights;
    int priceWithoutFlight;
    int? priceWithFlight;
    int? offerPrice;
    List<String> galleryImages;
    List<Amenity> amenities;
    String agencyname;

    Package({
        required this.id,
        required this.packageName,
        required this.packageType,
        required this.startLocation,
        required this.destination,
        required this.packageMiddlePlace,
        required this.tripAttractions,
        required this.durationDays,
        required this.durationNights,
        required this.priceWithoutFlight,
        required this.priceWithFlight,
        required this.offerPrice,
        required this.galleryImages,
        required this.amenities,
        required this.agencyname,
    });

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        packageName: json["package_name"],
        packageType: json["package_type"],
        startLocation: json["start_location"],
        destination: json["destination"],
        packageMiddlePlace: List<dynamic>.from(json["package_middle_place"].map((x) => x)),
        tripAttractions: List<TripAttraction>.from(json["trip_attractions"].map((x) => TripAttraction.fromJson(x))),
        durationDays: parseJsonToInt(json["duration_days"])
            ?? 0, // fallback to 0 if null
        durationNights: parseJsonToInt(json["duration_nights"])
            ?? 0, // fallback to 0 if null
        priceWithoutFlight: parseJsonToInt(json["price_without_flight"])
            ?? 0, // fallback to 0 if null
        priceWithFlight: parseJsonToInt(json["price_with_flight"]),
        offerPrice: parseJsonToInt(json["offer_price"]),
        galleryImages: List<String>.from(json["gallery_images"].map((x) => x)),
        amenities: List<Amenity>.from(json["amenities"].map((x) => Amenity.fromJson(x))),
        agencyname: json["agencyname"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "package_name": packageName,
        "package_type": packageType,
        "start_location": startLocation,
        "destination": destination,
        "package_middle_place": List<dynamic>.from(packageMiddlePlace.map((x) => x)),
        "trip_attractions": List<dynamic>.from(tripAttractions.map((x) => x.toJson())),
        "duration_days": durationDays,
        "duration_nights": durationNights,
        "price_without_flight": priceWithoutFlight,
        "price_with_flight": priceWithFlight,
        "offer_price": offerPrice,
        "gallery_images": List<dynamic>.from(galleryImages.map((x) => x)),
        "amenities": List<dynamic>.from(amenities.map((x) => x.toJson())),
        "agencyname": agencyname,
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

enum PackageType {
    ADVENTURE_TOURISM,
    WEDDING_TOURISM
}

final packageTypeValues = EnumValues({
    "Adventure Tourism": PackageType.ADVENTURE_TOURISM,
    "Wedding Tourism": PackageType.WEDDING_TOURISM
});

class TripAttraction {
    String attractions;

    TripAttraction({
        required this.attractions,
    });

    factory TripAttraction.fromJson(Map<String, dynamic> json) => TripAttraction(
        attractions: json["attractions"],
    );

    Map<String, dynamic> toJson() => {
        "attractions": attractions,
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

