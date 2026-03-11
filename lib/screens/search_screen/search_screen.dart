// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/categorie_screen/categorie_screen.dart';
import 'package:homesloc/screens/detailed_view_screen/detailed_view_screen.dart';
import 'package:homesloc/screens/detailed_view_screen/freshup_detailed_view_screen.dart';
import 'package:homesloc/screens/detailed_view_screen/hall_detailed_view_screen.dart';
import 'package:homesloc/screens/detailed_view_screen/tourism_detailed_view_screen.dart';
import 'package:homesloc/screens/home/home_screen.dart';
import 'package:homesloc/core/controller/bottom_navigation_bar/new_navigation.dart';
import 'package:homesloc/core/widgets/logo.dart/second_logo.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/core/widgets/view_all_button/view_all_button.dart';
import 'package:homesloc/screens/search_screen/filter_screen/filter_screen.dart';

import 'package:homesloc/core/widgets/search_form/search_form.dart';
import 'package:homesloc/screens/home/widget/search_button.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/screens/home/widget/guest_dialog.dart';
import 'package:homesloc/animations/animated_content.dart';
import 'package:homesloc/core/controller/bottom_navigation_bar/bottom_bar_controller.dart';
import 'package:homesloc/core/widgets/loader/app_loader.dart';
import 'package:homesloc/core/utils/bottom_sheet_utils.dart';

import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:homesloc/controller/search/search_hotel_controller.dart';
import '../../controller/home/home_screen_controller.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> budgetRanges = ['1000-8000', '8000-15000', '15000+'];
  String? selectedRange;
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  // Get search data controller
  final searchDataController = Get.put(HomeScreenController());
  final calendarController = Get.put(CalendarController());
  final bottomBarController = Get.put(BottomBarController());
  final searchHotelController = Get.put(SearchHotelController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!searchHotelController.isLoadMore.value &&
          searchHotelController.hasMore.value) {
        bool hasResults =
            (searchHotelController.searchResult.value?.searchResults != null) ||
                (searchHotelController.tourismResult.value?.packages != null);
        if (hasResults && !searchHotelController.isLoading.value) {
          searchHotelController.searchHotels(isLoadMoreAction: true);
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: blue,
              automaticallyImplyLeading: false,
              pinned: false,
              floating: true,
              snap: true,
              title: Padding(
                padding: EdgeInsets.only(left: 90.w),
                child: SecondLog(),
              ),
              actions: [
                // Container(
                //   margin: EdgeInsets.only(right: 15.w, top: 8.h),
                //   width: 21.w,
                //   height: 21.h,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage(
                //             'assets/images/notifications-outline.png'),
                //         fit: BoxFit.cover),
                //   ),
                // ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    color: blue,
                    width: double.infinity,
                    height: 52.h,
                    child: Column(
                      children: [
                        AnimatedContent(
                            show: true,
                            leftToRight: 0.0,
                            topToBottom: 5.0,
                            time: 1500,
                            child: SearchForm()),
                      ],
                    ),
                  ),
                  Container(
                    height: 47.h,
                    width: MediaQuery.of(context).size.width,
                    color: blue,
                    child: Padding(
                      padding: EdgeInsets.only(left: 14.w, bottom: 9.h),
                      child: Row(
                        children: [
                          AnimatedContent(
                            leftToRight: 5.5,
                            topToBottom: 0.0,
                            time: 1500,
                            show: true,
                            child: Obx(() {
                              final isHall =
                                  searchHotelController.isGroupedByHall.value;
                              final isTourism =
                                  searchHotelController.isTourism.value ||
                                      searchHotelController
                                          .isAdventureTourism.value;
                              final expandDateBlock = isHall || isTourism;

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 30.h,
                                width: expandDateBlock
                                    ? 331.w
                                    : 221.w, // Expand dynamically
                                decoration: BoxDecoration(
                                  color: gblue,
                                  borderRadius: BorderRadius.circular(6.sp),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    _showCalendarBottomSheet(context);
                                  },
                                  child: Obx(() {
                                    final isHall = searchHotelController
                                        .isGroupedByHall.value;
                                    final isFreshup =
                                        searchHotelController.isFreshup.value;
                                    final isTourism =
                                        searchHotelController.isTourism.value ||
                                            searchHotelController
                                                .isAdventureTourism.value;
                                    final isSingleDate =
                                        isHall || isFreshup || isTourism;

                                    return Row(
                                      mainAxisAlignment: isSingleDate
                                          ? MainAxisAlignment.center
                                          : MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/images/Vector.png'),
                                          width: 15.w,
                                          height: 15.h,
                                        ),
                                        if (isSingleDate)
                                          SizedBox(
                                              width: 10
                                                  .w), // Added space after icon explicitly for single date modes
                                        Text(
                                          calendarController
                                                      .checkInDate.value !=
                                                  null
                                              ? calendarController
                                                  .formatDateShort(
                                                      calendarController
                                                          .checkInDate.value)
                                              : ((isHall || isTourism)
                                                  ? "Select Event Date"
                                                  : "Check in"),
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: poppinsFont,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                        if (!isSingleDate) ...[
                                          Text(
                                            "|",
                                            style: TextStyle(
                                              color: poppinsFont,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            calendarController
                                                        .checkOutDate.value !=
                                                    null
                                                ? calendarController
                                                    .formatDateShort(
                                                        calendarController
                                                            .checkOutDate.value)
                                                : "Checkout",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: poppinsFont,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w100,
                                            ),
                                          ),
                                        ],
                                      ],
                                    );
                                  }),
                                ),
                              );
                            }),
                          ),
                          Obx(() {
                            final isHall =
                                searchHotelController.isGroupedByHall.value;
                            final isTourism = searchHotelController
                                    .isTourism.value ||
                                searchHotelController.isAdventureTourism.value;
                            final hideGuests = isHall || isTourism;
                            if (hideGuests)
                              return const SizedBox
                                  .shrink(); // Hide guests for Halls and Tourism

                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: BookingDialog(),
                                  ),
                                );
                              },
                              child: AnimatedContent(
                                leftToRight: 0.0,
                                time: 1500,
                                topToBottom: 5.0,
                                show: true,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.w),
                                  width: 100.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: gblue,
                                    borderRadius: BorderRadius.circular(6.sp),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/Vector (1).png'),
                                        width: 16.w,
                                        height: 16.h,
                                      ),
                                      SizedBox(width: 6.w),
                                      Obx(() => Text(
                                            "${searchHotelController.guestCountVal} Guests",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: poppinsFont,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w100,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  _buildSortPriceFilter(),
                  Container(
                    height: 67.h,
                    width: MediaQuery.of(context).size.width,
                    color: blue,
                    child: Padding(
                        padding: EdgeInsets.only(left: 14.w, bottom: 9.h),
                        child: GestureDetector(
                            onTap: () {
                              if (calendarController.checkInDate.value ==
                                      null ||
                                  calendarController.checkOutDate.value ==
                                      null) {
                                Get.snackbar(
                                  "Dates Required",
                                  "please select the dates",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: blue.withOpacity(0.8),
                                  colorText: white,
                                  margin: EdgeInsets.all(15.r),
                                  borderRadius: 10.r,
                                );
                                return;
                              }
                              searchHotelController.searchHotels();
                            },
                            child: SearchButton())),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),

            // Conditional Rendering
            if (searchHotelController.isLoading.value)
              SliverFillRemaining(
                child: Center(child: AppLoader(size: 50)),
              )
            else if (searchHotelController.errorMessage.value.isNotEmpty)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(searchHotelController.errorMessage.value),
                  ),
                ),
              )
            else if ((searchHotelController.isTourism.value ||
                    searchHotelController.isAdventureTourism.value) &&
                searchHotelController.tourismResult.value != null &&
                searchHotelController.tourismResult.value!.packages != null)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final package = searchHotelController
                        .tourismResult.value!.packages![index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => TourismDetailedViewScreen(
                              packageId: package.id!,
                              startDate:
                                  calendarController.checkInDate.value != null
                                      ? DateFormat('yyyy-MM-dd').format(
                                          calendarController.checkInDate.value!)
                                      : null,
                              endDate: calendarController.checkOutDate.value !=
                                      null
                                  ? DateFormat('yyyy-MM-dd').format(
                                      calendarController.checkOutDate.value!)
                                  : null,
                            ));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.sp),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (package.galleryImages != null &&
                                package.galleryImages!.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15.sp)),
                                child: Image.network(
                                  package.galleryImages!.first,
                                  height: 150.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    'assets/logos/default.jpeg',
                                    height: 150.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          package.packageName ?? 'Package Name',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 4.h),
                                        decoration: BoxDecoration(
                                          color: blue.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        child: Text(
                                          package.packageType ?? '',
                                          style: TextStyle(
                                            color: blue,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,
                                          size: 14.sp, color: Colors.grey),
                                      SizedBox(width: 4.w),
                                      Expanded(
                                        child: Text(
                                          "${package.startLocation} to ${package.destination}",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.sp,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "₹${package.priceWithoutFlight ?? '0'}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "Per Person",
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.timer_outlined,
                                              size: 14.sp, color: Colors.grey),
                                          SizedBox(width: 4.w),
                                          Text(
                                            "${package.durationDays}D / ${package.durationNights}N",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: searchHotelController
                      .tourismResult.value!.packages!.length,
                ),
              )
            else if (searchHotelController.searchResult.value != null &&
                searchHotelController.searchResult.value!.searchResults != null)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final hotel = searchHotelController
                        .searchResult.value!.searchResults![index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to detail view
                        if (hotel.accommodationType == "HALL") {
                          Get.to(() => HallDetailedViewScreen(
                                hotel: hotel,
                                startDate: calendarController
                                            .checkInDate.value !=
                                        null
                                    ? DateFormat('yyyy-MM-dd').format(
                                        calendarController.checkInDate.value!)
                                    : null,
                                endDate: calendarController
                                            .checkOutDate.value !=
                                        null
                                    ? DateFormat('yyyy-MM-dd').format(
                                        calendarController.checkOutDate.value!)
                                    : null,
                              ));
                        } else if (hotel.accommodationType == "FRESHUP") {
                          Get.to(() => FreshupDetailedViewScreen(
                                freshup: hotel,
                                startDate: calendarController
                                            .checkInDate.value !=
                                        null
                                    ? DateFormat('yyyy-MM-dd').format(
                                        calendarController.checkInDate.value!)
                                    : null,
                                endDate: calendarController
                                            .checkOutDate.value !=
                                        null
                                    ? DateFormat('yyyy-MM-dd').format(
                                        calendarController.checkOutDate.value!)
                                    : null,
                              ));
                        } else {
                          Get.to(() => DetailedViewScreen(
                                hotel: hotel,
                                startDate: calendarController
                                            .checkInDate.value !=
                                        null
                                    ? DateFormat('yyyy-MM-dd').format(
                                        calendarController.checkInDate.value!)
                                    : null,
                                endDate: calendarController
                                            .checkOutDate.value !=
                                        null
                                    ? DateFormat('yyyy-MM-dd').format(
                                        calendarController.checkOutDate.value!)
                                    : null,
                              ));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.sp),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: hotel.accommodationType == "FRESHUP"
                            ? // FRESHUP SPECIFIC ROOM CARD DESIGN
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (hotel.freshupDetails?.roomImages != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15.sp)),
                                      child: Image.network(
                                        hotel.freshupDetails!.roomImages!.first,
                                        height: 150.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                          'assets/logos/default.jpeg',
                                          height: 150.h,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (hotel.name != null)
                                                    Text(
                                                      hotel.name!,
                                                      style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.sp,
                                                    ),
                                                    ),
                                                  Text(
                                                    hotel.freshupDetails
                                                            ?.freshupName ??
                                                        hotel.name ??
                                                        'Room Name',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 4.h),
                                              decoration: BoxDecoration(
                                                color: blue.withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                              ),
                                              child: Text(
                                                hotel.freshupDetails
                                                        ?.freshupType ??
                                                    'FreshUp',
                                                style: TextStyle(
                                                  color: blue,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.h),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on_outlined,
                                                size: 14.sp,
                                                color: Colors.grey),
                                            SizedBox(width: 4.w),
                                            Expanded(
                                              child: Text(
                                                hotel.location ?? 'Location',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12.sp,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "₹${hotel.offerPrice ?? hotel.originalPrice ?? '0'}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.sp,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                if (hotel.taxInfo != null)
                                                  Text(
                                                    hotel.taxInfo!,
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            if (hotel.freshupDetails
                                                    ?.availableRooms !=
                                                null)
                                              Text(
                                                "${hotel.freshupDetails!.availableRooms} Rooms Left",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.redAccent,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : // DEFAULT HOTEL/HALL CARD DESIGN
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (hotel.coverImageUrl != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15.sp)),
                                      child: Image.network(
                                        hotel.coverImageUrl!,
                                        height: 150.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                          'assets/logos/default.jpeg',
                                          height: 150.h,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          hotel.name ?? 'Hotel Name',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          hotel.location ?? 'Location',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Row(
                                          children: [
                                            Text(
                                              "₹${hotel.originalPrice ?? '0'}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                            if (hotel.taxInfo != null)
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.w),
                                                child: Text(
                                                  hotel.taxInfo!,
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    );
                  },
                  childCount: searchHotelController
                      .searchResult.value!.searchResults!.length,
                ),
              )
            else ...[
              // Premium Initial "Explore" View
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Illustration/Icon Container
                      Container(
                        height: 200.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          color: blue.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.explore_outlined,
                            size: 100.sp,
                            color: blue.withOpacity(0.5),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        "Where to next?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22.sp,
                          color: blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Search for hotels, destinations, and more to find your perfect stay.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          color: fontColor,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      // Quick Search Suggestions
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Popular Destinations",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.sp,
                            color: black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Wrap(
                        spacing: 12.w,
                        runSpacing: 12.h,
                        children: [
                          _buildQuickSearchChip("Udaipur"),
                          _buildQuickSearchChip("Jaipur"),
                          _buildQuickSearchChip("Kochi"),
                          _buildQuickSearchChip("Munnar"),
                          _buildQuickSearchChip("Goa"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ]..addAll([
              if (searchHotelController.isLoadMore.value)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Center(child: AppLoader(size: 30)),
                  ),
                ),
            ]),
        );
      }),
    );
  }

  Widget _buildSortPriceFilter() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: blue,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PopupMenuButton<String>(
              color: white,
              position: PopupMenuPosition.under,
              offset: const Offset(-75, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  enabled: false, // Makes the item non-clickable
                  child: Container(
                    decoration: BoxDecoration(color: white),
                    padding: EdgeInsets.all(8.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Budget (Per Night)',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: blue,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: minController,
                                onChanged: (value) {
                                  searchHotelController.minPrice.value =
                                      int.tryParse(value);
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Min',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: maxController,
                                onChanged: (value) {
                                  searchHotelController.maxPrice.value =
                                      int.tryParse(value);
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Max',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: budgetRanges.map((range) {
                            return InkWell(
                              onTap: () {
                                final values = range.split('-');
                                if (values.length > 1) {
                                  minController.text = values[0];
                                  maxController.text =
                                      values[1].replaceAll('+', '');
                                } else {
                                  minController.text =
                                      values[0].replaceAll('+', '');
                                  maxController.text = '';
                                }
                                searchHotelController.minPrice.value =
                                    int.tryParse(minController.text);
                                searchHotelController.maxPrice.value =
                                    int.tryParse(maxController.text);
                                setState(() {
                                  selectedRange = range;
                                });
                                searchHotelController.searchHotels();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(color: grey),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  range,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: blue,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              child: Container(
                height: 30.h,
                width: 160.w,
                decoration: BoxDecoration(
                  color: gblue,
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: poppinsFont,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: poppinsFont,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            GestureDetector(
              onTap: () {
                Get.to(() => FilterSearchScreen());
              },
              child: Container(
                height: 30.h,
                width: 160.w,
                decoration: BoxDecoration(
                  color: gblue,
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Filter",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: poppinsFont,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w100),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Image(
                      image: AssetImage(
                        'assets/images/Frame (2).png',
                      ),
                      width: 13.w,
                      height: 13.h,
                      color: white,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Add this function to your SearchScreen class
  void _showCalendarBottomSheet(BuildContext context) async {
    final searchHotelController = Get.find<SearchHotelController>();
    final calendarController = Get.put(CalendarController());

    if (searchHotelController.isGroupedByHall.value ||
        searchHotelController.isFreshup.value ||
        searchHotelController.isTourism.value ||
        searchHotelController.isAdventureTourism.value) {
      await BottomSheetUtils.showSingleDatePicker(context);
      return;
    }

    final ScrollController calenderScroll = ScrollController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: scaffoldColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),

            // Calendar title
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                "Select Dates",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: blue,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Only the calendar is scrollable
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ScrollableCleanCalendar(
                  daySelectedBackgroundColor: yellow,
                  daySelectedBackgroundColorBetween: blue.withOpacity(0.1),
                  dayTextStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    color: black,
                  ),
                  monthTextStyle: TextStyle(
                    color: blue,
                    fontFamily: 'Poppins',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  weekdayTextStyle: TextStyle(
                    color: fontColor,
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  scrollController: calenderScroll,
                  calendarController: calendarController.calendarController,
                  layout: Layout.BEAUTY,
                  calendarCrossAxisSpacing: 0,
                ),
              ),
            ),

            // Date display section
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.05),
                    offset: const Offset(0, -5),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Check-in date card
                      Expanded(
                        child: Obx(() => _buildDateCard(
                              title: "CHECK-IN",
                              date: calendarController.checkInDate.value != null
                                  ? calendarController.formatDate(
                                      calendarController.checkInDate.value)
                                  : "Select Date",
                              isSelected:
                                  calendarController.checkInDate.value != null,
                            )),
                      ),

                      // Total days indicator
                      Obx(() => Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: yellow.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              "${calendarController.totalDays.value} Days",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: blue,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),

                      // Check-out date card
                      Expanded(
                        child: Obx(() => _buildDateCard(
                              title: "CHECK-OUT",
                              date:
                                  calendarController.checkOutDate.value != null
                                      ? calendarController.formatDate(
                                          calendarController.checkOutDate.value)
                                      : "Select Date",
                              isSelected:
                                  calendarController.checkOutDate.value != null,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Apply button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(15.sp),
                      child: Ink(
                        width: double.infinity,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.circular(15.sp),
                          boxShadow: [
                            BoxShadow(
                              color: blue.withOpacity(0.3),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Confirm & Continue",
                            style: TextStyle(
                              color: white,
                              fontSize: 16.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateCard(
      {required String title, required String date, required bool isSelected}) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: scaffoldColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected ? blue.withOpacity(0.2) : border.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              fontFamily: "Poppins",
              color: fontColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            date,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: "Poppins",
              color: blue,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuickSearchChip(String label) {
    return InkWell(
      onTap: () {
        if (calendarController.checkInDate.value == null ||
            calendarController.checkOutDate.value == null) {
          Get.snackbar(
            "Dates Required",
            "please select the dates",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: blue.withOpacity(0.8),
            colorText: white,
            margin: EdgeInsets.all(15.r),
            borderRadius: 10.r,
          );
          return;
        }
        searchHotelController.location.value = label;
        searchHotelController.searchHotels();
      },
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(color: blue.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(20.r),
          color: white,
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.03),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.sp,
            color: blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
