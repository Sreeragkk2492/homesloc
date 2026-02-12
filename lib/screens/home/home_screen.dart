import 'package:homesloc/core/utils/bottom_sheet_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/builder/home_builder/first_home_builder.dart';
import 'package:homesloc/core/widgets/builder/home_builder/fourth_home_builder.dart';
import 'package:homesloc/core/widgets/builder/home_builder/second_home_builder.dart';
import 'package:homesloc/core/widgets/builder/home_builder/third_home_builder.dart';
import 'package:homesloc/core/widgets/home_divider/home_divider.dart';
import 'package:homesloc/core/widgets/logo.dart/logo.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';
import 'package:homesloc/screens/home/widget/hero_section.dart';
import 'package:homesloc/core/controller/bottom_navigation_bar/bottom_bar_controller.dart';
import '../../controller/calender_controller.dart';
import '../../controller/home/home_screen_controller.dart';

// HomeScreen implementation below

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final calendarController = Get.put(CalendarController());
  final TextEditingController locationController = TextEditingController();
  final screenController = Get.put(HomeScreenController());
  final bottomBarController = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: blue,
            elevation: 0,
            automaticallyImplyLeading: false,
            pinned: false,
            // Change to true if you want the AppBar to remain visible at the top when scrolling
            floating: true,
            // Set true to make it appear when scrolling up
            snap: true,
            // Works with `floating` to snap into view
            // expandedHeight: 100.h, // Adjust the height as needed

            title: Logo(),
            actions: [
              Container(
                color: blue,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 15.w, top: 10.h),
                    width: 21.w,
                    height: 21.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/notifications-outline.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                //  SizedBox(height: 5.h),
                HeroSection(
                  onCalendarTap: () =>
                      BottomSheetUtils.showCalendarBottomSheet(context),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20.h,
                          // bottom: 10.h,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              // color: black,
                              height: 105.h,
                              width: MediaQuery.of(context).size.width,
                              child: FirstHomeBuilder(),
                            ),
                          ],
                        ),
                      ),
                      HomeDivider(),
                      NameView(
                        name: 'Best tour packages',
                        color: black,
                        secondName: 'View All',
                        secondColor: black,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 15.h),
                        child: SizedBox(
                          // color: yellow,
                          height: 130.h,
                          // width: MediaQuery.of(context).size.width,
                          child: SecondHomeBuilder(),
                        ),
                      ),
                      HomeDivider(),
                      NameView(
                        name: 'Best wedding deals',
                        color: black,
                        secondName: 'View All',
                        secondColor: black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 195.h,
                        // color: yellow,
                        child: ThirdHomeBuilder(),
                      ),
                      HomeDivider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Get.toNamed('/categorie');
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) {
                                //       return CategorieView();
                                //     }));
                              },
                              child: Container(
                                width: 38.w,
                                height: 33.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  color: gwhite,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/Vector (3).png'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          FourthHomeBuilder(),
        ],
      ),
    );
  }
}
