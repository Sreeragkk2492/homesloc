// ignore_for_file: file_names, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/home/hotel_detail_model.dart';
import 'package:homesloc/models/home/homescreen_model.dart';
import 'package:homesloc/core/widgets/gallery/full_screen_image_viewer.dart';

class FirstDetailedViewBuilder extends StatelessWidget {
  final dynamic hotel;
  const FirstDetailedViewBuilder({super.key, this.hotel});

  @override
  Widget build(BuildContext context) {
    List<String> images = [];

    if (hotel is HotelDetailModel) {
      images = hotel.galleryImages ?? [];
    } else if (hotel is BanquetHall) {
      images = hotel.imageUrl != null ? [hotel.imageUrl!] : [];
    } else if (hotel != null) {
      try {
        images = List<String>.from(hotel.galleryImages ?? []);
      } catch (e) {
        print('Error extracting gallery images: $e');
      }
    }

    List<String> allImages = [];
    if (hotel is HotelDetailModel) {
      if (hotel.coverImageUrl != null) allImages.add(hotel.coverImageUrl!);
      if (hotel.galleryImages != null) allImages.addAll(hotel.galleryImages!);
    } else if (hotel is BanquetHall) {
      if (hotel.imageUrl != null) allImages.add(hotel.imageUrl!);
    } else {
      try {
        if (hotel.coverImageUrl != null) allImages.add(hotel.coverImageUrl);
        if (hotel.galleryImages != null) {
          allImages.addAll(List<String>.from(hotel.galleryImages));
        }
      } catch (e) {
        allImages.add('assets/images/l1.png');
      }
    }
    if (allImages.isEmpty) allImages.add('assets/images/l1.png');

    if (images.isEmpty) {
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
      itemCount: images.length,
      itemBuilder: (context, index) {
        final imageUrl = images[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenImageViewer(
                  images: allImages,
                  initialIndex: allImages.indexOf(imageUrl),
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
            height: 75.h,
            width: 85.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: border, width: 1),
              image: DecorationImage(
                image: imageUrl.startsWith('http')
                    ? NetworkImage(imageUrl)
                    : AssetImage(imageUrl) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
