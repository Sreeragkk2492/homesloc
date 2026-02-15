import 'package:homesloc/models/freshup/freshup_availability_model.dart';

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
  });

  factory FreshupDetailModel.fromJson(Map<String, dynamic> json) {
    return FreshupDetailModel(
      freshupId: json["freshup_id"],
      freshupName: json["freshup_name"],
      freshupType: json["freshup_type"],
      bedType: json["bed_type"],
      availableRooms: (json["available_rooms"] as num?)?.toInt(),
      maxPerson: (json["max_person"] as num?)?.toInt(),
      roomSize: json["room_size"],
      freshupDescription: json["freshup_description"],
      smokingAllowed: json["smoking_allowed"],
      bathroomAttached: json["bathroom_attached"],
      priceMethod: json["price_method"],
      slots: json["slots"] == null
          ? []
          : List<FreshupSlot>.from(
              json["slots"]!.map((x) => FreshupSlot.fromJson(x))),
      amenities: json["amenities"] == null
          ? []
          : List<FreshupAmenity>.from(
              json["amenities"]!.map((x) => FreshupAmenity.fromJson(x))),
    );
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
        "slots": slots == null
            ? []
            : List<dynamic>.from(slots!.map((x) => x.toJson())),
        "amenities": amenities == null
            ? []
            : List<dynamic>.from(amenities!.map((x) => x.toJson())),
      };
}
