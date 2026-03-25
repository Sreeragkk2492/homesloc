class ApiConstant {
  //this is the base url
  static String BASE_URL = "https://homesloc.qhance.com";

  //auth
  static String LOGIN_URL = "/api/v1/auth/login";
  static String REGISTER_USER_URL = "/api/v1/auth/register-with-services";
  static String Verify_EMAIL_URL = "/api/v1/auth/send-verification-email";
  static String Verify_OTP_URL = "/api/v1/auth/verify-email-otp";
  static String REFRESH_TOKEN_URL = "/api/v1/auth/refresh";
  static String REQUEST_PASSWORD_RESET_URL =
      "/api/v1/auth/request-password-reset";
  static String RESET_PASSWORD_WITH_TOKEN_URL =
      "/api/v1/auth/reset-password-with-token";
  static String GOOGLE_AUTH_URL = "/api/v1/auth/google";

  //homescreen
  static String HOME_SCREEN_URL = "/api/v1/mobile/homepage";

  //search
  static String HOTEL_SEARCH_URL = "/api/v1/mobile/search/hotels";
  static String HOTEL_FULLPROPERTY_ROOM_URL =
      "/api/v1/search/accommodations-grouped-by-hotel";
  static String HOTEL_ROOM_DETAILS = "/api/v1/search/rooms";
  static String HOTEL_FULLPROPERTY_DETAILS = "/api/v1/search/full-properties";
  static String HOTEL_ROOM_AVAILABILITY = "/api/v1/search/room-search";
  static String HOTEL_FULLPROPERTY_AVAILABILITY =
      "https://homesloc.qhance.com/api/v1/search/full-property-search";

  static String HALL_SEARCH_URL =
      "/api/v1/search/event-accommodations-grouped-by-hall";
  static String HALL_DETAILS_URL = "/api/v1/search/search/Banquet-Hall/";
  static String HALL_AVAILABILITY_URL = "/api/v1/search/event-search";

  static String FRESHUP_SEARCH_URL = "/api/v1/search/accommodations/freshup";
  static String FRESHUP_DETAILS_URL = "/api/v1/search/freshup-room/";
  static String FRESHUP_AVAILABILITY_URL = "/api/v1/search/freshup-search";

  static String TOURISM_SEARCH_URL = "/api/v1/search/tourism-accommodations";
  static String TOURISM_DETAILS_URL = "/api/v1/search/tourism-packages/";
  static String TOURISM_AVAILABILITY_URL =
      "/api/v1/search/tourism-package-search";

  static String LOCATION_AUTOCOMPLETE_URL =
      "/api/v1/search/location-autocomplete";

  //hotel details
  static String HOTEL_DETAILS_URL = "/api/v1/mobile/hotel";

  //booking
  static String BOOKING_URL = "/api/v1/bookings/new";
  static const String HOTEL_BOOKING_HISTORY_URL = '/hotel/bookings/history';
  static const String PROFILE_URL = '/api/v1/users/profile';

  // Razorpay
  static const String RAZORPAY_TEST_KEY = "rzp_live_a4Z4SMNTQ4azeb";
  static const String RAZORPAY_CREATE_ORDER_URL =
      "/api/v1/bookings/razorpay/create-order";
}
