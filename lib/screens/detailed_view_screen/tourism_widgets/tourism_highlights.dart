import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/tourism/tourism_detail_model.dart';
import 'package:homesloc/core/widgets/name_view/name_view.dart';

class PackageHighlightsSection extends StatelessWidget {
  final List<TripAttraction>? attractions;
  final List<TripExclusion>? exclusions;

  const PackageHighlightsSection(
      {super.key, this.attractions, this.exclusions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NameView(
          name: "Trip Highlights",
          color: blue,
          secondName: 'View All',
          secondColor: blue,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (attractions != null)
                ...attractions!.map((e) => _buildCheckItem(
                    e.attractions ?? '', Icons.star_rounded, yellow)),
              if (exclusions != null && exclusions!.isNotEmpty) ...[
                SizedBox(height: 20.h),
                Text('Exclusions',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: blue,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                ...exclusions!.map((e) => _buildCheckItem(e.exclusions ?? '',
                    Icons.cancel_outlined, Colors.red.shade300)),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckItem(String text, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18.sp),
          SizedBox(width: 12.w),
          Expanded(
              child: Text(text,
                  style: TextStyle(
                      fontFamily: 'Poppins', fontSize: 13.sp, color: black))),
        ],
      ),
    );
  }
}
