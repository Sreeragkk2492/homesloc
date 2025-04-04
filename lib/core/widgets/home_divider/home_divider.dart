// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

class HomeDivider extends StatelessWidget {
  const HomeDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return     Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  child: Divider(
                    indent: 10.w,
                    endIndent: 10.w,
                    color: grey,
                  ),
                );
  }
}