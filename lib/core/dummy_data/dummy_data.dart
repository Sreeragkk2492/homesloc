import 'package:homesloc/models/auth/login_model.dart';
import 'package:homesloc/models/home/homescreen_model.dart';
import 'package:homesloc/models/search/search_hotel_model.dart';

class DummyData {
  static final LoginModel loginModel = LoginModel(
    accessToken: "dummy_access_token",
    refreshToken: "dummy_refresh_token",
    tokenType: "Bearer",
    userId: "user_123",
    username: "Test User",
    userType: "customer",
    message: "Login Successful",
  );

  static final HomescreenModel homeScreenModel = HomescreenModel(
    bestHotels: [
      BestHotel(
        id: "hotel_1",
        name: "Grand Luxury Resort",
        coverImageUrl: "assets/images/l1.png",
        starRating: 5,
        location: "Maldives",
        city: "Male",
        pricing: Pricing(bestPrice: "250"),
        rating: 4.8,
        reviewCount: 120,
        description:
            "Experience world-class service at Grand Luxury Resort. Featuring overwater villas, private pools, and pristine beaches.",
      ),
      BestHotel(
        id: "hotel_2",
        name: "Mountain View Lodge",
        coverImageUrl: "assets/images/m1.jpg",
        starRating: 4,
        location: "Swiss Alps",
        city: "Zermatt",
        pricing: Pricing(bestPrice: "180"),
        rating: 4.5,
        reviewCount: 85,
        description:
            "Cozy lodge with breathtaking views of the Matterhorn. Perfect for skiing and hiking enthusiasts.",
      ),
      BestHotel(
        id: "hotel_3",
        name: "Urban City Hotel",
        coverImageUrl: "assets/images/image (30).png",
        starRating: 4,
        location: "New York",
        city: "New York",
        pricing: Pricing(bestPrice: "300"),
        rating: 4.2,
        reviewCount: 200,
        description:
            "Modern hotel in the heart of Manhattan. Walking distance to Times Square and Central Park.",
      ),
    ],
    popularDestinations: [
      {
        "name": "Paris",
        "image":
            "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
      },
      {
        "name": "Tokyo",
        "image":
            "https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
      },
      {
        "name": "Dubai",
        "image":
            "https://images.unsplash.com/photo-1512453979798-5ea904ac6605?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
      },
    ],
    tourPackages: [],
    weddingPackages: [],
    banquetHalls: [],
    latestReviews: [],
  );

  static final SearchHotelModel searchHotelModel = SearchHotelModel(
    message: "Success",
    hotels: [
      Hotel(
        id: "search_hotel_1",
        name: "Sunshine Beach Resort",
        coverImageUrl:
            "https://images.unsplash.com/photo-1582719508461-905c673771fd?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
        starRating: 4,
        locationInfo: LocationInfo(city: "Goa", address: "Calangute Beach"),
        priceRange: PriceRange(min: "1500", max: "3000"),
        // rating: 4.3, // Hotel model might differ slightly, checking structure
      ),
      Hotel(
        id: "search_hotel_2",
        name: "Himalayan Retreat",
        coverImageUrl:
            "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
        starRating: 5,
        locationInfo: LocationInfo(city: "Manali", address: "Old Manali Road"),
        priceRange: PriceRange(min: "2500", max: "5000"),
      ),
      Hotel(
        id: "search_hotel_3",
        name: "City Comfort Inn",
        coverImageUrl:
            "https://images.unsplash.com/photo-1566665797739-1674de7a421a?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
        starRating: 3,
        locationInfo: LocationInfo(city: "Bangalore", address: "Indiranagar"),
        priceRange: PriceRange(min: "1200", max: "2500"),
      ),
    ],
    pagination: Pagination(
      totalCount: 3,
      currentPage: 1,
      totalPages: 1,
      hasNext: false,
      hasPrevious: false,
    ),
  );
}
