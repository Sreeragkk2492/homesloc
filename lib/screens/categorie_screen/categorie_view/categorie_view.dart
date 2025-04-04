// ignore_for_file: file_names, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/screens/home/home_screen.dart';
import 'package:homesloc/screens/search_screen/search_screen.dart';
import 'package:homesloc/core/controller/bottom_navigation_bar/new_navigation.dart';
import 'package:homesloc/core/widgets/builder/categorie_builder/categorie_view_builder/categorie_view_builder.dart';
import 'package:homesloc/core/widgets/logo.dart/logo.dart';
import 'package:homesloc/core/widgets/logo.dart/second_logo.dart';
import 'package:homesloc/core/widgets/view_all_button/view_all_button.dart';

class CategorieView extends StatelessWidget {
  const CategorieView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(top: 5.h),
        color: white,
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchScreen();
                }));
              },
              child: NewNavigation(
                name: 'Search',
                icon: 'assets/images/Frame (3).png',
                iconColor: Color(0xff999999),
                nameColor: Color(0xff999999),
              ),
            ),
            NewNavigation(
              name: 'Category',
              icon: 'assets/images/Frame (4).png',
              iconColor: blue,
              nameColor: blue,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }));
              },
              child: NewNavigation(
                name: 'Home',
                icon: 'assets/images/Frame (5).png',
                iconColor: Color(0xff999999),
                nameColor: Color(0xff999999),
              ),
            ),
            NewNavigation(
              name: 'Favourite',
              icon: 'assets/images/Frame (6).png',
              iconColor: Color(0xff999999),
              nameColor: Color(0xff999999),
            ),
            NewNavigation(
              name: 'Settings',
              icon: 'assets/images/Frame (7).png',
              iconColor: Color(0xff999999),
              nameColor: Color(0xff999999),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: white,
            size: 20.sp,
          ),
        ),
        backgroundColor: blue,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15.w, top: 1.h),
            width: 21.w,
            height: 21.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/notifications-outline.png'),
                  fit: BoxFit.cover),
            ),
          ),
        ],
        title: Padding(
          padding: EdgeInsets.only(left: 36.w, bottom: 7.h),
          child: SecondLog(),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 98.h,
              width: MediaQuery.of(context).size.width,
              color: blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 334.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: gblue,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 13.w, top: 15.h),
                            child: Text(
                              "Hotels in munnar",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: poppinsFont,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                          Positioned(
                            right: 120.w,
                            bottom: 2.h,
                            child: Text(
                              '|',
                              style: TextStyle(
                                color: poppinsFont,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 15.w,
                            top: 8.h,
                            child: Text(
                              "25 oct - 26 oct",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: poppinsFont,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                          Positioned(
                            right: 28.w,
                            top: 24.h,
                            child: Text(
                              "2 guest, 1 room",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: poppinsFont,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30.h,
                          width: 105.w,
                          decoration: BoxDecoration(
                            color: gblue,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sort",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: poppinsFont,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w100),
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Image(
                                image: AssetImage('assets/images/Frame.png'),
                                color: white,
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 30.h,
                          width: 105.w,
                          decoration: BoxDecoration(
                            color: gblue,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Price",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: poppinsFont,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w100),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 20.sp,
                                color: poppinsFont,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30.h,
                          width: 105.w,
                          decoration: BoxDecoration(
                            color: gblue,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Filter",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: poppinsFont,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w100),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Image(
                                image: AssetImage(
                                  'assets/images/Frame (2).png',
                                ),
                                width: 13.w,
                                height: 13.h,
                                color: white,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search result",
                    style: TextStyle(
                        color: black, fontFamily: 'Poppins', fontSize: 13.sp),
                  ),
                  SizedBox(
                    width: 80.w,
                  ),
                  Image(
                    image: AssetImage('assets/images/Frame 427320679.png'),
                    color: black,
                    width: 28.w,
                    height: 28.h,
                  ),
                  Container(
                    width: 22.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: gwhite,
                      borderRadius: BorderRadius.circular(3.sp),
                    ),
                    child: Image(
                      image: AssetImage('assets/images/Vector (6).png'),
                      color: black,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                  Text(
                    "Filter result",
                    style: TextStyle(
                        color: black, fontFamily: 'Poppins', fontSize: 13.sp),
                  ),
                ],
              ),
            ),
            CategorieViewBuilder(
              image: 'assets/images/image (29).png',
            ),
            CategorieViewBuilder(
              image: 'assets/images/image (30).png',
            ),
            CategorieViewBuilder(
              image: 'assets/images/image (31).png',
            ),
            CategorieViewBuilder(
              image: 'assets/images/image (32).png',
            ),
            CategorieViewBuilder(
              image: 'assets/images/image (30).png',
            ),
            CategorieViewBuilder(
              image: 'assets/images/image (29).png',
            ),
            CategorieViewBuilder(
              image: 'assets/images/image (31).png',
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchScreen();
                }));
              },
              child: ViewAllButton(),
            ),
            Container(
              height: 30.h,
              width: 10.w,
              color: white,
            )
          ],
        ),
      ),
    );
  }
}
