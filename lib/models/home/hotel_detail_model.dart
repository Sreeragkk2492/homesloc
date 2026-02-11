class HotelDetailModel {
  String? id;
  String? uniqueId;
  String? name;
  String? location;
  String? phoneNumber;
  String? coverImageUrl;
  List<String>? galleryImages;
  num? starRating;
  num? reviewCount;
  String? description;
  List<String>? amenities;
  List<TransportationInfo>? transportationInfo;
  Policies? policies;
  Pricing? pricing;
  List<dynamic>? reviews;
  bool? isFavorite;

  HotelDetailModel({
    this.id,
    this.uniqueId,
    this.name,
    this.location,
    this.phoneNumber,
    this.coverImageUrl,
    this.galleryImages,
    this.starRating,
    this.reviewCount,
    this.description,
    this.amenities,
    this.transportationInfo,
    this.policies,
    this.pricing,
    this.reviews,
    this.isFavorite,
  });

  factory HotelDetailModel.fromJson(Map<String, dynamic> json) =>
      HotelDetailModel(
        id: json["id"],
        uniqueId: json["unique_id"],
        name: json["name"],
        location: json["location"],
        phoneNumber: json["phone_number"],
        coverImageUrl: json["cover_image_url"],
        galleryImages: json["gallery_images"] == null
            ? []
            : List<String>.from(json["gallery_images"]),
        starRating: json["star_rating"],
        reviewCount: json["review_count"],
        description: json["description"],
        amenities: json["amenities"] == null
            ? []
            : List<String>.from(json["amenities"]),
        transportationInfo: json["transportation_info"] == null
            ? []
            : List<TransportationInfo>.from(json["transportation_info"]
                .map((x) => TransportationInfo.fromJson(x))),
        policies: json["policies"] == null
            ? null
            : Policies.fromJson(json["policies"]),
        pricing:
            json["pricing"] == null ? null : Pricing.fromJson(json["pricing"]),
        reviews:
            json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]),
        isFavorite: json["is_favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unique_id": uniqueId,
        "name": name,
        "location": location,
        "phone_number": phoneNumber,
        "cover_image_url": coverImageUrl,
        "gallery_images": galleryImages == null
            ? []
            : List<dynamic>.from(galleryImages!.map((x) => x)),
        "star_rating": starRating,
        "review_count": reviewCount,
        "description": description,
        "amenities": amenities == null
            ? []
            : List<dynamic>.from(amenities!.map((x) => x)),
        "transportation_info": transportationInfo == null
            ? []
            : List<dynamic>.from(transportationInfo!.map((x) => x.toJson())),
        "policies": policies?.toJson(),
        "pricing": pricing?.toJson(),
        "reviews":
            reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
        "is_favorite": isFavorite,
      };
}

class TransportationInfo {
  String? type;
  String? distance;

  TransportationInfo({this.type, this.distance});

  factory TransportationInfo.fromJson(Map<String, dynamic> json) =>
      TransportationInfo(
        type: json["type"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "distance": distance,
      };
}

class Policies {
  String? checkInTime;
  String? checkOutTime;
  String? cancellationPolicy;

  Policies({this.checkInTime, this.checkOutTime, this.cancellationPolicy});

  factory Policies.fromJson(Map<String, dynamic> json) => Policies(
        checkInTime: json["check_in_time"],
        checkOutTime: json["check_out_time"],
        cancellationPolicy: json["cancellation_policy"],
      );

  Map<String, dynamic> toJson() => {
        "check_in_time": checkInTime,
        "check_out_time": checkOutTime,
        "cancellation_policy": cancellationPolicy,
      };
}

class Pricing {
  String? bestPrice;
  dynamic offerPrice;
  String? taxInfo;

  Pricing({this.bestPrice, this.offerPrice, this.taxInfo});

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
        bestPrice: json["best_price"],
        offerPrice: json["offer_price"],
        taxInfo: json["tax_info"],
      );

  Map<String, dynamic> toJson() => {
        "best_price": bestPrice,
        "offer_price": offerPrice,
        "tax_info": taxInfo,
      };
}
