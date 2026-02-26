import 'package:homesloc/models/freshup/freshup_detail_model.dart';

class SearchHotelModel {
  List<Hotel>? searchResults;
  int? totalCount;

  SearchHotelModel({
    this.searchResults,
    this.totalCount,
  });

  factory SearchHotelModel.fromJson(Map<String, dynamic> json) {
    // Check for 'search_results', 'accommodations', or 'halls'
    final list =
        json["search_results"] ?? json["accommodations"] ?? json["halls"];
    return SearchHotelModel(
      searchResults: list == null
          ? []
          : List<Hotel>.from(list.map((x) => Hotel.fromJson(x))),
      totalCount: json["total_count"],
    );
  }

  Map<String, dynamic> toJson() => {
        "search_results": searchResults == null
            ? []
            : List<dynamic>.from(searchResults!.map((x) => x.toJson())),
        "total_count": totalCount,
      };
}

class Hotel {
  String? id;
  String? uniqueId;
  String? name;
  String? location;
  String? coverImageUrl;
  String? originalPrice;
  dynamic offerPrice;
  dynamic discountPercentage;
  String? taxInfo;
  List<String>? amenities;
  dynamic rating;
  int? reviewCount;
  String? accommodationType;
  bool? isFavorite;
  List<String>? galleryImages;
  FreshupDetailModel? freshupDetails;
  String? latitude;
  String? longitude;

  Hotel({
    this.id,
    this.uniqueId,
    this.name,
    this.location,
    this.coverImageUrl,
    this.originalPrice,
    this.offerPrice,
    this.discountPercentage,
    this.taxInfo,
    this.amenities,
    this.rating,
    this.reviewCount,
    this.accommodationType,
    this.isFavorite,
    this.galleryImages,
    this.freshupDetails,
    this.latitude,
    this.longitude,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    // Handle location from city/state if location is missing
    String? loc = json["location"] is String ? json["location"] : null;

    // Handle nested location object (common in Hall response)
    if (json["location"] is Map) {
      final locMap = json["location"];
      loc = "${locMap["city"] ?? ''}, ${locMap["state"] ?? ''}";
    }
    // Fallback to separate fields
    else if (loc == null && json["city"] != null) {
      loc = "${json["city"]}";
      if (json["state"] != null) {
        loc = "$loc, ${json["state"]}";
      }
    }

    // Determine type
    String? type = json["accommodation_type"];

    // Handle price mapping
    String? price;

    if (type == "FULL_PROPERTY") {
      price = json["base_property_price"]?.toString();
    }

    if (price == null) {
      price = json["original_price"]?.toString();
    }

    if (price == null && json["price"] != null) {
      price = json["price"].toString();
    }

    // Handle Hall Pricing (min price from events)
    if (price == null &&
        json["events"] != null &&
        (json["events"] as List).isNotEmpty) {
      List<dynamic> events = json["events"];
      double? minP;
      for (var event in events) {
        if (event["price"] != null) {
          double? p = double.tryParse(event["price"].toString());
          if (p != null) {
            if (minP == null || p < minP) {
              minP = p;
            }
          }
        }
      }
      if (minP != null) {
        price = minP.toString();
      }
    }

    // Handle amenities which might be List<String> or List<Map>
    List<String> amens = [];
    if (json["amenities"] != null) {
      if (json["amenities"] is List) {
        for (var item in json["amenities"]) {
          if (item is String) {
            amens.add(item);
          } else if (item is Map && item["name"] != null) {
            amens.add(item["name"]);
          }
        }
      }
    }

    // Determine type (already determined above)
    if (type == null && json["events"] != null) {
      type = "HALL";
    }
    if (json["freshup_id"] != null) {
      type = "FRESHUP";
    }

    // Handle gallery images
    List<String> images = [];
    if (json["images"] != null && json["images"] is List) {
      images = List<String>.from(json["images"]);
    } else if (json["gallery_images"] != null &&
        json["gallery_images"] is List) {
      images = List<String>.from(json["gallery_images"]);
    } else if (json["room_images"] != null && json["room_images"] is List) {
      images = List<String>.from(json["room_images"]);
    }

    FreshupDetailModel? freshup;
    if (type == "FRESHUP") {
      freshup = FreshupDetailModel.fromJson(json);
    }

    String? lat = json["latitude"]?.toString();
    String? lng = json["longitude"]?.toString();
    if (json["location"] is Map) {
      final locMap = json["location"];
      if (lat == null) lat = locMap["latitude"]?.toString();
      if (lng == null) lng = locMap["longitude"]?.toString();
    }

    return Hotel(
      id: json["id"],
      uniqueId: json["unique_id"],
      name: json["name"],
      location: loc,
      coverImageUrl: json["cover_image_url"],
      originalPrice: price,
      offerPrice: json["offer_price"],
      discountPercentage: json["discount_percentage"],
      taxInfo: json["tax_info"],
      amenities: amens,
      rating: json["rating"] ?? json["hotel_star_rating"],
      reviewCount: (json["review_count"] as num?)?.toInt(),
      accommodationType: type,
      isFavorite: json["is_favorite"],
      galleryImages: images,
      freshupDetails: freshup,
      latitude: lat,
      longitude: lng,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "unique_id": uniqueId,
        "name": name,
        "location": location,
        "cover_image_url": coverImageUrl,
        "original_price": originalPrice,
        "offer_price": offerPrice,
        "discount_percentage": discountPercentage,
        "tax_info": taxInfo,
        "amenities": amenities == null
            ? []
            : List<dynamic>.from(amenities!.map((x) => x)),
        "rating": rating,
        "review_count": reviewCount,
        "accommodation_type": accommodationType,
        "is_favorite": isFavorite,
        "gallery_images": galleryImages,
        "freshup_details": freshupDetails?.toJson(),
        "latitude": latitude,
        "longitude": longitude,
      };
}
