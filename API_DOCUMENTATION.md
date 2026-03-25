# Application API Documentation

**Base URL:** `https://homesloc.qhance.com`
**Current Status:** The application currently relies on a Mock Service layer (`DummyData`) in many places for development. The endpoints and models below are derived from the codebase configuration (`lib/core/constant/api_constant.dart`) and the data models (`lib/models/`).

---

## 1. Authentication

### Login
Authenticate a user and retrieve access tokens.

- **Endpoint:** `/api/v1/auth/login`
- **Method:** `POST`
- **Implementation:** `lib/apis/login/login_api.dart`

#### Request Body
| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `username` | String | Yes | User's identifier/email. |
| `password` | String | Yes | User's password. |

#### Response
**Model:** `LoginModel` (`lib/models/auth/login_model.dart`)

```json
{
  "access_token": "string",
  "refresh_token": "string",
  "token_type": "Bearer",
  "user_id": "string",
  "username": "string",
  "user_type": "string",
  "message": "string"
}
```

---

## 2. Home Screen

### Fetch Home Data
Retrieve aggregated data for the home screen including best hotels, packages, and destinations.

- **Endpoint:** `/api/v1/homepage/`
- **Method:** `GET`
- **Implementation:** `lib/apis/home/home_screen_api.dart`

#### Request Parameters
| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `limit` | int | Yes | Number of items to fetch (implied by service call). |

#### Response
**Model:** `HomescreenModel` (`lib/models/home/homescreen_model.dart`)

```json
{
  "best_hotels": [
    {
      "id": "string",
      "service_provider_id": "string",
      "name": "string",
      "hotel_type": "string",
      "star_rating": 0,
      "total_rooms": 0,
      "chanel_manager_name": "string",
      "description": "string",
      "email": "string",
      "phone_number": "string",
      "country": "string",
      "state": "string",
      "city": "string",
      "address": "string",
      "postcode": "string",
      "termsandcondition": true,
      "location": "string",
      "check_in_time": "string",
      "check_out_time": "string",
      "cancellation": true,
      "starting_range": "string",
      "ending_range": "string",
      "latitude": "string",
      "longitude": "string",
      "year_build": 0,
      "year_renovated": 0,
      "cover_image_url": "string",
      "is_active": true,
      "created_at": "datetime",
      "updated_at": "datetime",
      "rating": "dynamic",
      "review_count": 0,
      "room_types": [
        {
          "type": "string",
          "description": "dynamic",
          "capacity": 0
        }
      ],
      "near_by_attraction": [
        {
          "name": "string",
          "distance": "string",
          "description": "string"
        }
      ],
      "awards": [
        {
          "title": "string",
          "year": 0,
          "description": "string"
        }
      ],
      "amenities": ["dynamic"],
      "gallery_images": ["string"],
      "videos": ["string"],
      "rooms": [
        {
          "id": "string",
          "room_name": "string",
          "room_type": "string",
          "bed_type": "string",
          "max_person": 0,
          "meal_option": "string",
          "room_size": 0,
          "quantity": 0,
          "price": "string",
          "offer_price": "dynamic",
          "availability_status": "string",
          "description": "string",
          "room_images": ["string"],
          "amenities": [
            {
              "id": "string",
              "name": "string",
              "description": "string"
            }
          ]
        }
      ],
      "pricing": {
        "best_price": "string",
        "offer_price": "dynamic",
        "available_rooms": 0
      }
    }
  ],
  "tour_packages": [],
  "wedding_packages": [],
  "banquet_halls": [],
  "popular_destinations": [],
  "latest_reviews": []
}
```

---

## 3. Search

### Search Hotels
Search for hotels with various filters.

- **Endpoint:** `/api/v1/search/hotels`
- **Method:** `GET`
- **Implementation:** `lib/apis/search/search_hotel_api.dart`

#### Request Parameters
| Parameter | Type | Required | Default | Description |
| :--- | :--- | :--- | :--- | :--- |
| `name` | String | No | null | Search by name. |
| `location` | String | No | null | Search by location/city. |
| `checkIn` | String | No | null | e.g., "2024-01-01". |
| `checkOut` | String | No | null | e.g., "2024-01-02". |
| `guestCount` | int | No | null | Number of guests. |
| `minPrice` | int | No | null | Minimum price. |
| `maxPrice` | int | No | null | Maximum price. |
| `starRating` | int | No | null | e.g., 4 or 5. |
| `isActive` | bool | No | true | Filter active only. |
| `page` | int | No | 1 | Page number. |
| `pageSize` | int | No | 10 | Items per page. |
| `sortBy` | String | No | "created_at" | Sort field. |
| `sortOrder` | String | No | "desc" | "asc" or "desc". |

#### Response
**Model:** `SearchHotelModel` (`lib/models/search/search_hotel_model.dart`)

```json
{
  "message": "string",
  "hotels": [
    {
      "id": "string",
      "name": "string",
      "cover_image_url": "string",
      "star_rating": 0,
      "is_active": true,
      "is_full_property": false,
      "locationInfo": {
        "country": "India",
        "state": "Kerala",
        "city": "string",
        "address": "string",
        "postcode": "string",
        "latitude": "string",
        "longitude": "string",
        "termsandcondition": true
      },
      "price_range": {
        "min": "string",
        "max": "string"
      },
      "quick_info": {
        "total_rooms": 0,
        "amenities": [
          {
            "id": "string",
            "name": "string",
            "description": "string"
          }
        ]
      },
      "policies": {
        "checkInTime": "string",
        "checkOutTime": "string",
        "cancellationPolicy": "string",
        "mealRates": {
          "breakfast": "string",
          "lunch": "string",
          "dinner": "string"
        }
      },
      "legal_policies": {
         "ownershipType": "string",
         "panCardDetails": "string",
         "gstDetails": "string",
         "bankAccountDetails": {
             "account_number": "string",
             "ifsc_code": "string",
             "bank_name": "string",
             "account_holder_name": "string"
         }
      },
      "full_property": {
        "id": "string",
        "base_property_price": "string",
        "max_property_price": "string",
        "offer_price": "dynamic",
         "rooms": []
      },
      "rooms": [
        {
          "id": "string",
          "room_name": "string",
          "quantity": 0,
          "room_type": "string",
          "bed_type": "string",
          "max_person": 0,
          "price": "string",
          "room_size": 0,
          "description": "string",
          "room_images": ["string"]
        }
      ]
    }
  ],
  "pagination": {
    "total_count": 0,
    "current_page": 1,
    "total_pages": 1,
    "has_next": false,
    "has_previous": false
  }
}
```

---

## 4. Booking

**Status:** Client-side Only / Local Mock
There is currently **no backend API** connected for booking creation. All booking logic is handled locally within the Flutter application using `TripController` and `BookingModel`.

**Internal Model:** `BookingModel` (`lib/models/booking/booking_model.dart`)
Fields:
- `hotelName`: String
- `totalAmount`: double
- `numberOfNights`: int
- `checkInDate`: DateTime
- `checkOutDate`: DateTime
- `bookingStatus`: String (default: 'Active')

---

## 5. Object Details (UI View)

**Status:** Data Passing
The "Detailed View" screens (`lib/screens/detailed_view_screen/`) **do not** make separate API calls to fetch details by ID. Instead, they expect the full object (`BestHotel` from Home or `Hotel` from Search) to be passed via the constructor.

- **Data Source:** Home Screen API or Search API.
- **Implementation:** `DetailedViewScreen(hotel: ...)`
- **Note:** The UI checks the runtime type of the passed object (`BestHotel` vs `Hotel`) to conditionally extract fields like `phoneNumber` or `reviewCount`, which may differ between the two models.
