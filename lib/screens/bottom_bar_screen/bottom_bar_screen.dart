// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/controller/bottom_navigation_bar/bottom_bar_controller.dart';
import 'package:homesloc/core/controller/bottom_navigation_bar/new_navigation.dart';
import 'package:homesloc/screens/categorie_screen/categorie_screen.dart';
import 'package:homesloc/screens/home/home_screen.dart';
import 'package:homesloc/screens/profile_screen/profile_screen.dart';
import 'package:homesloc/screens/search_screen/search_screen.dart';

class BottomBarScreen extends StatelessWidget {
  BottomBarScreen({super.key});

  final BottomBarController controller = Get.put(BottomBarController());

  final List<Widget> _pages = [
    
    SearchScreen(),
    CategorieSreen(),
    HomeScreen(),
    SearchScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _pages[controller.selectedPageIndex.value];
      }),
      bottomNavigationBar: Container(
        color: white,
        height: 60.h,
        child: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  controller.updateSelectedPageIndex(0);
                },
                child: Obx(() {
                  return NewNavigation(
                    name: 'Search',
                    icon: 'assets/images/Frame (3).png',
                    iconColor: controller.selectedPageIndex.value == 0
                        ? blue
                        : Color(0xff999999),
                    nameColor: controller.selectedPageIndex.value == 0
                        ? blue
                        : Color(0xff999999),
                  );
                }),
              ),
              InkWell(
                onTap: () {
                  controller.updateSelectedPageIndex(1);
                },
                child: Obx(() {
                  return NewNavigation(
                    name: 'Category',
                    icon: 'assets/images/Frame (4).png',
                    iconColor: controller.selectedPageIndex.value == 1
                        ? blue
                        : Color(0xff999999),
                    nameColor: controller.selectedPageIndex.value == 1
                        ? blue
                        : Color(0xff999999),
                  );
                }),
              ),
              InkWell(
                onTap: () {
                  controller.updateSelectedPageIndex(2);
                },
                child: Obx(() {
                  return NewNavigation(
                    name: 'Home',
                    icon: 'assets/images/Frame (5).png',
                    iconColor: controller.selectedPageIndex.value == 2
                        ? blue
                        : Color(0xff999999),
                    nameColor: controller.selectedPageIndex.value == 2
                        ? blue
                        : Color(0xff999999),
                  );
                }),
              ),
              InkWell(
                onTap: () {
                  controller.updateSelectedPageIndex(3);
                },
                child: Obx(() {
                  return NewNavigation(
                    name: 'Favourite',
                    icon: 'assets/images/Frame (6).png',
                    iconColor: controller.selectedPageIndex.value == 3
                        ? blue
                        : Color(0xff999999),
                    nameColor: controller.selectedPageIndex.value == 3
                        ? blue
                        : Color(0xff999999),
                  );
                }),
              ),
              InkWell(
                onTap: () {
                  controller.updateSelectedPageIndex(4);
                },
                child: Obx(() {
                  return NewNavigation(
                    name: 'Settings',
                    icon: 'assets/images/Frame (7).png',
                    iconColor: controller.selectedPageIndex.value == 4
                        ? blue
                        : Color(0xff999999),
                    nameColor: controller.selectedPageIndex.value == 4
                        ? blue
                        : Color(0xff999999),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
