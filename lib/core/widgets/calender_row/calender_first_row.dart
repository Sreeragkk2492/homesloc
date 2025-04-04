import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/builder_users/builder_user.dart';

class CalenderFirstRow extends StatelessWidget {
  const CalenderFirstRow({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: fifthUser.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Row(
            children: [
              Container(
                width: 150.w,
                height: 80.h,
                decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(8.r),
                    image: DecorationImage(
                        image: AssetImage(fifthUser[index].img),
                        fit: BoxFit.cover)),
              ),
            ],
          ),
        );
      },
    );
  }
}
