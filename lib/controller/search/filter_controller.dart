import 'package:get/get.dart';

class FilterController extends GetxController {
  final RxBool showAllAmenities = false.obs;
  final RxnInt starRating = RxnInt();

  // Freshup specific filters
  final RxMap<String, bool> freshupType = {
    'Single': false,
    'Double': false,
    'Suite': false,
  }.obs;

  final RxMap<String, bool> priceMethod = {
    'Per Head': false,
    'Per Room': false,
  }.obs;

  // Banquet Hall specific filters
  final RxBool showAllVenueTypes = false.obs;

  final RxMap<String, bool> venueType = {
    'Banquet Hall': false,
    'Conference Room': false,
    'Lawn': false,
    'Auditorium': false,
    'Restaurant': false,
    'Rooftop': false,
  }.obs;

  final RxMap<String, bool> spaceType = {
    'Indoor': false,
    'Outdoor': false,
  }.obs;

  // Tourism specific filters
  final RxMap<String, bool> packageType = {
    'Tourism Packages': false,
    'Adventure Tourism': false,
    'Wedding Tourism': false,
  }.obs;

  List<String> get displayedVenueTypes {
    if (showAllVenueTypes.value) {
      return venueType.keys.toList();
    } else {
      return venueType.keys.take(4).toList(); // Show top 4 initially
    }
  }

  void toggleShowAllVenueTypes() {
    showAllVenueTypes.value = !showAllVenueTypes.value;
  }

  final RxMap<String, bool> amenities = {
    'Gym': false,
    'FITNESS': false,
    'swimming pool': false,
    'Dj party': false,
    'TV': false,
    'Private Beach': false,
    'Free cancellation': false,
    'Breakfast included': false,
    'Fitness Center': false,
    'Luggage Storage': false,
    'Pet-Friendly Services': false,
    'Children\'s Play Area': false,
    'Laundry & Dry Cleaning Service': false,
    'Daily Housekeeping': false,
    'Café or Coffee Shop': false,
    'Wi-Fi': false,
    'Business Center': false,
    'Concierge Service': false,
    'Multi-Lingual Staff': false,
    'Lobby Seating Area': false,
  }.obs;

  List<String> get displayedAmenities {
    if (showAllAmenities.value) {
      return amenities.keys.toList();
    } else {
      return amenities.keys.take(10).toList(); // Show top 10 initially
    }
  }

  void toggleShowAllAmenities() {
    showAllAmenities.value = !showAllAmenities.value;
  }

  void setStarRating(int rating) {
    starRating.value = rating;
  }

  String? get apiFreshupType {
    final types = freshupType.entries
        .where((e) => e.value)
        .map((e) => e.key.toUpperCase())
        .toList();
    if (types.isEmpty) return null;
    return types.join(',');
  }

  String? get apiPriceMethod {
    final methods = priceMethod.entries.where((e) => e.value).map((e) {
      if (e.key == 'Per Head') return 'PER_HEAD';
      if (e.key == 'Per Room') return 'PER_ROOM';
      return e.key;
    }).toList();
    if (methods.isEmpty) return null;
    return methods.join(',');
  }

  String? get apiVenueType {
    final types = venueType.entries
        .where((e) => e.value)
        .map((e) => e.key.toUpperCase().replaceAll(' ', '_'))
        .toList();
    if (types.isEmpty) return null;
    return types.join(',');
  }

  String? get apiSpaceType {
    final types = spaceType.entries
        .where((e) => e.value)
        .map((e) => e.key.toUpperCase())
        .toList();
    if (types.isEmpty) return null;
    return types.join(',');
  }

  String? get apiPackageType {
    final types =
        packageType.entries.where((e) => e.value).map((e) => e.key).toList();
    if (types.isEmpty) return null;
    return types.join(',');
  }

  final RxnString accommodationType = RxnString();
  final RxnString selectedPropertyType = RxnString();
  final RxnString roomType = RxnString();

  final RxList<String> selectedFilters = <String>[].obs;

  String? get apiAccommodationType {
    if (accommodationType.value == 'Full Property') {
      return 'FULL_PROPERTY';
    } else if (accommodationType.value == 'Room Wise') {
      return 'ROOM_WISE';
    }
    return null;
  }

  void toggleFilter(String category, String key) {
    if (category == 'Amenities') {
      amenities[key] = !(amenities[key] ?? false);
    } else if (category == 'FreshupType') {
      freshupType[key] = !(freshupType[key] ?? false);
    } else if (category == 'PriceMethod') {
      priceMethod[key] = !(priceMethod[key] ?? false);
    } else if (category == 'VenueType') {
      venueType[key] = !(venueType[key] ?? false);
    } else if (category == 'SpaceType') {
      spaceType[key] = !(spaceType[key] ?? false);
    } else if (category == 'PackageType') {
      packageType[key] = !(packageType[key] ?? false);
    }
  }

  void setAccommodationType(String type) {
    accommodationType.value = type;
  }

  void setPropertyType(String type) {
    selectedPropertyType.value = type;
  }

  void setRoomType(String type) {
    roomType.value = type;
  }

  void removeSelectedFilter(String filter) {
    selectedFilters.remove(filter);
  }

  void clearAllFilters() {
    amenities.forEach((key, value) {
      amenities[key] = false;
    });
    accommodationType.value = null;
    selectedPropertyType.value = null;
    roomType.value = null;
    starRating.value = null;
    showAllAmenities.value = false;
    freshupType.forEach((key, value) {
      freshupType[key] = false;
    });
    priceMethod.forEach((key, value) {
      priceMethod[key] = false;
    });
    venueType.forEach((key, value) {
      venueType[key] = false;
    });
    spaceType.forEach((key, value) {
      spaceType[key] = false;
    });
    packageType.forEach((key, value) {
      packageType[key] = false;
    });
    showAllVenueTypes.value = false;
    selectedFilters.clear();
  }
}
