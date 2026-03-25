// ignore_for_file: file_names, avoid_print, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/book_now/book_now.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/pay_now/pay_now.dart';
import 'package:homesloc/core/utils/bottom_sheet_utils.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/models/booking/room_availability_model.dart';
import 'package:homesloc/models/hotel/hotel_booking_request_model.dart';
import 'package:homesloc/models/hall/hall_booking_request_model.dart';
import 'package:homesloc/apis/home/hotel_detail_service.dart';
import 'package:homesloc/screens/payment_screen/booking_successful/booking_successful.dart';
import 'package:homesloc/core/common/global_variables.dart' as global;
import 'package:homesloc/controller/profile/profile_controller.dart';
import 'package:homesloc/core/services/razorpay_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:homesloc/core/widgets/loader/app_loader.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatefulWidget {
  final String hotelName;
  final String location;
  final double price;
  final String coverImage;
  final BookingDetails? bookingDetails;
  final String? propertyId;
  final String? propertyType; // "ROOM", "FULL_PROPERTY", or "HALL"
  final String? cancellationPolicy;

  PaymentScreen({
    super.key,
    this.hotelName = "Hotel Name",
    this.location = "Location",
    this.price = 0.0,
    this.coverImage = "https://via.placeholder.com/150",
    this.bookingDetails,
    this.propertyId,
    this.propertyType,
    this.cancellationPolicy,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final calendarController = Get.find<CalendarController>();
  final RazorpayService _razorpayService = RazorpayService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() {
    try {
      if (Get.isRegistered<ProfileController>()) {
        final profileController = Get.find<ProfileController>();
        final profile = profileController.userProfile.value;
        if (profile != null) {
          _nameController.text = profile.name;
          _emailController.text = profile.primaryEmail;
          _phoneController.text = profile.primaryMobile;
          return; // Successfully loaded from profile
        }
      }

      // Fallback to global variables if profile is missing
      if (global.userName.isNotEmpty) {
        _nameController.text = global.userName;
      }
      if (global.userEmail.isNotEmpty) {
        _emailController.text = global.userEmail;
      }
    } catch (e) {
      debugPrint("Error loading profile: $e");
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: blue,
            ),
          ),
          title: Text(
            "Confirm & Pay",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: blue,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hotel Summary Card
              Container(
                margin: EdgeInsets.all(12.r),
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.04),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Hero(
                      tag: 'hotel_image',
                      child: Container(
                        width: 120.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          image: DecorationImage(
                            image: widget.coverImage.startsWith('http')
                                ? NetworkImage(widget.coverImage)
                                : AssetImage(widget.coverImage) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.hotelName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(Icons.location_on_rounded,
                                  color: yellow, size: 14.sp),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  widget.location,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: fontColor,
                                      fontSize: 11.sp),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      
              // Enter your details section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Text(
                  'Enter your details',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: blue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.04),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: scaffoldColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline_rounded,
                              color: blue, size: 20.sp),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              "Almost done! Just fill in the * required info",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: blue,
                                  fontSize: 13.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                              label: "First name *",
                              controller: _nameController,
                              hint: "Enter your name"),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildTextField(
                              label: "Email address *",
                              controller: _emailController,
                              hint: "Enter email",
                              keyboardType: TextInputType.emailAddress),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField(
                      label: "Phone number *",
                      controller: _phoneController,
                      hint: "Enter your phone number",
                      keyboardType: TextInputType.phone,
                      prefix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 12.w),
                          Text("+91",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp,
                                  color: black)),
                          Icon(Icons.keyboard_arrow_down_rounded,
                              color: grey, size: 20.sp),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            width: 1,
                            height: 20.h,
                            color: border.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      
              // Booking Summary Section
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
                child: Text(
                  'Booking Summary',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: blue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.all(12.w),
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.04),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Obx(() {
                  final checkIn = calendarController.checkInDate.value;
                  DateTime? checkOut = calendarController.checkOutDate.value;
      
                  // For halls, if same day selection, checkOut might be null in controller
                  // We default to checkIn for display purposes
                  if (widget.propertyType == "HALL" && checkOut == null) {
                    checkOut = checkIn;
                  }
      
                  int duration;
                  if (widget.propertyType == "HALL" &&
                      widget.bookingDetails?.days != null) {
                    duration = widget.bookingDetails!.days!;
                  } else if (checkIn != null && checkOut != null) {
                    // For ROOM/FULL_PROPERTY, duration is nights (difference in days)
                    duration = checkOut.difference(checkIn).inDays;
                  } else {
                    duration = 0;
                  }
      
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.propertyType != "HALL" &&
                          widget.bookingDetails?.adults != null) ...[
                        _buildSummaryRow(
                            "Guests",
                            "${widget.bookingDetails!.adults} ${widget.bookingDetails!.adults! > 1 ? 'Adults' : 'Adult'}" +
                                (widget.bookingDetails!.children != null &&
                                        widget.bookingDetails!.children! > 0
                                    ? ", ${widget.bookingDetails!.children} ${widget.bookingDetails!.children! > 1 ? 'Children' : 'Child'}"
                                    : "")),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child:
                              Divider(color: border.withOpacity(0.3), height: 1),
                        ),
                      ],
                      if (widget.propertyType != "HALL" &&
                          widget.bookingDetails?.roomsRequested != null) ...[
                        _buildSummaryRow(
                            "Rooms", "${widget.bookingDetails!.roomsRequested}"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child:
                              Divider(color: border.withOpacity(0.3), height: 1),
                        ),
                      ],
                      _buildSummaryRow(
                          "Check In", calendarController.formatDate(checkIn)),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Divider(color: border.withOpacity(0.3), height: 1),
                      ),
                      _buildSummaryRow(
                          "Check Out", calendarController.formatDate(checkOut)),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Divider(color: border.withOpacity(0.3), height: 1),
                      ),
                      _buildSummaryRow("Duration", "$duration days"),
                      if (widget.bookingDetails?.dateDetails != null &&
                          widget.bookingDetails!.dateDetails!.isNotEmpty) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child:
                              Divider(color: border.withOpacity(0.3), height: 1),
                        ),
                        Text(
                          'Date Details',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: blue,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.h),
                        ...widget.bookingDetails!.dateDetails!.map((detail) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  detail.date ?? "",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: fontColor,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '₹${detail.offerPrice ?? detail.basePrice ?? '0'}',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: black,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ],
                  );
                }),
              ),
      
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 12.w),
              //   padding: EdgeInsets.all(16.r),
              //   decoration: BoxDecoration(
              //     color: white,
              //     borderRadius: BorderRadius.circular(16.r),
              //     boxShadow: [
              //       BoxShadow(
              //         color: black.withOpacity(0.04),
              //         spreadRadius: 2,
              //         blurRadius: 10,
              //         offset: const Offset(0, 4),
              //       ),
              //     ],
              //   ),
              //   child: Column(
              //     children: [
              //       _buildBillingItem(
              //         icon: Icons.calendar_month_rounded,
              //         title: "Stay Dates",
              //         subtitle: Obx(() => Text(
              //               calendarController.checkInDate.value != null &&
              //                       calendarController.checkOutDate.value != null
              //                   ? "${calendarController.formatDate(calendarController.checkInDate.value)} - ${calendarController.formatDate(calendarController.checkOutDate.value)}"
              //                   : "Select Dates",
              //               style: TextStyle(
              //                   fontFamily: 'Poppins',
              //                   color: blue,
              //                   fontWeight: FontWeight.w600,
              //                   fontSize: 13.sp),
              //             )),
              //       ),
              //       Padding(
              //         padding: EdgeInsets.symmetric(vertical: 12.h),
              //         child: Divider(color: border.withOpacity(0.5), height: 1),
              //       ),
              //       _buildBillingItem(
              //         icon: Icons.people_alt_rounded,
              //         title: "Guests & Rooms",
              //         subtitle: Obx(() => Text(
              //               "${calendarController.guestCount.value} Guests | ${calendarController.roomCount.value} Rooms",
              //               style: TextStyle(
              //                   fontFamily: 'Poppins',
              //                   color: blue,
              //                   fontWeight: FontWeight.w600,
              //                   fontSize: 13.sp),
              //             )),
              //       ),
              //       if (bookingDetails?.dateDetails != null &&
              //           bookingDetails!.dateDetails!.any((d) =>
              //               d.checkinTime != null && d.checkoutTime != null))
              //         Column(
              //           children: [
              //             Padding(
              //               padding: EdgeInsets.symmetric(vertical: 12.h),
              //               child: Divider(
              //                   color: border.withOpacity(0.5), height: 1),
              //             ),
              //             _buildBillingItem(
              //               icon: Icons.access_time_filled_rounded,
              //               title: "Stay Slots",
              //               subtitle: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: bookingDetails!.dateDetails!
              //                     .where((d) =>
              //                         d.checkinTime != null &&
              //                         d.checkoutTime != null)
              //                     .map((d) => Text(
              //                           "${d.checkinTime} - ${d.checkoutTime}",
              //                           style: TextStyle(
              //                               fontFamily: 'Poppins',
              //                               color: blue,
              //                               fontWeight: FontWeight.w600,
              //                               fontSize: 13.sp),
              //                         ))
              //                     .toList(),
              //               ),
              //             ),
              //           ],
              //         ),
              //       if (bookingDetails?.priceSummary != null)
              //         Column(
              //           children: [
              //             Padding(
              //               padding: EdgeInsets.symmetric(vertical: 12.h),
              //               child: Divider(
              //                   color: border.withOpacity(0.5), height: 1),
              //             ),
              //             // _buildBillingItem(
              //             //   icon: Icons.receipt_long_rounded,
              //             //   title: "Price Details",
              //             //   subtitle: Column(
              //             //     crossAxisAlignment: CrossAxisAlignment.start,
              //             //     children: bookingDetails!.priceSummary!.entries
              //             //         .map((e) => Padding(
              //             //               padding:
              //             //                   EdgeInsets.symmetric(vertical: 1.h),
              //             //               child: Row(
              //             //                 mainAxisAlignment:
              //             //                     MainAxisAlignment.spaceBetween,
              //             //                 children: [
              //             //                   Text(
              //             //                     e.key
              //             //                         .replaceAll('_', ' ')
              //             //                         .capitalizeFirst!,
              //             //                     style: TextStyle(
              //             //                         fontFamily: 'Poppins',
              //             //                         color: fontColor,
              //             //                         fontSize: 11.sp),
              //             //                   ),
              //             //                   SizedBox(width: 20.w),
              //             //                   Text(
              //             //                     "₹${e.value}",
              //             //                     style: TextStyle(
              //             //                         fontFamily: 'Poppins',
              //             //                         color: blue,
              //             //                         fontWeight: FontWeight.w600,
              //             //                         fontSize: 12.sp),
              //             //                   ),
              //             //                 ],
              //             //               ),
              //             //             ))
              //             //         .toList(),
              //             //   ),
              //             // ),
              //           ],
              //         ),
              //     ],
              //   ),
              // ),
      
              // Payment Method Section
              // Padding(
              //   padding: EdgeInsets.only(
              //       top: 20.h, left: 16.w, right: 16.w, bottom: 8.h),
              //   child: Text(
              //     'Payment Method',
              //     style: TextStyle(
              //         fontFamily: 'Poppins',
              //         color: blue,
              //         fontSize: 16.sp,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
      
              if (widget.cancellationPolicy != null &&
                  widget.cancellationPolicy!.isNotEmpty)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: black.withOpacity(0.04),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.policy_rounded,
                              color: Colors.redAccent, size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            "Cancellation Policy",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        widget.cancellationPolicy!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: fontColor,
                          fontSize: 12.sp,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
      
              Obx(() => PayNow(
                    price: widget.price,
                    hotelName: widget.hotelName,
                    location: widget.location,
                    coverImage: widget.coverImage,
                    checkInDate: calendarController.checkInDate.value != null
                        ? calendarController
                            .formatDate(calendarController.checkInDate.value)
                        : "N/A",
                    checkOutDate: calendarController.checkOutDate.value != null
                        ? calendarController
                            .formatDate(calendarController.checkOutDate.value)
                        : "N/A",
                    bookingDetails: widget.bookingDetails,
                    onPayNow:
                        widget.propertyId != null && widget.propertyType != null
                            ? () => _startPayment()
                            : null,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startPayment() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final contact = _phoneController.text.trim();

    if (name.isEmpty || email.isEmpty || contact.isEmpty) {
      Get.snackbar(
        "Required Fields",
        "Please fill in all required details to proceed.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: white,
      );
      return;
    }

    final totalAmount = widget.bookingDetails?.offerPrice ??
        widget.bookingDetails?.price ??
        widget.price;

    _razorpayService.onSuccess = (PaymentSuccessResponse response) {
      _confirmBooking(response.paymentId ?? "");
    };

    _razorpayService.onFailure = (PaymentFailureResponse response) {
      Get.snackbar(
        "Payment Failed",
        response.message ?? "Payment was unsuccessful. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: white,
      );
    };

    await _razorpayService.openCheckout(
      amount: totalAmount.toDouble(),
      name: name,
      description: "Booking for ${widget.hotelName}",
      prefillContact: contact,
      prefillEmail: email,
    );
  }

  Future<void> _confirmBooking(String razorpayPaymentId) async {
    final HotelDetailService hotelDetailService = HotelDetailService();

    // Show loading
    Get.dialog(
      const Center(child: AppLoader(size: 50)),
      barrierDismissible: false,
    );

    try {
      final dateFormat = DateFormat('yyyy-MM-dd');
      final checkInStr = dateFormat
          .format(calendarController.checkInDate.value ?? DateTime.now());
      final checkOutStr = dateFormat
          .format(calendarController.checkOutDate.value ?? DateTime.now());

      final totalAmount = widget.bookingDetails?.offerPrice ??
          widget.bookingDetails?.price ??
          widget.price;

      dynamic booking;

      // Create appropriate booking request based on property type
      if (widget.propertyType == "ROOM" ||
          widget.propertyType == "FULL_PROPERTY") {
        booking = HotelBookingRequestModel(
          propertyId: widget.propertyId,
          propertyType: widget.propertyType,
          userName: _nameController.text.trim(),
          primaryEmail: _emailController.text.trim(),
          primaryMobile: _phoneController.text.trim(),
          checkIn: checkInStr,
          checkOut: checkOutStr,
          totalAmount: totalAmount,
          paymentId: razorpayPaymentId,
          paymentMethod: "Online",
          paymentStatus: "Completed",
          bookingStatus: "Booked",
        );
      } else if (widget.propertyType == "HALL") {
        booking = HallBookingRequestModel(
          propertyId: widget.propertyId,
          propertyType: widget.propertyType,
          userName: _nameController.text.trim(),
          primaryEmail: _emailController.text.trim(),
          primaryMobile: _phoneController.text.trim(),
          checkIn: checkInStr,
          checkOut: checkOutStr,
          totalAmount: totalAmount,
          paymentId: razorpayPaymentId,
          paymentMethod: "Online",
          paymentStatus: "Completed",
          bookingStatus: "Booked",
        );
      }

      if (booking != null) {
        final success = await hotelDetailService.createNewBooking([booking]);

        Get.back(); // Hide loading

        if (success) {
          Get.offAll(() => BookingSuccessful(
                hotelName: widget.hotelName,
                location: widget.location,
                price: totalAmount.toStringAsFixed(0),
                checkInDate: checkInStr,
                checkOutDate: checkOutStr,
                coverImage: widget.coverImage,
              ));
        } else {
          Get.snackbar(
            "Booking Failed",
            "Payment successful but booking confirmation failed. Please contact support.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: white,
            duration: const Duration(seconds: 5),
          );
        }
      } else {
        Get.back();
        Get.snackbar(
          "Error",
          "Invalid property type.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: white,
        );
      }
    } catch (e) {
      Get.back();
      debugPrint("Error confirming booking: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred during booking confirmation.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: white,
      );
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    Widget? prefix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontFamily: 'Poppins',
              color: fontColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.sp,
              color: black,
              fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                color: grey,
                fontWeight: FontWeight.normal),
            prefixIcon: prefix,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: border.withOpacity(0.5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: border.withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: blue),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
              fontFamily: 'Poppins',
              color: fontColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: TextStyle(
              fontFamily: 'Poppins',
              color: black,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
