import 'package:homesloc/models/home/homescreen_model.dart';
import 'package:homesloc/core/dummy_data/dummy_data.dart';

class HomeScreenService {
  Future<HomescreenModel?> fetchHomeScreenData(int limit) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      return DummyData.homeScreenModel;
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
}
