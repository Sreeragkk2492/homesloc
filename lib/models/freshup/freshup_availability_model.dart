class FreshupAvailabilityModel {
  List<FreshupAccommodation>? accommodations;
  int? totalCount;
  int? currentPage;
  int? totalPages;
  bool? hasNext;
  bool? hasPrevious;
  String? message;

  FreshupAvailabilityModel({
    this.accommodations,
    this.totalCount,
    this.currentPage,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
    this.message,
  });

  factory FreshupAvailabilityModel.fromJson(Map<String, dynamic> json) {
    List<FreshupAccommodation>? accommodationsList;

    if (json['accommodations'] != null) {
      accommodationsList = List<FreshupAccommodation>.from(
          json['accommodations'].map((x) => FreshupAccommodation.fromJson(x)));
    } else if (json['price_per_room'] != null) {
      accommodationsList = [
        FreshupAccommodation.fromJson(json['price_per_room'])
      ];
    } else if (json['price_per_head'] != null) {
      accommodationsList = [
        FreshupAccommodation.fromJson(json['price_per_head'])
      ];
    }

    return FreshupAvailabilityModel(
      accommodations: accommodationsList,
      totalCount: (json['total_count'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
      hasNext: json['has_next'],
      hasPrevious: json['has_previous'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        "accommodations": accommodations == null
            ? []
            : List<dynamic>.from(accommodations!.map((x) => x.toJson())),
        "total_count": totalCount,
        "current_page": currentPage,
        "total_pages": totalPages,
        "has_next": hasNext,
        "has_previous": hasPrevious,
        "message": message,
      };
}

class FreshupAccommodation {
  String? id;
  String? name;
  String? city;
  String? coverImageUrl;
  double? price;
  double? offerPrice;
  List<FreshupAmenity>? amenities;
  List<FreshupSlot>? slots;
  bool? allSlotsBooked;

  FreshupAccommodation({
    this.id,
    this.name,
    this.city,
    this.coverImageUrl,
    this.price,
    this.offerPrice,
    this.amenities,
    this.slots,
    this.allSlotsBooked,
  });

  factory FreshupAccommodation.fromJson(Map<String, dynamic> json) {
    return FreshupAccommodation(
      id: json['id']?.toString() ?? json['freshup_id']?.toString(),
      name: json['name'] ?? json['freshup_name'],
      city: json['city'],
      coverImageUrl: json['cover_image_url'],
      price: (json['price'] as num?)?.toDouble(),
      offerPrice: (json['offer_price'] as num?)?.toDouble(),
      amenities: json['amenities'] != null
          ? List<FreshupAmenity>.from(
              json['amenities'].map((x) => FreshupAmenity.fromJson(x)))
          : null,
      slots: json['slots'] != null
          ? List<FreshupSlot>.from(
              json['slots'].map((x) => FreshupSlot.fromJson(x)))
          : null,
      allSlotsBooked: json['all_slots_booked'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "cover_image_url": coverImageUrl,
        "price": price,
        "offer_price": offerPrice,
        "amenities": amenities == null
            ? []
            : List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "slots": slots == null
            ? []
            : List<dynamic>.from(slots!.map((x) => x.toJson())),
        "all_slots_booked": allSlotsBooked,
      };
}

class FreshupAmenity {
  String? id;
  String? name;
  String? description;

  FreshupAmenity({this.id, this.name, this.description});

  factory FreshupAmenity.fromJson(Map<String, dynamic> json) {
    return FreshupAmenity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}

class FreshupSlot {
  String? id;
  String? checkIn;
  String? checkOut;

  FreshupSlot({this.id, this.checkIn, this.checkOut});

  factory FreshupSlot.fromJson(Map<String, dynamic> json) {
    return FreshupSlot(
      id: json['id'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "check_in": checkIn,
        "check_out": checkOut,
      };
}
