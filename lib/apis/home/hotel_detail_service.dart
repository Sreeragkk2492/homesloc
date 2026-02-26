import 'dart:convert';
import 'package:homesloc/models/home/hall_detail_model.dart';
import 'package:homesloc/models/home/hall_availability_model.dart';
import 'package:homesloc/models/freshup/freshup_availability_model.dart';
import 'package:homesloc/core/api/api_helper.dart';
import 'package:homesloc/core/constant/api_constant.dart';
import 'package:homesloc/models/freshup/freshup_booking_availability_model.dart';
import 'package:homesloc/models/home/hotel_detail_model.dart';
import 'package:homesloc/models/booking/room_availability_model.dart';

class HotelDetailService {
  Future<HotelDetailModel?> fetchHotelDetails(String hotelId) async {
    try {
      final uri = Uri.parse(
          "${ApiConstant.BASE_URL}${ApiConstant.HOTEL_DETAILS_URL}/$hotelId");

      final response = await ApiHelper.get(
        uri,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return HotelDetailModel.fromJson(data);
      } else {
        print('Failed to load hotel details: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching hotel details: $e');
      return null;
    }
  }

  Future<HotelDetailModel?> fetchRoomDetails({
    required String roomId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final uri = Uri.parse(
          "${ApiConstant.BASE_URL}${ApiConstant.HOTEL_ROOM_DETAILS}/$roomId?start_date=$startDate&end_date=$endDate");

      final response = await ApiHelper.get(
        uri,
      );

      print('Room Details Response Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return HotelDetailModel.fromRoomJson(data);
      } else {
        print('Failed to load room details: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching room details: $e');
      return null;
    }
  }

  Future<HotelDetailModel?> fetchFullPropertyDetails({
    required String propertyId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final uri = Uri.parse(
          "${ApiConstant.BASE_URL}${ApiConstant.HOTEL_FULLPROPERTY_DETAILS}/$propertyId?start_date=$startDate&end_date=$endDate");

      final response = await ApiHelper.get(
        uri,
      );

      print('Full Property Details Response Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return HotelDetailModel.fromFullPropertyJson(data);
      } else {
        print('Failed to load full property details: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching full property details: $e');
      return null;
    }
  }

  Future<RoomAvailabilityModel?> checkRoomAvailability({
    required String roomId,
    required String checkIn,
    required String checkOut,
    required int adults,
    required int children,
    required int rooms,
  }) async {
    try {
      final uri = Uri.parse(
          "${ApiConstant.BASE_URL}${ApiConstant.HOTEL_ROOM_AVAILABILITY}?room_id=$roomId&checkin=$checkIn&checkout=$checkOut&adults=$adults&children=$children&rooms=$rooms");

      print("Checking availability: $uri");
      final response = await ApiHelper.get(
        uri,
      );

      print('Room Availability Response Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return RoomAvailabilityModel.fromJson(data);
      } else {
        print('Failed to check room availability: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error checking room availability: $e');
      return null;
    }
  }

  Future<RoomAvailabilityModel?> checkFullPropertyAvailability({
    required String propertyId,
    required String checkIn,
    required String checkOut,
    required int adults,
    required int children,
  }) async {
    try {
      final uri = Uri.parse(
          "${ApiConstant.HOTEL_FULLPROPERTY_AVAILABILITY}?property_id=$propertyId&checkin=$checkIn&checkout=$checkOut&adults=$adults&children=$children");

      print("Checking full property availability: $uri");
      final response = await ApiHelper.get(
        uri,
      );

      print('Full Property Availability Response Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return RoomAvailabilityModel.fromJson(data);
      } else {
        print('Failed to check full property availability: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error checking full property availability: $e');
      return null;
    }
  }

  Future<HallDetailModel?> fetchHallDetails(String hallId) async {
    try {
      final uri = Uri.parse(
          "${ApiConstant.BASE_URL}${ApiConstant.HALL_DETAILS_URL}$hallId");

      print("Fetching hall details: $uri");
      final response = await ApiHelper.get(
        uri,
      );

      print('Hall Details Response Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return HallDetailModel.fromJson(data);
      } else {
        print('Failed to load hall details: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching hall details: $e');
      return null;
    }
  }

  // Check Hall Availability
  Future<HallAvailabilityModel?> checkHallAvailability({
    required String eventId,
    required String checkIn,
    required String checkOut,
  }) async {
    try {
      final queryParams = {
        'event_id': eventId,
        'checkin': checkIn,
        'checkout': checkOut,
      };

      final uri = Uri.parse(
              "${ApiConstant.BASE_URL}${ApiConstant.HALL_AVAILABILITY_URL}")
          .replace(queryParameters: queryParams);

      final response = await ApiHelper.get(
        uri,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return HallAvailabilityModel.fromJson(data);
      } else {
        print('Hall Availability Response Code: ${response.statusCode}');
        print('Failed to check Hall availability: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error checking Hall availability: $e');
      return null;
    }
  }

  // Check Freshup Availability
  Future<FreshupAvailabilityModel?> checkFreshupAvailability({
    required String freshupRoomId,
    required String priceMethod,
    required String date,
  }) async {
    try {
      final queryParams = {
        // 'freshup_room_id': freshupRoomId,
        'price_method': priceMethod,
        'date': date,
      };

      final uri = Uri.parse(
              "${ApiConstant.BASE_URL}${ApiConstant.FRESHUP_DETAILS_URL}$freshupRoomId")
          .replace(queryParameters: queryParams);

      final response = await ApiHelper.get(
        uri,
      );

      print('Freshup Availability Response Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return FreshupAvailabilityModel.fromJson(data);
      } else {
        print('Failed to check Freshup availability: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error checking Freshup availability: $e');
      return null;
    }
  }

  // Search Freshup Availability with more parameters
  Future<FreshupBookingAvailabilityModel?> searchFreshupAvailability({
    required List<String> slotIds,
    required String roomType,
    required String checkIn,
    required int adults,
    required int children,
  }) async {
    try {
      final queryParams = {
        'slot_ids': slotIds.join(','),
        'room_type': roomType,
        'checkin': checkIn,
        'adults': adults.toString(),
        'children': children.toString(),
      };

      final uri = Uri.parse(
              "${ApiConstant.BASE_URL}${ApiConstant.FRESHUP_AVAILABILITY_URL}")
          .replace(queryParameters: queryParams);

      final response = await ApiHelper.get(
        uri,
      );

      print('Freshup Search Availability Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Freshup Search Availability Body: ${response.body}');
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return FreshupBookingAvailabilityModel.fromJson(data);
      } else {
        print('Failed to search Freshup availability: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error searching Freshup availability: $e');
      return null;
    }
  }

  Future<bool> createNewBooking(List<dynamic> bookings) async {
    try {
      final uri =
          Uri.parse("${ApiConstant.BASE_URL}${ApiConstant.BOOKING_URL}");

      // Serialize bookings to JSON
      final body = jsonEncode(bookings.map((b) => b.toJson()).toList());

      final response = await ApiHelper.post(
        uri,
        body: body,
      );

      print('Booking Response Code: ${response.statusCode}');
      print('Booking Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error creating booking: $e');
      return false;
    }
  }
}
