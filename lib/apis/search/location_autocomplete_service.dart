import 'dart:convert';
import 'package:homesloc/core/api/api_helper.dart';
import 'package:homesloc/core/constant/api_constant.dart';

class LocationAutocompleteService {
  Future<Iterable<String>> fetchSuggestions(String query) async {
    try {
      final uri = Uri.parse(
          ApiConstant.BASE_URL + ApiConstant.LOCATION_AUTOCOMPLETE_URL);

      // Log for debugging
      print('Fetching suggestions from: $uri');
      print('Payload: {"query": "$query", "types": "geocode"}');

      final payload = {
        "query": query,
        "types": "geocode",
      };

      final response = await ApiHelper.post(
        uri,
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        print('Location Autocomplete Success: ${jsonResponse['message']}');

        if (jsonResponse['suggestions'] != null &&
            jsonResponse['suggestions'] is List) {
          final List<dynamic> suggestions = jsonResponse['suggestions'];
          return suggestions
              .where((s) => s['value'] != null)
              .map((s) => s['value'].toString())
              .toList();
        }
      } else {
        print('Autocomplete API Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
      return const Iterable<String>.empty();
    } catch (e) {
      print('Error fetching location suggestions: $e');
      return const Iterable<String>.empty();
    }
  }
}
