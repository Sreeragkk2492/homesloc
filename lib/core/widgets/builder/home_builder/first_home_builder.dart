// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/builder_users/builder_user.dart';
import 'package:homesloc/screens/home/freshup_search_screeen.dart';
import 'package:homesloc/screens/home/hall_search_screen.dart';

import 'package:homesloc/screens/home/hotel_search_screen.dart';
import 'package:homesloc/screens/home/tourism_search_screen.dart';

class FirstHomeBuilder extends StatelessWidget {
  const FirstHomeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: firstUser.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to different screens based on category
                  switch (firstUser[index].category) {
                    case "Hotels":
                      Get.to(() => HotelSearchScreen());
                      break;
                    case "Banquet Hall":
                      // Navigate to Banquet Hall search screen
                      Get.to(() => HallSearchScreen()); 
                      break;
                    case "Fresh Up":
                      // Navigate to Fresh Up search screen
                      Get.to(() => FreshUpSearchScreen());
                      break;
                    case "Tourism Package":
                      // Navigate to Tourism Package search screen
                      Get.to(() => TourismPackageSearchScreen());
                      break;
                    default:
                      // Default navigation for any other category
                      Get.to(() => CategorySearchScreen(category: firstUser[index].category));
                      break;
                  }
                },
                child: Container(
                  height: 80.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    image: DecorationImage(
                        image: AssetImage(firstUser[index].img),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                firstUser[index].category,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: black,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        );
      },
    );
  }
}

// Placeholder screens for different categories






class CategorySearchScreen extends StatelessWidget {
  final String category;
  
  const CategorySearchScreen({Key? key, required this.category}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category Search'),
        backgroundColor: blue,
      ),
      body: Center(
        child: Text('$category Search Screen'),
      ),
    );
  }
}
