import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationAutocompleteService {
  Future<List<String>> fetchSuggestions(String query) async {
    if (query.isEmpty) return [];

    try {
      final uri = Uri.parse(
          "https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5");
      final response = await http.get(uri, headers: {
        'Accept-Language': 'en',
        'User-Agent': 'homesloc_mobile_app', // Required by Nominatim policy
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        List<String> suggestions = [];

        for (var item in data) {
          final displayName = item['display_name'];
          if (displayName != null) {
            // Trim down exactly how they look on the web app: 'Munnar, Kerala, India' instead of 10 line long addresses
            final parts = displayName.toString().split(', ');
            if (parts.length > 3) {
              // Usually the first is the specific place, second to last is state, last is country
              suggestions.add(
                  "${parts[0]}, ${parts[parts.length - 2]}, ${parts.last}");
            } else {
              suggestions.add(displayName.toString());
            }
          }
        }

        // Remove exact duplicates that might happen after trimming
        return suggestions.toSet().toList();
      } else {
        print('Nominatim API error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Nominatim Error: $e');
      return [];
    }
  }
}
