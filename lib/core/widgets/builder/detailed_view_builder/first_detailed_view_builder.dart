// ignore_for_file: file_names, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/builder_users/detailed_view_user/detailed_view_user.dart';

class FirstDetailedViewBuilder extends StatelessWidget {

  final dynamic hotel;
  const FirstDetailedViewBuilder({super.key,this.hotel});

  @override
  Widget build(BuildContext context) {
    // // Check if hotel is null or has no rooms
    // if (hotel == null || hotel.rooms == null || hotel.rooms.isEmpty) {
    //   return Center(
    //     child: Text(
    //       'No room images available',
    //       style: TextStyle(
    //         fontFamily: 'Poppins',
    //         color: fontColor,
    //         fontSize: 12.sp,
    //       ),
    //     ),
    //   );
    // }
    //
    // // Get the first room's images
    // final roomImages = hotel.rooms[0].roomImages;
    //
    // // Check if room images exist
    // if (roomImages == null || roomImages.isEmpty) {
    //   return Center(
    //     child: Text(
    //       'No room images available',
    //       style: TextStyle(
    //         fontFamily: 'Poppins',
    //         color: fontColor,
    //         fontSize: 12.sp,
    //       ),
    //     ),
    //   );
    // }

      // Check if firstDetailedViewUser is empty
      if (firstDetailedViewUser.isEmpty) {
        return Center(
          child: Text(
            'No images available',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: fontColor,
              fontSize: 12.sp,
            ),
          ),
        );
      }
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: firstDetailedViewUser.length,
      itemBuilder: (context, index) {
        final firstDetailedViewUserItem = firstDetailedViewUser[index];
        return Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              height: 70.h,
              width: 80.w,
              decoration: BoxDecoration(
                // color: blue,
                borderRadius: BorderRadius.circular(10.sp),
                image: DecorationImage(
                    image: AssetImage(firstDetailedViewUserItem.img),

                    fit: BoxFit.cover),
              ),
            )
          ],
        );
      },
    );
  }
}
