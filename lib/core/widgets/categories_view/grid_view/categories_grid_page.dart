// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/widgets/categories_view/categories_view.dart';

class CategoriesGridPage extends StatelessWidget {
  final List<Map<String, String>> categoriesData = [
    {'image': 'assets/images/image.png', 'categories': 'Trip package'},
    {'image': 'assets/images/image (1).png', 'categories': 'Banquet hall'},
    {'image': 'assets/images/image (2).png', 'categories': 'Houseboat'},
    {'image': 'assets/images/image (3).png', 'categories': 'Wedding'},
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Change to a lower value
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
          childAspectRatio: 1, // Adjust aspect ratio as needed
        ),
        itemCount: categoriesData.length,
        itemBuilder: (context, index) {
          return CategoriesView(
            image: categoriesData[index]['image']!,
            categories: categoriesData[index]['categories']!,
          );
        },
      ),
    );
  }
}
