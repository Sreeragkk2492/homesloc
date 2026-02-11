class SearchHotelModel {
  List<Hotel>? searchResults;
  int? totalCount;

  SearchHotelModel({
    this.searchResults,
    this.totalCount,
  });

  factory SearchHotelModel.fromJson(Map<String, dynamic> json) =>
      SearchHotelModel(
        searchResults: json["search_results"] == null
            ? []
            : List<Hotel>.from(
                json["search_results"]!.map((x) => Hotel.fromJson(x))),
        totalCount: json["total_count"],
      );

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
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        id: json["id"],
        uniqueId: json["unique_id"],
        name: json["name"],
        location: json["location"],
        coverImageUrl: json["cover_image_url"],
        originalPrice: json["original_price"],
        offerPrice: json["offer_price"],
        discountPercentage: json["discount_percentage"],
        taxInfo: json["tax_info"],
        amenities: json["amenities"] == null
            ? []
            : List<String>.from(json["amenities"]!.map((x) => x)),
        rating: json["rating"],
        reviewCount: (json["review_count"] as num?)?.toInt(),
      );

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
      };
}
