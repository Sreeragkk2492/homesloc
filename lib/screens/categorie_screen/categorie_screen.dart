// ignore_for_file: file_names, unused_import
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homesloc/screens/home/hotel_search_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/categorie_screen/categorie_view/categorie_view.dart';
import 'package:homesloc/screens/home/home_screen.dart';
import 'package:homesloc/screens/search_screen/search_screen.dart';
import 'package:homesloc/core/controller/bottom_navigation_bar/new_navigation.dart';
import 'package:homesloc/core/widgets/builder/categorie_builder/eighth_categorie_builder.dart';
import 'package:homesloc/core/widgets/builder/categorie_builder/fifth_categorie_builder.dart';
import 'package:homesloc/core/widgets/builder/categorie_builder/ninth_categorie_builder.dart';
import 'package:homesloc/core/widgets/builder/categorie_builder/seventh_categorie_builder.dart';
import 'package:homesloc/core/widgets/builder/categorie_builder/sixth_categorie_builder.dart';
import 'package:homesloc/core/widgets/builder_users/builder_user.dart';
import 'package:homesloc/core/widgets/categories_second/categories_second.dart';
import 'package:homesloc/core/widgets/categories_view/categories_view.dart';
import 'package:homesloc/core/widgets/categories_view/grid_view/categories_grid_page.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/logo.dart/logo.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/core/widgets/search_form/search_form.dart';

class CategorieSreen extends StatelessWidget {
  const CategorieSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: blue,
            automaticallyImplyLeading: false,
            pinned:
                false, // Change to true if you want the AppBar to remain visible at the top when scrolling
            floating: true, // Set true to make it appear when scrolling up
            snap: true, // Works with `floating` to snap into view
            // expandedHeight: 100.h, // Adjust the height as needed
            title: Logo(),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 15.w, top: 3.h),
                width: 21.w,
                height: 21.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/notifications-outline.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: blue,
                  width: double.infinity,
                  height: 60.h,
                  child: Column(
                    children: [SearchForm()],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Main categories",
                            style: TextStyle(
                                color: blue,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp),
                          ),
                          Container(
                            width: 24.w,
                            height: 22.h,
                            decoration: BoxDecoration(
                              color: gwhite,
                              borderRadius: BorderRadius.circular(5.sp),
                            ),
                            child: Center(
                              child: Text(
                                "8",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: black,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Container(
                        //   width: 500.w,
                        //   height: 200.h,
                        //   child: CategoriesGridPage()),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => HotelSearchScreen());
                          },
                          child: CategoriesView(
                            image: 'assets/images/hotsls.jpg',
                            categories: 'Hotels',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => HotelSearchScreen());
                          },
                          child: CategoriesView(
                            image: 'assets/images/Banquet-Hall.jpg',
                            categories: 'Banquet Hall',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => HotelSearchScreen());
                          },
                          child: CategoriesView(
                            image: 'assets/images/sunrise.jpg',
                            categories: 'Tour',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => HotelSearchScreen());
                          },
                          child: CategoriesView(
                            image: 'assets/images/freshupss.jpg',
                            categories: 'Fresh Up',
                          ),
                        ),

                        // CategoriesView(
                        //   image: 'assets/images/image (3).png',
                        //   categories: 'Tourism Package',
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     CategoriesView(
                    //       image: 'assets/images/image (14).png',
                    //       categories: 'Cruise',
                    //     ),
                    //     CategoriesView(
                    //       image: 'assets/images/image (15).png',
                    //       categories: 'Tour',
                    //     ),
                    //     CategoriesView(
                    //       image: 'assets/images/image (16).png',
                    //       categories: 'Nearby Spots',
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Divider(
                        indent: 10.w,
                        endIndent: 10.w,
                        color: grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Deals section",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: blue,
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 100.w,
                          ),
                          Container(
                            width: 55.w,
                            height: 22.h,
                            decoration: BoxDecoration(
                                color: gwhite,
                                borderRadius: BorderRadius.circular(4.sp)),
                            child: Center(
                              child: Text(
                                "View All",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: black,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 15.h),
                      child: SizedBox(
                        // color: yellow,`
                        height: 130.h,
                        // width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: secondUser.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 9.w),
                              child: Row(
                                children: [
                                  Container(
                                    width: 170.w,
                                    height: 120.h,
                                    decoration: BoxDecoration(
                                      // color: black,
                                      image: DecorationImage(
                                          image:
                                              AssetImage(secondUser[index].img),
                                          fit: BoxFit.cover),
                                      borderRadius:
                                          BorderRadius.circular(15.sp),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 13.w, top: 18.h),
                                          child: Text(
                                            secondUser[index].category,
                                            style: TextStyle(
                                                fontFamily: 'RobotoSlab',
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return CategorieView();
                                            }));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 90.w, top: 10.h),
                                            child: Center(
                                              child: Container(
                                                height: 44.h,
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                  color: yellow,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          33.sp),
                                                ),
                                                child: Icon(
                                                  Icons.arrow_outward_outlined,
                                                  color: white,
                                                  size: 22.sp,
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
                            );
                          },
                        ),
                      ),
                    ),
                    Divider(
                      indent: 10.w,
                      endIndent: 10.w,
                      color: grey,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, top: 10.h),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Best hotel stay deals",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: blue,
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 80.w,
                          ),
                          Container(
                            width: 55.w,
                            height: 22.h,
                            decoration: BoxDecoration(
                                color: gwhite,
                                borderRadius: BorderRadius.circular(4.sp)),
                            child: Center(
                              child: Text(
                                "View All",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: black,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CategoriesSecond(
                            subName: 'Luxury by the Lakeside',
                            image: 'assets/images/serene.jpg',
                            text: 'The Serene\nHaven',
                          ),
                          CategoriesSecond(
                            subName: 'Elegance in the Hills',
                            image: 'assets/images/image (18).png',
                            text: 'The Golden\nRetreat',
                          ),
                          CategoriesSecond(
                            subName: 'Beachfront Bliss',
                            image: 'assets/images/image (17).png',
                            text: 'The Azure\nHorizon',
                          ),
                          // CategoriesSecond(
                          //   subName: 'Mountain Escape',
                          //   image: 'assets/images/image (17).png',
                          //   text: 'The Majestic\nPeaks',
                          // ),
                          // CategoriesSecond(
                          //   subName: 'Desert Serenity',
                          //   image: 'assets/images/image (17).png',
                          //   text: 'The Tranquil\nOasis',
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Divider(
                        indent: 10.w,
                        endIndent: 10.w,
                        color: grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Houseboat / Cruise deals",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: blue,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Container(
                            width: 55.w,
                            height: 22.h,
                            decoration: BoxDecoration(
                                color: gwhite,
                                borderRadius: BorderRadius.circular(4.sp)),
                            child: Center(
                              child: Text(
                                "View All",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: black,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CategoriesSecond(
                            subName:
                                'Experience the epitome\nof luxury on the water.',
                            image: 'assets/images/luxy.jpg',
                            text: 'Luxury Cruises',
                          ),
                          CategoriesSecond(
                            subName:
                                'Ideal for family vacations\nwith spacious living.',
                            image: 'assets/images/image (20).png',
                            text: 'Family Houseboats',
                          ),
                          // CategoriesSecond(
                          //   subName:
                          //       'Explore exotic destinations\nand enjoy thrilling adventures.',
                          //   image: 'assets/images/image (17).png',
                          //   text: 'Adventure Cruises',
                          // ),
                          // CategoriesSecond(
                          //   subName:
                          //       'Ideal for couples seeking a\nromantic and private getaway.',
                          //   image: 'assets/images/image (17).png',
                          //   text: 'Romantic Houseboats',
                          // ),
                          // CategoriesSecond(
                          //   subName:
                          //       'Sustainable travel options\nfor eco-conscious travelers.',
                          //   image: 'assets/images/image (17).png',
                          //   text: 'Eco-Friendly Cruises',
                          // ),
                        ],
                      ),
                    ),
                    HomeDivider(),
                    NameView(
                      name: 'Wedding tourism spots',
                      color: blue,
                      secondName: 'View All',
                      secondColor: black,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => HotelSearchScreen());
                            },
                            child: FifthCategorieBuilder(
                              image: 'assets/images/image (21).png',
                              text: 'Destination\nWeddings',
                              subname:
                                  'Perfect for dream weddings\nin exotic locations.',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => HotelSearchScreen());
                            },
                            child: FifthCategorieBuilder(
                              image: 'assets/images/image (22).png',
                              text: 'Honeymoon\nPackages',
                              subname: 'Romantic getaways\nfor newlyweds.',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => HotelSearchScreen());
                            },
                            child: FifthCategorieBuilder(
                              image: 'assets/images/image (21).png',
                              text: 'Wedding\nVenues',
                              subname:
                                  'Beautiful venues for\nyour special day.',
                            ),
                          ),
                        ],
                      ),
                    ),
                    HomeDivider(),
                    NameView(
                      name: 'Banquet hall booking',
                      color: blue,
                      secondName: 'View All',
                      secondColor: black,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => HotelSearchScreen());
                            },
                            child: SixthCategorieBuilder(
                              image: 'assets/images/image (23).png',
                              text: 'Luxury Banquet\nHalls',
                              subName: 'Elegant venues\nfor grand events.',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => HotelSearchScreen());
                            },
                            child: SixthCategorieBuilder(
                              image: 'assets/images/image (24).png',
                              text: 'Affordable Banquet\nHalls',
                              subName:
                                  'Budget-friendly venues\nfor all occasions.',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => HotelSearchScreen());
                            },
                            child: SixthCategorieBuilder(
                              image: 'assets/images/outoor.jpg',
                              text: 'Outdoor Banquet\nHalls',
                              subName: 'Beautiful outdoor\nspaces for events.',
                            ),
                          ),
                        ],
                      ),
                    ),
                    HomeDivider(),
                    NameView(
                      name: 'Experience packs',
                      color: blue,
                      secondName: 'View All',
                      secondColor: black,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => HotelSearchScreen());
                            },
                            child: EighthCategorieBuilder(
                              image: 'assets/images/image (25).png',
                              text: 'Adventure\nPackages',
                              // subName: 'Thrilling adventures for the daring.',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => HotelSearchScreen());
                            },
                            child: EighthCategorieBuilder(
                              image: 'assets/images/image (26).png',
                              text: 'Cultural\nTours',
                              // subName: 'Immerse yourself in local culture.',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => HotelSearchScreen());
                            },
                            child: EighthCategorieBuilder(
                              image: 'assets/images/image (25).png',
                              text: 'Wellness\nRetreats',
                              //  subName: 'Relax and rejuvenate in serene settings.',
                            ),
                          ),
                        ],
                      ),
                    ),
                    HomeDivider(),
                    NameView(
                      name: 'Where to go',
                      color: blue,
                      secondName: 'View All',
                      secondColor: black,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => HotelSearchScreen());
                            },
                            child: NinthCategorieBuilder(
                              image: 'assets/images/wayanad.png',
                              location: 'Wayanad',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => HotelSearchScreen());
                            },
                            child: NinthCategorieBuilder(
                              image: 'assets/images/cameltrip.png',
                              location: 'Camel Trip',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => HotelSearchScreen());
                            },
                            child: NinthCategorieBuilder(
                              image: 'assets/images/Rajasthyan.png',
                              location: 'Rajastan',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
