import 'package:homesloc/models/freshup/freshup_availability_model.dart';
import 'package:homesloc/models/home/hotel_detail_model.dart';

class FreshupDetailModel {
  String? freshupId;
  String? freshupName;
  String? freshupType;
  String? bedType;
  int? availableRooms;
  int? maxPerson;
  String? roomSize;
  String? freshupDescription;
  bool? smokingAllowed;
  bool? bathroomAttached;
  List<FreshupSlot>? slots;
  List<FreshupAmenity>? amenities;
  String? priceMethod;
  String? latitude;
  String? longitude;

  List<String>? roomImages;
  List<String>? nearbyAttractions;
  List<String>? accommodationPolicies;
  List<HotelRoom>? rooms;
  int? yearBuild;
  int? yearRenovated;
  String? phoneNumber;
  List<NearByAttraction>? nearbyAttractionObjects;

  // Structured Policy Fields
  String? acceptedTimeSlots;
  String? cancellationPolicy;
  int? cancellationDays;
  String? extraBedPolicy;
  String? extraBedPrice;
  List<String>? acceptableIdentityProof;
  List<String>? propertyRules;

  FreshupDetailModel({
    this.freshupId,
    this.freshupName,
    this.freshupType,
    this.bedType,
    this.availableRooms,
    this.maxPerson,
    this.roomSize,
    this.freshupDescription,
    this.smokingAllowed,
    this.bathroomAttached,
    this.slots,
    this.amenities,
    this.priceMethod,
    this.latitude,
    this.longitude,
    this.roomImages,
    this.nearbyAttractions,
    this.accommodationPolicies,
    this.acceptedTimeSlots,
    this.cancellationPolicy,
    this.cancellationDays,
    this.extraBedPolicy,
    this.extraBedPrice,
    this.acceptableIdentityProof,
    this.propertyRules,
    this.rooms,
    this.yearBuild,
    this.yearRenovated,
    this.phoneNumber,
    this.nearbyAttractionObjects,
  });

  factory FreshupDetailModel.fromJson(Map<String, dynamic> json) {
    var detailsObj = json["price_per_room"] ?? json["price_per_head"] ?? json;

    var model = FreshupDetailModel(
      freshupId: detailsObj["freshup_id"] ?? detailsObj["id"],
      freshupName: detailsObj["freshup_name"] ?? detailsObj["name"],
      freshupType: detailsObj["freshup_type"],
      bedType: detailsObj["bed_type"],
      availableRooms: (detailsObj["available_rooms"] as num?)?.toInt(),
      maxPerson: (detailsObj["max_person"] as num?)?.toInt(),
      roomSize: detailsObj["room_size"],
      freshupDescription:
          detailsObj["freshup_description"] ?? json["freshup_description"],
      smokingAllowed: detailsObj["smoking_allowed"] ?? json["smoking_allowed"],
      bathroomAttached:
          detailsObj["bathroom_attached"] ?? json["bathroom_attached"],
      priceMethod: json["price_method"] ?? detailsObj["price_method"],
      latitude: json["latitude"]?.toString(),
      longitude: json["longitude"]?.toString(),
      slots: detailsObj["slots"] == null
          ? []
          : List<FreshupSlot>.from(
              detailsObj["slots"]!.map((x) => FreshupSlot.fromJson(x))),
      amenities: detailsObj["amenities"] == null
          ? []
          : List<FreshupAmenity>.from(
              detailsObj["amenities"]!.map((x) => FreshupAmenity.fromJson(x))),
      // We'll populate these arrays after construction
      roomImages: [],
      nearbyAttractions: [],
      accommodationPolicies: [],
    );

    // Dynamic field population based on the actual detail API payload response

    // Handle room_images from price_per_room if exists
    if (json["price_per_room"] != null &&
        json["price_per_room"]["room_images"] != null) {
      model.roomImages =
          List<String>.from(json["price_per_room"]["room_images"]);
    } else if (json["room_images"] != null && json["room_images"] is List) {
      model.roomImages =
          List<String>.from(json["room_images"]!.map((x) => x.toString()));
    }

    // Merge Property details
    final propDetails = json["property_details"];
    if (propDetails != null) {
      if (propDetails["near_by_attraction"] != null &&
          propDetails["near_by_attraction"] is List) {
        final attractionsList = propDetails["near_by_attraction"] as List;
        List<String> formattedAttractions = [];
        for (var item in attractionsList) {
          if (item is Map) {
            final name = item["name"]?.toString() ?? "";
            final desc = item["description"]?.toString() ?? "";
            if (name.isNotEmpty) {
              formattedAttractions
                  .add(desc.isNotEmpty ? "$name - $desc" : name);
            }
          }
        }
        model.nearbyAttractions = formattedAttractions;
      }

      // Merge Policies
      final policies = propDetails["freshup_policies"];
      if (policies != null) {
        model.acceptedTimeSlots = policies["acceptedtimeslots"]?.toString();
        model.cancellationPolicy = policies["cancellationPolicy"]?.toString();
        model.cancellationDays =
            (policies["cancellationDays"] as num?)?.toInt();
        model.extraBedPolicy = policies["extraBedPolicy"]?.toString();
        model.extraBedPrice = policies["extra_bed_price"]?.toString();

        if (policies["acceptableIdentityProof"] != null &&
            policies["acceptableIdentityProof"] is List) {
          model.acceptableIdentityProof =
              List<String>.from(policies["acceptableIdentityProof"]);
        }

        if (policies["propertyrules"] != null) {
          model.propertyRules = policies["propertyrules"]
              .toString()
              .split('\n')
              .where((s) => s.trim().isNotEmpty)
              .toList();
        }

        // Maintain old accommodationPolicies list for backward compatibility
        List<String> policyStrings = [];
        if (model.propertyRules != null) {
          policyStrings.addAll(model.propertyRules!);
        }
        if (model.cancellationPolicy != null) {
          policyStrings.add("Cancellation: ${model.cancellationPolicy}");
        }
        if (model.cancellationDays != null) {
          policyStrings.add("Cancellation Days: ${model.cancellationDays}");
        }
        if (model.acceptedTimeSlots != null) {
          policyStrings.add("Accepted Time Slots: ${model.acceptedTimeSlots}");
        }
        if (model.extraBedPolicy != null) {
          policyStrings.add("Extra Bed Policy: ${model.extraBedPolicy}");
        }
        if (model.extraBedPrice != null) {
          policyStrings.add("Extra Bed Price: \u20B9${model.extraBedPrice}");
        }
        if (model.acceptableIdentityProof != null) {
          policyStrings.add(
              "Acceptable ID: ${model.acceptableIdentityProof!.join(', ')}");
        }
        model.accommodationPolicies = policyStrings;
      }

      // Merge other Property details from hotel_details or property_details
      final hotelDetails = json["hotel_details"] ?? propDetails;
      if (hotelDetails != null) {
        model.yearBuild = hotelDetails["year_build"];
        model.yearRenovated = hotelDetails["year_renovated"];
        model.phoneNumber = hotelDetails["phone_number"]?.toString();

        // Parse rooms from property_details.rooms (freshup API structure)
        if (hotelDetails["rooms"] != null && hotelDetails["rooms"] is List) {
          model.rooms = List<HotelRoom>.from(
              hotelDetails["rooms"].map((x) => HotelRoom.fromJson(x)));
        }

        // Parse nearby attractions as objects for horizontal card display
        if (hotelDetails["near_by_attraction"] != null &&
            hotelDetails["near_by_attraction"] is List) {
          model.nearbyAttractionObjects = List<NearByAttraction>.from(
              hotelDetails["near_by_attraction"]
                  .map((x) => NearByAttraction.fromJson(x)));
        }
      }

      // Secondary logic for backward compatibility if accommodationPolicies are directly provided
      if (model.accommodationPolicies == null ||
          model.accommodationPolicies!.isEmpty) {
        if (json["accommodation_policies"] != null &&
            json["accommodation_policies"] is List) {
          model.accommodationPolicies = List<String>.from(
              json["accommodation_policies"]!.map((x) => x.toString()));
        } else if (json["nearby_attractions"] != null &&
            json["nearby_attractions"] is List) {
          // Backward compatibility for nearbyAttractions array of strings
          model.nearbyAttractions = List<String>.from(
              json["nearby_attractions"]!.map((x) => x.toString()));
        }
      }
    }

    return model;
  }

  Map<String, dynamic> toJson() => {
        "freshup_id": freshupId,
        "freshup_name": freshupName,
        "freshup_type": freshupType,
        "bed_type": bedType,
        "available_rooms": availableRooms,
        "max_person": maxPerson,
        "room_size": roomSize,
        "freshup_description": freshupDescription,
        "smoking_allowed": smokingAllowed,
        "bathroom_attached": bathroomAttached,
        "price_method": priceMethod,
        "latitude": latitude,
        "longitude": longitude,
        "slots": slots == null
            ? []
            : List<dynamic>.from(slots!.map((x) => x.toJson())),
        "amenities": amenities == null
            ? []
            : List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "room_images": roomImages,
        "nearby_attractions": nearbyAttractions,
        "accommodation_policies": accommodationPolicies,
      };
}
