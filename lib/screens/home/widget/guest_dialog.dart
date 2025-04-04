import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';

import '../../../controller/calender_controller.dart';

class BookingDialog extends StatefulWidget {
   BookingDialog({super.key});



  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  int adults = 2;
  int children = 0;
  int rooms = 1;
  bool travellingWithPets = false;

  final calendarController = Get.put(CalendarController());

  Widget _buildCounter(String label, int value, Function(int) onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: grey,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => onChanged(value - 1),
                  icon: const Icon(
                    Icons.remove,
                    color: blue,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: grey,
                    minimumSize: Size(40.w, 40.h),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Text(
                    value.toString(),
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                IconButton(
                  onPressed: () => onChanged(value + 1),
                  icon: const Icon(
                    Icons.add,
                    color: blue,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: grey,
                    minimumSize: Size(40.w, 40.h),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCounter('Adults', adults, (value) {
            if (value >= 1) {
              setState(() => adults = value);
            }
          }),
          _buildCounter('Children', children, (value) {
            if (value >= 0) {
              setState(() => children = value);
            }
          }),
          _buildCounter('Rooms', rooms, (value) {
            if (value >= 1) {
              setState(() => rooms = value);
            }
          }),
          Divider(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Travelling with pets?',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Text(
              //   'Assistance animals aren\'t considered pets.',
              //   style: TextStyle(
              //     fontSize: 12,
              //     color: Colors.grey,
              //   ),
              // ),
              // Text(
              //   'Read more about travelling with assistance animals',
              //   style: TextStyle(
              //     fontSize: 12,
              //     color: Colors.blue,
              //     decoration: TextDecoration.underline,
              //   ),
              // ),
              Switch(
                activeColor: yellow,
                value: travellingWithPets,
                onChanged: (value) {
                  setState(() => travellingWithPets = value);
                },
              ),
            ],
          ),
          Text(
            'Assistance animals aren\'t considered pets.\nRead more about travelling with assistance animals',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
            child: TextButton(
              onPressed: () {
                // Update Calendar controller to include guest info
                calendarController.updateGuestInfo(adults + children, rooms);
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 50,
                height: 43.h,
                decoration: BoxDecoration(
                  color: yellow,
                  borderRadius: BorderRadius.circular(28.sp),
                ),
                child: Center(
                  child: Text(
                    "Apply",
                    style: TextStyle(
                        color: black,
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Text(
          //   'Read more about travelling with assistance animals',
          //   style: TextStyle(
          //     fontSize: 12,
          //     color: Colors.blue,
          //     decoration: TextDecoration.underline,
          //   ),
          // ),
        ],
      ),
    );
  }
}
