import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/home/home_screen_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/loader/app_loader.dart';

import '../../../../screens/detailed_view_screen/detailed_view_screen.dart';

class FourthHomeBuilder extends StatelessWidget {
  FourthHomeBuilder({super.key});

  final HomeScreenController screenController =
      Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (screenController.isLoading.value) {
        return const SliverFillRemaining(
            child: Center(child: AppLoader(size: 50)));
      } else if (screenController.errorMessage.value.isNotEmpty) {
        return SliverFillRemaining(
            child: Center(child: Text(screenController.errorMessage.value)));
      } else {
        final bestHotels = screenController.bestHotels;
        if (bestHotels.isEmpty) {
          return SliverToBoxAdapter(child: SizedBox.shrink());
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final hotel = bestHotels[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => DetailedViewScreen(
                        hotel: hotel,
                      ));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  width: 339.w,
                  height: 138.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: border),
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5.w, top: 2.h),
                        width: 144.w,
                        height: 128.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.sp),
                          image: DecorationImage(
                            image: (hotel.coverImageUrl != null &&
                                    hotel.coverImageUrl!.startsWith('http'))
                                ? NetworkImage(hotel.coverImageUrl!)
                                : AssetImage('assets/images/l1.png')
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, top: 11.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 160.w,
                              child: Text(
                                hotel.name ?? 'Grand Luxury Resort',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            SizedBox(
                              width: 160.w,
                              child: Text(
                                hotel.location ?? 'Maldives',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: fontColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Row(
                              children: [
                                Text(
                                  "₹${hotel.pricing?.offerPrice ?? (hotel.pricing?.bestPrice ?? '2500')}",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                if (hotel.pricing?.offerPrice != null &&
                                    hotel.pricing?.bestPrice != null &&
                                    hotel.pricing!.offerPrice !=
                                        hotel.pricing!.bestPrice)
                                  Text(
                                    "₹${hotel.pricing?.bestPrice}",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: fontColor,
                                      fontSize: 11.sp,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                if (hotel.pricing?.availableRooms != null) ...[
                                  SizedBox(width: 5.w),
                                  Text(
                                    "${hotel.pricing?.availableRooms} Rooms",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: green,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ]
                              ],
                            ),
                            SizedBox(height: 3.h),
                            Padding(
                              padding: EdgeInsets.only(left: 7.w),
                              child: Text(
                                "+ Taxes & Fees",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: fontColor,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Row(
                              children: [
                                Text(
                                  "Amenities : ",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: fontColor,
                                    fontSize: 11.sp,
                                  ),
                                ),
                                if (hotel.amenities != null &&
                                    hotel.amenities!.isNotEmpty)
                                  SizedBox(
                                    width: 100.w,
                                    height: 20.h,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: hotel.amenities!.length > 3
                                          ? 3
                                          : hotel.amenities!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(right: 5.w),
                                          child: Text(
                                            "${hotel.amenities![index]}${index < (hotel.amenities!.length > 3 ? 2 : hotel.amenities!.length - 1) ? ',' : ''}",
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: fontColor,
                                                fontSize: 11.sp,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                else
                                  Text("N/A",
                                      style: TextStyle(
                                          fontSize: 10.sp, color: fontColor)),
                              ],
                            ),
                            SizedBox(height: 3.h),
                            Row(
                              children: [
                                Container(
                                  width: 44.w,
                                  height: 18.h,
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(3.sp),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${hotel.starRating ?? 'N/A'}",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: white,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Icon(
                                        Icons.star,
                                        color: yellow,
                                        size: 13.sp,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "${hotel.reviewCount} Reviews",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: fontColor,
                                    fontSize: 10.sp,
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
            childCount: bestHotels.length,
          ),
        );
      }
    });
  }
}


// import 'package:get/get.dart';
// import 'package:homesloc/controller/home/home_screen_controller.dart';
// import 'package:homesloc/core/colors/colors.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class FourthHomeBuilder extends StatelessWidget {
//   FourthHomeBuilder({super.key});

//   final HomeScreenController screenController = Get.put(HomeScreenController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (screenController.isLoading.value) {
//         return SliverFillRemaining(
//             child: Center(child: CircularProgressIndicator()));
//       }
//       // else if (screenController.errorMessage.value.isNotEmpty) {
//       //   return SliverFillRemaining(
//       //       child: Center(child: Text(screenController.errorMessage.value)));
//       // }
//        else {
//         return SliverList(
//           delegate: SliverChildBuilderDelegate(
//             (BuildContext context, int index) {
//               final hotel = dummyHotels[index];
//               return Container(
//                 margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
//                 width: 339.w,
//                 height: 138.h,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: border),
//                   borderRadius: BorderRadius.circular(15.sp),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(left: 5.w, top: 2.h),
//                       width: 144.w,
//                       height: 128.h,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(13.sp),
//                         image: DecorationImage(
//                           image: AssetImage(
//                               hotel.image), // Use the same image for all items
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 5.w, top: 11.h),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             hotel.name,
//                             style: TextStyle(
//                               fontFamily: 'Poppins',
//                               color: black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14.sp,
//                             ),
//                           ),
//                           SizedBox(height: 3.h),
//                           Text(
//                             hotel.location,
//                             style: TextStyle(
//                               fontFamily: 'Poppins',
//                               color: fontColor,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 11.sp,
//                             ),
//                           ),
//                           SizedBox(height: 3.h),
//                           Row(
//                             children: [
//                               Text(
//                                 "₹${hotel.offerPrice}",
//                                 style: TextStyle(
//                                   fontFamily: 'Poppins',
//                                   color: black,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14.sp,
//                                 ),
//                               ),
//                               SizedBox(width: 5.w),
//                               Text(
//                                 "₹${hotel.bestPrice}",
//                                 style: TextStyle(
//                                   fontFamily: 'Poppins',
//                                   color: fontColor,
//                                   fontSize: 11.sp,
//                                 ),
//                               ),
//                               SizedBox(width: 5.w),
//                               Text(
//                                 "${hotel.availableRooms}% OFF",
//                                 style: TextStyle(
//                                   fontFamily: 'Poppins',
//                                   color: green,
//                                   fontSize: 11.sp,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 3.h),
//                           Padding(
//                             padding: EdgeInsets.only(left: 7.w),
//                             child: Text(
//                               "+ ₹${hotel.availableRooms} Taxes & Fees",
//                               style: TextStyle(
//                                 fontFamily: 'Poppins',
//                                 color: fontColor,
//                                 fontSize: 11.sp,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 3.h),
//                           Row(
//                             children: [
//                               Text(
//                                 "Amenities : ",
//                                 style: TextStyle(
//                                   fontFamily: 'Poppins',
//                                   color: fontColor,
//                                   fontSize: 11.sp,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 5.w, top: 2.h, right: 3.w),
//                                 child: Icon(
//                                   Icons.ac_unit_rounded,
//                                   size: 11.sp,
//                                   color: fontColor,
//                                 ),
//                               ),
//                               Text(
//                                 "Ac",
//                                 style: TextStyle(
//                                   fontFamily: 'Poppins',
//                                   color: fontColor,
//                                   fontSize: 11.sp,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 5.w, top: 2.h, right: 3.w),
//                                 child: Icon(Icons.tv,
//                                     size: 11.sp, color: fontColor),
//                               ),
//                               Text(
//                                 "Tv",
//                                 style: TextStyle(
//                                   fontFamily: 'Poppins',
//                                   color: fontColor,
//                                   fontSize: 11.sp,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(left: 5.w),
//                                 child: Text(
//                                   "more...",
//                                   style: TextStyle(
//                                     fontFamily: 'Poppins',
//                                     color: ogBlue,
//                                     fontSize: 11.sp,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 3.h),
//                           Row(
//                             children: [
//                               Container(
//                                 width: 44.w,
//                                 height: 18.h,
//                                 decoration: BoxDecoration(
//                                   color: blue,
//                                   borderRadius: BorderRadius.circular(3.sp),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "${hotel.starRating}",
//                                       style: TextStyle(
//                                         fontFamily: 'Poppins',
//                                         color: white,
//                                         fontSize: 10.sp,
//                                       ),
//                                     ),
//                                     SizedBox(width: 2.w),
//                                     Icon(
//                                       Icons.star,
//                                       color: yellow,
//                                       size: 13.sp,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 5.w),
//                               Text(
//                                 "${hotel.reviewCount} Reviews",
//                                 style: TextStyle(
//                                   fontFamily: 'Poppins',
//                                   color: fontColor,
//                                   fontSize: 10.sp,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             childCount: dummyHotels.length,
//           ),
//         );
//       }
//     });
//   }
// }

// class DummyHotel {
//   final String name;
//   final String location;
//   final String bestPrice;
//   final int availableRooms;
//   final int starRating;
//   final int reviewCount;
//   final String image;
//   final double discountPercentage;

//   DummyHotel({
//     required this.name,
//     required this.location,
//     required this.bestPrice,
//     required this.availableRooms,
//     required this.starRating,
//     required this.reviewCount,
//     required this.image,
//     required this.discountPercentage,
//   });

//   String get offerPrice {
//     final double bestPriceValue = double.parse(bestPrice);
//     final double discountAmount = bestPriceValue * (discountPercentage / 100);
//     final double offerPriceValue = bestPriceValue - discountAmount;
//     return offerPriceValue.toStringAsFixed(2);
//   }
// }

// final List<DummyHotel> dummyHotels = [
//   DummyHotel(
//     image: "assets/images/l1.png",
//     name: 'Luxury Resort',
//     location: 'Goa, India',
//     bestPrice: '15000',
//     availableRooms: 20,
//     starRating: 5,
//     reviewCount: 1200,
//     discountPercentage: 20.0,
//   ),
//   DummyHotel(
//     image: "assets/images/m1.jpg",
//     name: 'Mountain Retreat',
//     location: 'Shimla, India',
//     bestPrice: '11000',
//     availableRooms: 15,
//     starRating: 4,
//     reviewCount: 950,
//     discountPercentage: 18.0,
//   ),
//   DummyHotel(
//     image: "assets/images/b1.jpg",
//     name: 'Beachfront Villa',
//     location: 'Maldives',
//     bestPrice: '22000',
//     availableRooms: 10,
//     starRating: 5,
//     reviewCount: 1500,
//     discountPercentage: 18.0,
//   ),
//   DummyHotel(
//     image: "assets/images/image (30).png",
//     name: 'City Center Hotel',
//     location: 'New York, USA',
//     bestPrice: '12000',
//     availableRooms: 25,
//     starRating: 4,
//     reviewCount: 1100,
//     discountPercentage: 17.0,
//   ),
//   DummyHotel(
//     image: "assets/images/image (31).png",
//     name: 'Countryside Cottage',
//     location: 'Tuscany, Italy',
//     bestPrice: '10500',
//     availableRooms: 18,
//     starRating: 4,
//     reviewCount: 1300,
//     discountPercentage: 20.0,
//   ),
// ]; 
