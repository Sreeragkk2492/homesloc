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
    HomeScreen(),
    SearchScreen(),
    // CategorieSreen(),

    // SearchScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (controller.selectedPageIndex.value != 0) {
          // If not on Home tab, switch to Home tab
          controller.updateSelectedPageIndex(0);
        } else {
          // If on Home tab, allow the app to be closed
          // Use Navigator.of(context).pop() or similar if this is a nested navigator
          // But since this is likely the root, we might need a different approach to actually "exit"
          // However, setting canPop based on index or using SystemNavigator.pop() is common.
          // For now, let's try to allow the pop by checking the index.
          // Note: In modern Flutter, you might need to manage canPop dynamically.
        }
      },
      child: Obx(() => PopScope(
            canPop: controller.selectedPageIndex.value == 0,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              if (controller.selectedPageIndex.value != 0) {
                controller.updateSelectedPageIndex(0);
              }
            },
            child: SafeArea(
              top: false,
              child: Scaffold(
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
                              name: 'Home',
                              icon: 'assets/images/Frame (5).png',
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
                              name: 'Search',
                              icon: 'assets/images/Frame (3).png',
                              iconColor: controller.selectedPageIndex.value == 1
                                  ? blue
                                  : Color(0xff999999),
                              nameColor: controller.selectedPageIndex.value == 1
                                  ? blue
                                  : Color(0xff999999),
                            );
                          }),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     controller.updateSelectedPageIndex(1);
                        //   },
                        //   child: Obx(() {
                        //     return NewNavigation(
                        //       name: 'Category',
                        //       icon: 'assets/images/Frame (4).png',
                        //       iconColor: controller.selectedPageIndex.value == 1
                        //           ? blue
                        //           : Color(0xff999999),
                        //       nameColor: controller.selectedPageIndex.value == 1
                        //           ? blue
                        //           : Color(0xff999999),
                        //     );
                        //   }),
                        // ),
              
                        // InkWell(
                        //   onTap: () {
                        //     controller.updateSelectedPageIndex(3);
                        //   },
                        //   child: Obx(() {
                        //     return NewNavigation(
                        //       name: 'Favourite',
                        //       icon: 'assets/images/Frame (6).png',
                        //       iconColor: controller.selectedPageIndex.value == 3
                        //           ? blue
                        //           : Color(0xff999999),
                        //       nameColor: controller.selectedPageIndex.value == 3
                        //           ? blue
                        //           : Color(0xff999999),
                        //     );
                        //   }),
                        // ),
                        InkWell(
                          onTap: () {
                            controller.updateSelectedPageIndex(2);
                          },
                          child: Obx(() {
                            return NewNavigation(
                              name: 'Settings',
                              icon: 'assets/images/Frame (7).png',
                              iconColor: controller.selectedPageIndex.value == 2
                                  ? blue
                                  : Color(0xff999999),
                              nameColor: controller.selectedPageIndex.value == 2
                                  ? blue
                                  : Color(0xff999999),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
