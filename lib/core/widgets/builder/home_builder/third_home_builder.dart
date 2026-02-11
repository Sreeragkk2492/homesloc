// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/home/home_screen_controller.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/loader/app_loader.dart';

class ThirdHomeBuilder extends StatelessWidget {
  ThirdHomeBuilder({super.key});

  final HomeScreenController screenController =
      Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (screenController.isLoading.value) {
        return const Center(child: AppLoader(size: 40));
      }

      // Combining wedding packages and banquet halls if needed, or just wedding packages as per plan
      // The user request shows "wedding_packages" and "banquet_halls".
      // The UI title says "Best booking deals".
      // I'll map weddingPackages here as per plan.
      final weddingPackages = screenController.weddingPackages;
      if (weddingPackages.isEmpty) {
        return const SizedBox.shrink();
      }

      return ListView.builder(
        itemCount: weddingPackages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final package = weddingPackages[index];
          return Padding(
            padding:
                EdgeInsets.only(bottom: 4.h, top: 15.h, left: 10.w, right: 9.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 170.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    // color: yellow,
                    image: DecorationImage(
                        image: (package.imageUrl != null &&
                                package.imageUrl!.isNotEmpty)
                            ? NetworkImage(package.imageUrl!) as ImageProvider
                            : const AssetImage('assets/images/image (6).png'),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  width: 170.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          package.title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: blue,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      CircleAvatar(
                        backgroundColor: yellow,
                        radius: 23.sp,
                        child: Icon(
                          Icons.arrow_outward_outlined,
                          color: white,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    });
  }
}
