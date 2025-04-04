import 'package:get/get.dart';

class FilterController extends GetxController {
  final RxList<String> selectedFilters = [
    'Location',
    '3 Star',
    'Balcony',
    'Pets Allowed',
    'Meals Included',
  ].obs;

  final RxMap<String, bool> popularFilters = {
    'Resorts': false,
    'Bar': true,
    '4 Star': false,
    'Breakfast': false,
    'Swimming Pool': true,
    'Campfire': true,
    'Pets Allowed': false,
  }.obs;

  final RxMap<String, bool> facilities = {
    'Parking': false,
    'Restaurant': true,
    'Room Service': false,
    'Swimming Pool': true,
    'Campfire': true,
    'Pets Allowed': false,
  }.obs;

  final RxMap<String, bool> roomFacilities = {
    'Private Bathroom': false,
    'Balcony': true,
    'Sea View': false,
    'Air Conditioning': true,
    'Kitchen': true,
    'Extra Pillow': false,
  }.obs;

  final RxMap<String, bool> propertyType = {
    'Hotels': false,
    'Resorts': true,
    'Villas': true,
    'Homestays': false,
    'Apartments': true,
    'Entire House': false,
  }.obs;

  final RxMap<String, bool> meals = {
    'Self Catering': false,
    'Breakfast Included': true,
    'Non-Veg Foods': false,
    'Meals Included': true,
    'All-Inclusive': false,
    'Veg Foods': true,
    'Breakfast & Lunch Included': true,
    'Breakfast & Dinner Included': false,
  }.obs;

  final RxMap<String, bool> rating = {
    '5 Star': false,
    '4 Star': true,
    '3 Star': false,
    '2 Star': true,
    'All-Inclusive': false,
  }.obs;

  final List<String> budgetRanges = [
    '1000-3000',
    '3000-8000',
    '8000-15000',
    '15000 +',
  ];

  void toggleFilter(String category, String key) {
    switch (category) {
      case 'Popular Filters':
        popularFilters[key] = !(popularFilters[key] ?? false);
        break;
      case 'Facilities':
        facilities[key] = !(facilities[key] ?? false);
        break;
      case 'Room Facilities':
        roomFacilities[key] = !(roomFacilities[key] ?? false);
        break;
      case 'Property Type':
        propertyType[key] = !(propertyType[key] ?? false);
        break;
      case 'Meals':
        meals[key] = !(meals[key] ?? false);
        break;
      case 'Rating':
        rating[key] = !(rating[key] ?? false);
        break;
    }
  }

  void removeSelectedFilter(String filter) {
    selectedFilters.remove(filter);
  }

  void clearAllFilters() {
    selectedFilters.clear();
  }
}