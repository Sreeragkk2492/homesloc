import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/tourism/tourism_detail_model.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/tourism/tourism_detail_controller.dart';

class TourismBookNow extends StatelessWidget {
  final TourismDetailModel data;

  const TourismBookNow({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(23.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Text(
            'Book Your Tour Now',
            style: TextStyle(
                color: const Color.fromARGB(255, 230, 230, 230),
                fontFamily: 'Poppins',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Text(
            'Secure your spot for an amazing journey! Simple and instant booking.',
            style: TextStyle(
                color: const Color.fromARGB(255, 200, 200, 200),
                fontFamily: 'Poppins',
                fontSize: 13.sp,
                fontWeight: FontWeight.w300),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: const Divider(
              color: Color.fromARGB(255, 150, 150, 150),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹${data.priceWithoutFlight}",
                        style: TextStyle(
                            color: white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 23.sp),
                      ),
                      // if (data.offerPrice != null &&
                      //     data.offerPrice != data.priceWithoutFlight) ...[
                      //   SizedBox(width: 8.w),
                      //   Text(
                      //     "₹${data.offerPrice}",
                      //     style: TextStyle(
                      //         color: const Color.fromARGB(255, 190, 190, 190),
                      //         fontFamily: 'Poppins',
                      //         fontWeight: FontWeight.w500,
                      //         decoration: TextDecoration.lineThrough,
                      //         decorationColor: white,
                      //         fontSize: 12.sp),
                      //   ),
                     // ],
                    ],
                  ),
                  Text(
                    "Including Taxes",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 190, 190, 190),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  final TourismDetailController controller =
                      Get.find<TourismDetailController>();
                  controller.checkAvailabilityAndBook();
                },
                child: Container(
                  width: 140.w,
                  height: 43.h,
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(28.sp),
                  ),
                  child: Center(
                    child: Text(
                      "BOOK NOW",
                      style: TextStyle(
                          color: black,
                          fontSize: 15.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
