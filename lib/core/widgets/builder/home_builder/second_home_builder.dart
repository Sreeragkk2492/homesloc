// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/home/home_screen_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/loader/app_loader.dart';

class SecondHomeBuilder extends StatelessWidget {
  SecondHomeBuilder({super.key});

  final HomeScreenController screenController =
      Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (screenController.isLoading.value) {
        return const Center(child: AppLoader(size: 40));
      }

      final tourPackages = screenController.tourPackages;
      if (tourPackages.isEmpty) {
        return const SizedBox.shrink();
      }

      return ListView.builder(
        itemCount: tourPackages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final package = tourPackages[index];
          return Padding(
            padding: EdgeInsets.only(left: 10.w, right: 9.w, top: 5.h),
            child: Stack(
              children: [
                Container(
                  width: 170.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    // color: black,
                    image: DecorationImage(
                        image: (package.imageUrl != null &&
                                package.imageUrl!.isNotEmpty)
                            ? NetworkImage(package.imageUrl!) as ImageProvider
                            : const AssetImage(
                                'assets/images/34242665a695e6c15c2a531723032576.png'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 13.w, top: 18.h),
                    child: Text(
                      package.title ?? "",
                      style: TextStyle(
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.bold,
                          color: white),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.h,
                  right: 18.w,
                  child: CircleAvatar(
                    backgroundColor: yellow,
                    radius: 23.sp,
                    child: Icon(
                      Icons.arrow_outward_outlined,
                      color: white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
