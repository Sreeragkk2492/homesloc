// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/builder_users/builder_user.dart';
import 'package:homesloc/screens/detailed_view_screen/detailed_view_screen.dart';

class FirstSearchBuilder extends StatelessWidget {
  const FirstSearchBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
           final data = dummyDataList[index];
          return GestureDetector(
            onTap: () {
              Get.to(()=>DetailedViewScreen());
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
                        image: AssetImage(fourthUser[index].img),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, top: 11.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          data.location,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: fontColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Row(
                          children: [
                            Text(
                              data.price,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              data.originalPrice,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: fontColor,
                                fontSize: 11.sp,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              data.discount,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: green,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        Padding(
                          padding: EdgeInsets.only(left: 7.w),
                          child: Text(
                            data.taxes,
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
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 5.w, top: 2.h, right: 3.w),
                              child: Icon(
                                Icons.ac_unit_rounded,
                                size: 11.sp,
                                color: fontColor,
                              ),
                            ),
                            Text(
                              "Ac",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: fontColor,
                                fontSize: 11.sp,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 5.w, top: 2.h, right: 3.w),
                              child:
                                  Icon(Icons.tv, size: 11.sp, color: fontColor),
                            ),
                            Text(
                              "Tv",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: fontColor,
                                fontSize: 11.sp,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.w),
                              child: Text(
                                "more...",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: ogBlue,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
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
                                    data.rating.toString(),
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
                              data.reviews.toString(),
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
        childCount: fourthUser.length,
      ),
    );
  }
}

class DummyData {
  final String img;
  final String title;
  final String location;
  final String originalPrice;
  final String discount;
  final String taxes;
  final List<String> amenities;
  final double rating;
  final int reviews;

  DummyData({
    required this.img,
    required this.title,
    required this.location,
    required this.originalPrice,
    required this.discount,
    required this.taxes,
    required this.amenities,
    required this.rating,
    required this.reviews,
  });

  String get price {
    final double originalPriceValue = double.parse(originalPrice);
    final double discountPercentage = double.parse(discount.replaceAll('% OFF', '').trim()) / 100;
    final double discountAmount = originalPriceValue * discountPercentage;
    final double priceValue = originalPriceValue - discountAmount;
    return priceValue.toStringAsFixed(2);
  }
}

final List<DummyData> dummyDataList = [
  DummyData(
    img: 'assets/images/image (27).png',
    title: 'Issacs Residency',
    location: 'Munnar, Kerala',
    originalPrice: '15000',
    discount: '20% OFF',
    taxes: '+ ₹200 Taxes & Fees',
    amenities: ['Ac', 'Tv', 'Wi-Fi'],
    rating: 4.5,
    reviews: 1200,
  ),
  DummyData(
    img: 'assets/images/image (28).png',
    title: 'Mountain Retreat',
    location: 'Shimla, India',
    originalPrice: '11000',
    discount: '18% OFF',
    taxes: '+ ₹150 Taxes & Fees',
    amenities: ['Heater', 'Tv', 'Room Service'],
    rating: 4.3,
    reviews: 950,
  ),
  DummyData(
    img: 'assets/images/image (29).png',
    title: 'Beachfront Villa',
    location: 'Maldives',
    originalPrice: '22000',
    discount: '18% OFF',
    taxes: '+ ₹300 Taxes & Fees',
    amenities: ['Ac', 'Private Beach', 'Spa'],
    rating: 4.7,
    reviews: 1500,
  ),
  DummyData(
    img: 'assets/images/image (30).png',
    title: 'City Center Hotel',
    location: 'New York, USA',
    originalPrice: '12000',
    discount: '17% OFF',
    taxes: '+ ₹200 Taxes & Fees',
    amenities: ['Ac', 'Tv', 'Gym'],
    rating: 4.4,
    reviews: 1100,
  ),
  DummyData(
    img: 'assets/images/image (31).png',
    title: 'Countryside Cottage',
    location: 'Tuscany, Italy',
    originalPrice: '10500',
    discount: '20% OFF',
    taxes: '+ ₹150 Taxes & Fees',
    amenities: ['Heater', 'Kitchen', 'Garden'],
    rating: 4.6,
    reviews: 1300,
  ),
];
