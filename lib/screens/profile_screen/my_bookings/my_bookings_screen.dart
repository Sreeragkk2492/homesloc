import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/myBooking/my_booking_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/booking/user_booking_model.dart';
import 'package:homesloc/core/widgets/loader/app_loader.dart';
import 'package:intl/intl.dart';

class TripScreen extends StatelessWidget {
  final controller = Get.put(TripController());

  TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Bookings',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              'View and manage the bookings in your account',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: OutlinedButton.icon(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back, size: 16.sp, color: Colors.black),
              label: Text(
                'Back',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey[300]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppLoader());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.bookings.isEmpty) {
          return Center(
            child: Text(
              'No bookings found.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16.sp,
                fontFamily: 'Poppins',
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            final booking = controller.bookings[index];
            return _buildBookingCard(booking);
          },
        );
      }),
    );
  }

  Widget _buildBookingCard(UserBooking booking) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Name and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  booking.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildInfoChip(
                icon: Icons.check_circle_outline,
                text: booking.bookingStatus,
                color: Colors.green,
                backgroundColor: Colors.green[50],
                borderColor: Colors.green[200],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Middle Section: Image and Details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: booking.coverImageUrl != null
                    ? Image.network(
                        booking.coverImageUrl!,
                        width: 70.w,
                        height: 80.h,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 70.w,
                        height: 80.h,
                        color: Colors.grey[200],
                        child: Icon(Icons.image, color: Colors.grey),
                      ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getSubtitle(booking),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (booking.location != null) ...[
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              size: 12.sp, color: Colors.grey),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              booking.location!,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 4.h,
                      children: [
                        _buildInfoChip(
                          icon: Icons.calendar_today_outlined,
                          text: booking.checkIn != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(booking.checkIn!)
                              : 'N/A',
                          color: blue,
                        ),
                        _buildInfoChip(
                          icon: Icons.business_outlined,
                          text: booking.propertyType.toLowerCase(),
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Bottom Section: Price and View Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹ ${booking.totalAmount.toInt()}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F4A63),
                  fontFamily: 'Poppins',
                ),
              ),
              Obx(() {
                final isExpanded = controller.expandedIds.contains(booking.id);
                return ElevatedButton(
                  onPressed: () => controller.toggleExpansionStatus(booking.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F4A63),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  child: Text(
                    isExpanded ? 'Hide Details' : 'View Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }),
            ],
          ),

          // Expanded Details Section
          Obx(() {
            final isExpanded = controller.expandedIds.contains(booking.id);
            if (!isExpanded) return const SizedBox.shrink();

            if (controller.isDetailLoading[booking.id] == true) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: const Center(child: AppLoader(size: 40)),
              );
            }

            final details = controller.bookingDetails[booking.id];
            if (details == null) return const SizedBox.shrink();

            return Column(
              children: [
                SizedBox(height: 16.h),
                const Divider(),
                SizedBox(height: 12.h),
                _buildDetailGrid(details),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDetailGrid(UserBooking details) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            label1: 'Property Type',
            value1: details.propertyType,
            label2: 'Booking Date',
            value2: details.bookingDate != null
                ? DateFormat('yyyy-MM-dd').format(details.bookingDate!)
                : 'N/A',
          ),
          const Divider(height: 1),
          _buildDetailRow(
            label1: 'Check-In Date',
            value1: details.checkIn != null
                ? DateFormat('yyyy-MM-dd').format(details.checkIn!)
                : 'N/A',
            label2: 'Payment Status',
            value2: details.paymentStatus,
            valueColor2: details.paymentStatus.toLowerCase() == 'pending'
                ? Colors.orange
                : Colors.green,
          ),
          const Divider(height: 1),
          _buildDetailRow(
            label1: 'Payment Method',
            value1: details.paymentMethod,
            label2: '',
            value2: '',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required String label1,
    required String value1,
    required String label2,
    required String value2,
    Color? valueColor2,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(child: _buildDetailItem(label1, value1)),
          if (label2.isNotEmpty) ...[
            VerticalDivider(width: 1, color: Colors.grey[200]),
            Expanded(
                child:
                    _buildDetailItem(label2, value2, valueColor: valueColor2)),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, {Color? valueColor}) {
    if (label.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey[600],
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black87,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  String _getSubtitle(UserBooking booking) {
    if (booking.packageName != null) return booking.packageName!;
    if (booking.freshupName != null) return booking.freshupName!;
    if (booking.eventName != null) return booking.eventName!;
    if (booking.roomName != null) return booking.roomName!;
    if (booking.propertyType == "FULL_PROPERTY") return "Full Property";
    return "";
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required Color color,
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.blue[50], // Soft light blue by default
        border: Border.all(color: borderColor ?? Colors.transparent),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp, color: color),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
