import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/myBooking/my_booking_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/booking/booking_model.dart';

class TripScreen extends StatelessWidget {
  final controller = Get.put(TripController());

  TripScreen({
    super.key,
  });

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image.asset(
        //   'assets/globe.png',
        //   height: 200.h,
        // ),
        // SizedBox(height: 24.h),
        Text(
          'Where to next?',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'You haven\'t started any trips yet. Once you\nmake a booking, it\'ll appear here.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16.sp,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

 Widget _buildTabContent(int index) {
  switch (index) {
    case 0:
      return controller.activeBookings.isEmpty
          ? _buildEmptyState()
          : _buildBookingsList(controller.activeBookings);
    case 1:
      return controller.pastBookings.isEmpty
          ? Center(child: Text('No past trips'))
          : _buildBookingsList(controller.pastBookings);
    case 2:
      return controller.canceledBookings.isEmpty
          ? Center(child: Text('No canceled trips'))
          : _buildBookingsList(controller.canceledBookings);
    default:
      return _buildEmptyState();
  }
}
Widget _buildBookingsList(List<BookingModel> bookings) {
  return ListView.builder(
    padding: EdgeInsets.all(16.w),
    itemCount: bookings.length,
    itemBuilder: (context, index) {
      final booking = bookings[index];
      return Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.hotelName,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${booking.numberOfNights} Nights',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    '₹${booking.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: blue,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16.sp, color: Colors.grey[600]),
                  SizedBox(width: 4.w),
                  Text(
                    '${_formatDate(booking.checkInDate)} - ${_formatDate(booking.checkOutDate)}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

String _formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}

  Widget _buildTabButton(int index) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
         // margin: EdgeInsets.only(right: 16.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: controller.selectedIndex.value == index
                  ? blue // Selected tab gets blue border
                  : Colors.transparent, // Unselected tabs have no border
              width: 1.5.w,
            ),
            color: controller.selectedIndex.value == index
                ? Colors.blue[50]
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 8.h,
          ),
          child: Text(
            controller.tabs[index],
            style: TextStyle(
              color:
                  controller.selectedIndex.value == index ? blue : Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App Bar
          Container(
            color: blue,
            padding: EdgeInsets.only(
              top: 50.h,
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trips',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 12.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.w),
                      ),
                      child: IconButton(
                        icon: Text(
                          '?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.w),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      
          // Tab buttons
          Padding(
            padding: EdgeInsets.only(left: 8.w ,top: 10.h),
            child: Row(
              children: List.generate(
                controller.tabs.length,
                (index) => _buildTabButton(index),
              ),
            ),
          ),
      
          // Tab content
          Expanded(
            child: Obx(
              () => _buildTabContent(controller.selectedIndex.value),
            ),
          ),
        ],
      ),
    );
  }
}
