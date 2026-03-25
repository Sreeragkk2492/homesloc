class FreshupBookingDetails {
  String? checkin;
  int? slots;
  int? days;
  int? adults;
  int? children;
  int? totalGuests;
  num? price;
  num? offerPrice;
  Map<String, dynamic>? priceSummary;
  List<FreshupDateDetail>? dateDetails;

  FreshupBookingDetails({
    this.checkin,
    this.slots,
    this.days,
    this.adults,
    this.children,
    this.totalGuests,
    this.price,
    this.offerPrice,
    this.priceSummary,
    this.dateDetails,
  });

  factory FreshupBookingDetails.fromJson(Map<String, dynamic> json) {
    print('🔍 Parsing booking_details JSON: ${json.toString()}');

    // Helper function to safely parse numeric values
    num? parseNum(dynamic value) {
      if (value == null) return null;
      if (value is num) return value;
      if (value is String) return num.tryParse(value);
      return null;
    }

    int? parseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is num) return value.toInt();
      if (value is String) return int.tryParse(value);
      return null;
    }

    final parsedPrice = parseNum(json['price']);
    final parsedOfferPrice = parseNum(json['offer_price']);
    print('🔍 Parsed values: price=$parsedPrice, offerPrice=$parsedOfferPrice');

    return FreshupBookingDetails(
      checkin: json['checkin'],
      slots: parseInt(json['slots']),
      days: parseInt(json['days']),
      adults: parseInt(json['adults']),
      children: parseInt(json['children']),
      totalGuests: parseInt(json['total_guests']),
      price: parsedPrice,
      offerPrice: parsedOfferPrice,
      priceSummary: json['price_summary'],
      dateDetails: json['date_details'] != null
          ? List<FreshupDateDetail>.from(
              json['date_details'].map((x) => FreshupDateDetail.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checkin': checkin,
      'slots': slots,
      'days': days,
      'adults': adults,
      'children': children,
      'total_guests': totalGuests,
      'price': price,
      'offer_price': offerPrice,
      'price_summary': priceSummary,
      'date_details': dateDetails?.map((x) => x.toJson()).toList(),
    };
  }
}

class FreshupDateDetail {
  String? slotId;
  String? date;
  num? basePrice;
  num? offerPrice;
  bool? isAvailable;
  int? availableQuantity;
  dynamic availableSpace;

  FreshupDateDetail({
    this.slotId,
    this.date,
    this.basePrice,
    this.offerPrice,
    this.isAvailable,
    this.availableQuantity,
    this.availableSpace,
  });

  factory FreshupDateDetail.fromJson(Map<String, dynamic> json) {
    // Helper function to safely parse numeric values
    num? parseNum(dynamic value) {
      if (value == null) return null;
      if (value is num) return value;
      if (value is String) return num.tryParse(value);
      return null;
    }

    int? parseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is num) return value.toInt();
      if (value is String) return int.tryParse(value);
      return null;
    }

    return FreshupDateDetail(
      slotId: json['slot_id'],
      date: json['date'],
      basePrice: parseNum(json['base_price']),
      offerPrice: parseNum(json['offer_price']),
      isAvailable: json['is_available'],
      availableQuantity: parseInt(json['available_quantity']),
      availableSpace: json['available_space'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slot_id': slotId,
      'date': date,
      'base_price': basePrice,
      'offer_price': offerPrice,
      'is_available': isAvailable,
      'available_quantity': availableQuantity,
      'available_space': availableSpace,
    };
  }
}
