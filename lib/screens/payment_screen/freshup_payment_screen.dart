// ignore_for_file: file_names, avoid_print, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/pay_now/pay_now.dart';
import 'package:homesloc/core/widgets/pay_now/freshup_pay_now.dart';
import 'package:homesloc/core/utils/bottom_sheet_utils.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/models/freshup/freshup_booking_details_model.dart';
import 'package:homesloc/models/freshup/freshup_availability_model.dart';
import 'package:homesloc/controller/freshup/freshup_detail_controller.dart';
import 'package:homesloc/controller/profile/profile_controller.dart';
import 'package:homesloc/core/common/global_variables.dart' as global;

class FreshupPaymentScreen extends StatefulWidget {
  final String hotelName;
  final String location;
  final double price;
  final String coverImage;
  final FreshupBookingDetails? bookingDetails;
  final List<FreshupSlot>? selectedSlots;
  final String? freshupId;
  final String? cancellationPolicy;

  FreshupPaymentScreen({
    super.key,
    this.hotelName = "Freshup Name",
    this.location = "Location",
    this.price = 0.0,
    this.coverImage = "",
    this.bookingDetails,
    this.selectedSlots,
    this.freshupId,
    this.cancellationPolicy,
  });

  @override
  State<FreshupPaymentScreen> createState() => _FreshupPaymentScreenState();
}

class _FreshupPaymentScreenState extends State<FreshupPaymentScreen> {
  final calendarController = Get.find<CalendarController>();

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
    return Scaffold(
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
            // Freshup Summary Card
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
                    tag: 'freshup_image',
                    child: Container(
                      width: 120.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        image: DecorationImage(
                          image: widget.coverImage.startsWith('http')
                              ? NetworkImage(widget.coverImage)
                              : AssetImage(widget.coverImage.isNotEmpty
                                  ? widget.coverImage
                                  : 'assets/images/l1.png') as ImageProvider,
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
                // For Freshups, duration is usually same day or determined by slots
                // But user wants "Start Date", "End Date", "Duration"
                final checkOut = calendarController.checkOutDate.value;
                final duration = checkIn != null && checkOut != null
                    ? checkOut.difference(checkIn).inDays.clamp(1, 100)
                    : 1;

                return Column(
                  children: [
                    _buildSummaryRow(
                        "Start Date", calendarController.formatDate(checkIn)),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Divider(color: border.withOpacity(0.3), height: 1),
                    ),
                    _buildSummaryRow(
                        "End Date", calendarController.formatDate(checkOut)),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Divider(color: border.withOpacity(0.3), height: 1),
                    ),
                    _buildSummaryRow("Duration", "$duration days"),
                  ],
                );
              }),
            ),

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

            Builder(builder: (context) {
              final controller =
                  Get.find<FreshupDetailController>(tag: widget.freshupId);

              if (widget.bookingDetails == null) {
                return const SizedBox.shrink();
              }

              return FreshupPayNow(
                bookingDetails: widget.bookingDetails!,
                onPayNow: () {
                  final name = _nameController.text.trim();
                  final email = _emailController.text.trim();
                  final mobile = _phoneController.text.trim();

                  if (name.isEmpty || email.isEmpty || mobile.isEmpty) {
                    Get.snackbar(
                      "Required Fields",
                      "Please fill in all required details to proceed.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orange.withOpacity(0.8),
                      colorText: white,
                    );
                    return;
                  }

                  controller.startFreshupPayment(
                    hotelName: widget.hotelName,
                    location: widget.location,
                    coverImage: widget.coverImage,
                    totalAmount: widget.bookingDetails?.price?.toDouble() ??
                        widget.price,
                    userName: name,
                    email: email,
                    mobile: mobile,
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
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
