import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/freshup/freshup_detail_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/search/search_hotel_model.dart';
import 'package:homesloc/core/common/global_variables.dart';
import 'package:homesloc/screens/auth/sign_in.dart';

class FreshupBookNow extends StatelessWidget {
  final Hotel freshup;
  final List<String> selectedSlotIds;
  final String? selectedRoomPrice;
  final String? selectedRoomOriginalPrice;
  const FreshupBookNow({
    super.key,
    required this.freshup,
    this.selectedSlotIds = const [],
    this.selectedRoomPrice,
    this.selectedRoomOriginalPrice,
  });

  @override
  Widget build(BuildContext context) {
    // Effective prices: prefer selected room price > freshup price
    final displayPrice =
        selectedRoomPrice ?? freshup.offerPrice ?? freshup.originalPrice ?? '0';
    final originalPrice = selectedRoomOriginalPrice ?? freshup.originalPrice;
    final hasDiscount = originalPrice != null &&
        originalPrice != displayPrice &&
        originalPrice != freshup.offerPrice;

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
            'Book Short Stay',
            style: TextStyle(
                color: const Color.fromARGB(255, 230, 230, 230),
                fontFamily: 'Poppins',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Text(
            'Refresh and recharge with our short stay options.',
            style: TextStyle(
                color: const Color.fromARGB(255, 200, 200, 200),
                fontFamily: 'Poppins',
                fontSize: 13.sp,
                fontWeight: FontWeight.w300),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Divider(
              color: const Color.fromARGB(255, 150, 150, 150),
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
                      // if (hasDiscount) ...[
                      //   Text(
                      //     '\u20b9$originalPrice',
                      //     style: TextStyle(
                      //         color: const Color.fromARGB(255, 190, 190, 190),
                      //         fontFamily: 'Poppins',
                      //         decoration: TextDecoration.lineThrough,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 14.sp),
                      //   ),
                      //   SizedBox(width: 6.w),
                      // ],
                      Text(
                        '\u20b9$displayPrice',
                        style: TextStyle(
                            color: white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 23.sp),
                      ),
                    ],
                  ),
                  Text(
                    'Including Taxes',
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
                  if (accessToken.isEmpty) {
                    Get.snackbar(
                      "Login Required",
                      "Please login to continue",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: blue.withOpacity(0.8),
                      colorText: white,
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      Get.offAll(() => const SignIn());
                    });
                    return;
                  }
                  final controller =
                      Get.find<FreshupDetailController>(tag: freshup.id);
                  controller.bookNow();
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
                      'BOOK NOW',
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
