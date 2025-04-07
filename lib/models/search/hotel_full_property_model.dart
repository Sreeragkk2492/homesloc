class HotelFullPropertyModel {
  final String? basePropertyPrice;
  final String? maxPropertyPrice;
  final int? maxPerson;
  final String? mealOption;
  final bool? smokingAllowed;
  final String? offerPrice;
  final List<Amenity>? amenityIds;
  final List<Room>? rooms;
  final List<String>? images;
  final HotelDetails? hotelDetails;

  HotelFullPropertyModel({
    this.basePropertyPrice,
    this.maxPropertyPrice,
    this.maxPerson,
    this.mealOption,
    this.smokingAllowed,
    this.offerPrice,
    this.amenityIds,
    this.rooms,
    this.images,
    this.hotelDetails,
  });

  factory HotelFullPropertyModel.fromJson(Map<String, dynamic> json) {
    return HotelFullPropertyModel(
      basePropertyPrice: json['base_property_price']?.toString(),
      maxPropertyPrice: json['max_property_price']?.toString(),
      maxPerson: json['max_person']?.toInt(),
      mealOption: json['meal_option']?.toString(),
      smokingAllowed: json['smoking_allowed'] as bool?,
      offerPrice: json['offer_price']?.toString(),
      amenityIds: json['amenity_ids'] != null
          ? List<Amenity>.from(json['amenity_ids'].map((x) => Amenity.fromJson(x)))
          : null,
      rooms: json['rooms'] != null
          ? List<Room>.from(json['rooms'].map((x) => Room.fromJson(x)))
          : null,
      images: json['images'] != null
          ? List<String>.from(json['images'].map((x) => x.toString()))
          : null,
      hotelDetails: json['hotel_details'] != null
          ? HotelDetails.fromJson(json['hotel_details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'base_property_price': basePropertyPrice,
      'max_property_price': maxPropertyPrice,
      'max_person': maxPerson,
      'meal_option': mealOption,
      'smoking_allowed': smokingAllowed,
      'offer_price': offerPrice,
      'amenity_ids': amenityIds?.map((x) => x.toJson()).toList(),
      'rooms': rooms?.map((x) => x.toJson()).toList(),
      'images': images,
      'hotel_details': hotelDetails?.toJson(),
    };
  }
}

class Amenity {
  final String? id;
  final String? name;
  final String? description;

  Amenity({
    this.id,
    this.name,
    this.description,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      description: json['description']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

class Room {
  final int? totalPropertyRooms;
  final String? roomName;
  final int? quantity;
  final String? roomType;
  final String? bedType;
  final int? roomSize;
  final String? description;
  final List<String>? roomImages;
  final List<String>? roomVideos;

  Room({
    this.totalPropertyRooms,
    this.roomName,
    this.quantity,
    this.roomType,
    this.bedType,
    this.roomSize,
    this.description,
    this.roomImages,
    this.roomVideos,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      totalPropertyRooms: json['total_property_rooms']?.toInt(),
      roomName: json['room_name']?.toString(),
      quantity: json['quantity']?.toInt(),
      roomType: json['room_type']?.toString(),
      bedType: json['bed_type']?.toString(),
      roomSize: json['room_size']?.toInt(),
      description: json['description']?.toString(),
      roomImages: json['room_images'] != null
          ? List<String>.from(json['room_images'].map((x) => x.toString()))
          : null,
      roomVideos: json['room_videos'] != null
          ? List<String>.from(json['room_videos'].map((x) => x.toString()))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_property_rooms': totalPropertyRooms,
      'room_name': roomName,
      'quantity': quantity,
      'room_type': roomType,
      'bed_type': bedType,
      'room_size': roomSize,
      'description': description,
      'room_images': roomImages,
      'room_videos': roomVideos,
    };
  }
}

class HotelDetails {
  final String? id;
  final String? name;
  final String? hotelType;
  final int? starRating;
  final int? totalRooms;
  final String? roomType;
  final String? chanelManagerName;
  final String? description;
  final String? email;
  final String? phoneNumber;
  final String? country;
  final String? state;
  final String? city;
  final String? address;
  final String? postcode;
  final bool? termsandcondition;
  final String? location;
  final String? checkInTime;
  final String? checkOutTime;
  final bool? cancellation;
  final dynamic startingRange;
  final dynamic endingRange;
  final String? latitude;
  final String? longitude;
  final List<NearByAttraction>? nearByAttraction;
  final int? yearBuild;
  final int? yearRenovated;
  final List<dynamic>? awards;
  final List<Amenity>? amenities;
  final String? coverImageUrl;
  final List<String>? galleryImages;
  final List<String>? videos;
  final bool? isFullProperty;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<FullProperty>? fullProperty;
  final Policies? policies;
  final LegalPolicies? legalPolicies;

  HotelDetails({
    this.id,
    this.name,
    this.hotelType,
    this.starRating,
    this.totalRooms,
    this.roomType,
    this.chanelManagerName,
    this.description,
    this.email,
    this.phoneNumber,
    this.country,
    this.state,
    this.city,
    this.address,
    this.postcode,
    this.termsandcondition,
    this.location,
    this.checkInTime,
    this.checkOutTime,
    this.cancellation,
    this.startingRange,
    this.endingRange,
    this.latitude,
    this.longitude,
    this.nearByAttraction,
    this.yearBuild,
    this.yearRenovated,
    this.awards,
    this.amenities,
    this.coverImageUrl,
    this.galleryImages,
    this.videos,
    this.isFullProperty,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.fullProperty,
    this.policies,
    this.legalPolicies,
  });

  factory HotelDetails.fromJson(Map<String, dynamic> json) {
    return HotelDetails(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      hotelType: json['hotel_type']?.toString(),
      starRating: json['star_rating']?.toInt(),
      totalRooms: json['total_rooms']?.toInt(),
      roomType: json['room_type']?.toString(),
      chanelManagerName: json['chanel_manager_name']?.toString(),
      description: json['description']?.toString(),
      email: json['email']?.toString(),
      phoneNumber: json['phone_number']?.toString(),
      country: json['country']?.toString(),
      state: json['state']?.toString(),
      city: json['city']?.toString(),
      address: json['address']?.toString(),
      postcode: json['postcode']?.toString(),
      termsandcondition: json['termsandcondition'] as bool?,
      location: json['location']?.toString(),
      checkInTime: json['check_in_time']?.toString(),
      checkOutTime: json['check_out_time']?.toString(),
      cancellation: json['cancellation'] as bool?,
      startingRange: json['starting_range'],
      endingRange: json['ending_range'],
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      nearByAttraction: json['near_by_attraction'] != null
          ? List<NearByAttraction>.from(
              json['near_by_attraction'].map((x) => NearByAttraction.fromJson(x)))
          : null,
      yearBuild: json['year_build']?.toInt(),
      yearRenovated: json['year_renovated']?.toInt(),
      awards: json['awards'] != null
          ? List<dynamic>.from(json['awards'].map((x) => x))
          : null,
      amenities: json['amenities'] != null
          ? List<Amenity>.from(
              json['amenities'].map((x) => Amenity.fromJson(x)))
          : null,
      coverImageUrl: json['cover_image_url']?.toString(),
      galleryImages: json['gallery_images'] != null
          ? List<String>.from(json['gallery_images'].map((x) => x.toString()))
          : null,
      videos: json['videos'] != null
          ? List<String>.from(json['videos'].map((x) => x.toString()))
          : null,
      isFullProperty: json['is_full_property'] as bool?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      fullProperty: json['full_property'] != null
          ? List<FullProperty>.from(
              json['full_property'].map((x) => FullProperty.fromJson(x)))
          : null,
      policies: json['policies'] != null
          ? Policies.fromJson(json['policies'])
          : null,
      legalPolicies: json['legal_policies'] != null
          ? LegalPolicies.fromJson(json['legal_policies'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hotel_type': hotelType,
      'star_rating': starRating,
      'total_rooms': totalRooms,
      'room_type': roomType,
      'chanel_manager_name': chanelManagerName,
      'description': description,
      'email': email,
      'phone_number': phoneNumber,
      'country': country,
      'state': state,
      'city': city,
      'address': address,
      'postcode': postcode,
      'termsandcondition': termsandcondition,
      'location': location,
      'check_in_time': checkInTime,
      'check_out_time': checkOutTime,
      'cancellation': cancellation,
      'starting_range': startingRange,
      'ending_range': endingRange,
      'latitude': latitude,
      'longitude': longitude,
      'near_by_attraction': nearByAttraction?.map((x) => x.toJson()).toList(),
      'year_build': yearBuild,
      'year_renovated': yearRenovated,
      'awards': awards,
      'amenities': amenities?.map((x) => x.toJson()).toList(),
      'cover_image_url': coverImageUrl,
      'gallery_images': galleryImages,
      'videos': videos,
      'is_full_property': isFullProperty,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'full_property': fullProperty?.map((x) => x.toJson()).toList(),
      'policies': policies?.toJson(),
      'legal_policies': legalPolicies?.toJson(),
    };
  }
}

class NearByAttraction {
  final String? name;
  final String? distance;
  final String? description;

  NearByAttraction({
    this.name,
    this.distance,
    this.description,
  });

  factory NearByAttraction.fromJson(Map<String, dynamic> json) {
    return NearByAttraction(
      name: json['name']?.toString(),
      distance: json['distance']?.toString(),
      description: json['description']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'distance': distance,
      'description': description,
    };
  }
}

class FullProperty {
  final String? id;
  final int? maxPerson;
  final String? basePropertyPrice;
  final String? offerPrice;

  FullProperty({
    this.id,
    this.maxPerson,
    this.basePropertyPrice,
    this.offerPrice,
  });

  factory FullProperty.fromJson(Map<String, dynamic> json) {
    return FullProperty(
      id: json['id']?.toString(),
      maxPerson: json['max_person']?.toInt(),
      basePropertyPrice: json['base_property_price']?.toString(),
      offerPrice: json['offer_price']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'max_person': maxPerson,
      'base_property_price': basePropertyPrice,
      'offer_price': offerPrice,
    };
  }
}

class Policies {
  final String? id;
  final String? checkInTime;
  final String? checkOutTime;
  final List<String>? acceptableIdentityProof;
  final String? cancellationPolicy;
  final bool? outsideVisitorAllowed;
  final bool? partiesOrEventsAllowed;
  final bool? extraBedPolicy;
  final String? extraBedRate;
  final MealRates? mealRates;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Policies({
    this.id,
    this.checkInTime,
    this.checkOutTime,
    this.acceptableIdentityProof,
    this.cancellationPolicy,
    this.outsideVisitorAllowed,
    this.partiesOrEventsAllowed,
    this.extraBedPolicy,
    this.extraBedRate,
    this.mealRates,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Policies.fromJson(Map<String, dynamic> json) {
    return Policies(
      id: json['id']?.toString(),
      checkInTime: json['checkInTime']?.toString(),
      checkOutTime: json['checkOutTime']?.toString(),
      acceptableIdentityProof: json['acceptableIdentityProof'] != null
          ? List<String>.from(json['acceptableIdentityProof'].map((x) => x.toString()))
          : null,
      cancellationPolicy: json['cancellationPolicy']?.toString(),
      outsideVisitorAllowed: json['outsideVisitorAllowed'] as bool?,
      partiesOrEventsAllowed: json['partiesOrEventsAllowed'] as bool?,
      extraBedPolicy: json['extraBedPolicy'] as bool?,
      extraBedRate: json['extraBedRate']?.toString(),
      mealRates: json['mealRates'] != null
          ? MealRates.fromJson(json['mealRates'])
          : null,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'acceptableIdentityProof': acceptableIdentityProof,
      'cancellationPolicy': cancellationPolicy,
      'outsideVisitorAllowed': outsideVisitorAllowed,
      'partiesOrEventsAllowed': partiesOrEventsAllowed,
      'extraBedPolicy': extraBedPolicy,
      'extraBedRate': extraBedRate,
      'mealRates': mealRates?.toJson(),
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class MealRates {
  final int? breakfast;
  final int? lunch;
  final int? dinner;

  MealRates({
    this.breakfast,
    this.lunch,
    this.dinner,
  });

  factory MealRates.fromJson(Map<String, dynamic> json) {
    return MealRates(
      breakfast: json['breakfast']?.toInt(),
      lunch: json['lunch']?.toInt(),
      dinner: json['dinner']?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
    };
  }
}

class LegalPolicies {
  final String? id;
  final String? ownershipType;
  final String? panCardDetails;
  final String? gstDetails;
  final BankAccountDetails? bankAccountDetails;
  final String? propertyRestrictions;
  final List<String>? registrationDocument;
  final List<String>? documentImageUrl;
  final List<String>? videos;
  final bool? isActive;

  LegalPolicies({
    this.id,
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

  factory LegalPolicies.fromJson(Map<String, dynamic> json) {
    return LegalPolicies(
      id: json['id']?.toString(),
      ownershipType: json['ownershipType']?.toString(),
      panCardDetails: json['panCardDetails']?.toString(),
      gstDetails: json['gstDetails']?.toString(),
      bankAccountDetails: json['bankAccountDetails'] != null
          ? BankAccountDetails.fromJson(json['bankAccountDetails'])
          : null,
      propertyRestrictions: json['propertyRestrictions']?.toString(),
      registrationDocument: json['registrationDocument'] != null
          ? List<String>.from(json['registrationDocument'].map((x) => x.toString()))
          : null,
      documentImageUrl: json['document_image_url'] != null
          ? List<String>.from(json['document_image_url'].map((x) => x.toString()))
          : null,
      videos: json['videos'] != null
          ? List<String>.from(json['videos'].map((x) => x.toString()))
          : null,
      isActive: json['is_active'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownershipType': ownershipType,
      'panCardDetails': panCardDetails,
      'gstDetails': gstDetails,
      'bankAccountDetails': bankAccountDetails?.toJson(),
      'propertyRestrictions': propertyRestrictions,
      'registrationDocument': registrationDocument,
      'document_image_url': documentImageUrl,
      'videos': videos,
      'is_active': isActive,
    };
  }
}

class BankAccountDetails {
  final String? accountNumber;
  final String? ifscCode;
  final String? bankName;
  final String? accountHolderName;

  BankAccountDetails({
    this.accountNumber,
    this.ifscCode,
    this.bankName,
    this.accountHolderName,
  });

  factory BankAccountDetails.fromJson(Map<String, dynamic> json) {
    return BankAccountDetails(
      accountNumber: json['account_number']?.toString(),
      ifscCode: json['ifsc_code']?.toString(),
      bankName: json['bank_name']?.toString(),
      accountHolderName: json['account_holder_name']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_number': accountNumber,
      'ifsc_code': ifscCode,
      'bank_name': bankName,
      'account_holder_name': accountHolderName,
    };
  }
}
