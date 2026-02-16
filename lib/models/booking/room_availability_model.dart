class RoomAvailabilityModel {
  RoomDetails? roomDetails;
  PropertyDetails? propertyDetails;
  HotelDetails? hotelDetails;
  BookingDetails? bookingDetails;
  bool? isAvailable;
  List<dynamic>? filterErrors;

  RoomAvailabilityModel({
    this.roomDetails,
    this.propertyDetails,
    this.hotelDetails,
    this.bookingDetails,
    this.isAvailable,
    this.filterErrors,
  });

  factory RoomAvailabilityModel.fromJson(Map<String, dynamic> json) =>
      RoomAvailabilityModel(
        roomDetails: json["room_details"] == null
            ? null
            : RoomDetails.fromJson(json["room_details"]),
        propertyDetails: json["property_details"] == null
            ? null
            : PropertyDetails.fromJson(json["property_details"]),
        hotelDetails: json["hotel_details"] == null
            ? null
            : HotelDetails.fromJson(json["hotel_details"]),
        bookingDetails: json["booking_details"] == null
            ? null
            : BookingDetails.fromJson(json["booking_details"]),
        isAvailable: json["is_available"],
        filterErrors: json["filter_errors"] ?? [],
      );
}

class PropertyDetails {
  String? id;
  num? basePropertyPrice;
  num? maxPropertyPrice;
  num? offerPrice;
  bool? smokingAllowed;
  int? maxPerson;
  String? mealOption;
  List<dynamic>? rooms; // keeping dynamic as structure is partial/complex
  List<dynamic>? amenities;

  PropertyDetails({
    this.id,
    this.basePropertyPrice,
    this.maxPropertyPrice,
    this.offerPrice,
    this.smokingAllowed,
    this.maxPerson,
    this.mealOption,
    this.rooms,
    this.amenities,
  });

  factory PropertyDetails.fromJson(Map<String, dynamic> json) =>
      PropertyDetails(
        id: json["id"]?.toString(),
        basePropertyPrice:
            num.tryParse(json["base_property_price"]?.toString() ?? ''),
        maxPropertyPrice:
            num.tryParse(json["max_property_price"]?.toString() ?? ''),
        offerPrice: num.tryParse(json["offer_price"]?.toString() ?? ''),
        smokingAllowed: json["smoking_allowed"],
        maxPerson: int.tryParse(json["max_person"]?.toString() ?? ''),
        mealOption: json["meal_option"],
        rooms: json["rooms"] == null ? [] : List<dynamic>.from(json["rooms"]),
        amenities: json["amenities"] == null
            ? []
            : List<dynamic>.from(json["amenities"]),
      );
}

class RoomDetails {
  String? id;
  String? roomName;
  String? roomType;
  String? bedType;
  String? description;
  List<String>? roomImages;

  RoomDetails({
    this.id,
    this.roomName,
    this.roomType,
    this.bedType,
    this.description,
    this.roomImages,
  });

  factory RoomDetails.fromJson(Map<String, dynamic> json) => RoomDetails(
        id: json["id"],
        roomName: json["room_name"],
        roomType: json["room_type"],
        bedType: json["bed_type"],
        description: json["description"],
        roomImages: json["room_images"] == null
            ? []
            : List<String>.from(json["room_images"]),
      );
}

class HotelDetails {
  String? id;
  String? name;
  String? location;
  num? starRating;
  String? coverImageUrl;

  HotelDetails({
    this.id,
    this.name,
    this.location,
    this.starRating,
    this.coverImageUrl,
  });

  factory HotelDetails.fromJson(Map<String, dynamic> json) => HotelDetails(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        starRating: json["star_rating"],
        coverImageUrl: json["cover_image_url"],
      );
}

class BookingDetails {
  String? checkin;
  String? checkout;
  int? nights;
  int? days;
  int? adults;
  int? children;
  int? roomsRequested;
  num? price;
  num? offerPrice;
  Map<String, dynamic>? priceSummary;
  List<DateDetail>? dateDetails;

  BookingDetails({
    this.checkin,
    this.checkout,
    this.nights,
    this.days,
    this.adults,
    this.children,
    this.roomsRequested,
    this.price,
    this.offerPrice,
    this.priceSummary,
    this.dateDetails,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
        checkin: json["checkin"],
        checkout: json["checkout"],
        nights: int.tryParse(json["nights"]?.toString() ?? ''),
        days: int.tryParse(json["days"]?.toString() ?? ''),
        adults: int.tryParse(json["adults"]?.toString() ?? ''),
        children: int.tryParse(json["children"]?.toString() ?? ''),
        roomsRequested: int.tryParse(json["rooms_requested"]?.toString() ?? ''),
        price: num.tryParse(json["price"]?.toString() ?? ''),
        offerPrice: num.tryParse(json["offer_price"]?.toString() ?? ''),
        priceSummary: json["price_summary"],
        dateDetails: json["date_details"] == null
            ? []
            : List<DateDetail>.from(
                json["date_details"].map((x) => DateDetail.fromJson(x))),
      );
}

class DateDetail {
  String? date;
  num? basePrice;
  num? offerPrice;
  int? availableQuantity;
  bool? isAvailable;
  String? checkinTime;
  String? checkoutTime;

  DateDetail({
    this.date,
    this.basePrice,
    this.offerPrice,
    this.availableQuantity,
    this.isAvailable,
    this.checkinTime,
    this.checkoutTime,
  });

  factory DateDetail.fromJson(Map<String, dynamic> json) => DateDetail(
        date: json["date"],
        basePrice: num.tryParse(json["base_price"]?.toString() ?? ''),
        offerPrice: num.tryParse(json["offer_price"]?.toString() ?? ''),
        availableQuantity:
            int.tryParse(json["available_quantity"]?.toString() ?? ''),
        isAvailable: json["is_available"],
        checkinTime: json["checkin_time"],
        checkoutTime: json["checkout_time"],
      );
}
