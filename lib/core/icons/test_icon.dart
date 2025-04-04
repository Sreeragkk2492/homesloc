// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/icons/category_icon.dart';
import 'package:homesloc/core/icons/search_icon.dart';

class Testicon extends StatelessWidget {
  const Testicon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Pradhul"),
          Text("Pradhul"),
          Text("Pradhul"),
          Text("Pradhul"),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.abc),
          )
          // SearchIcon(),
          // CategoryIcon(),
        ],
      ),
    );
  }
}
