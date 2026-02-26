// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';

import 'package:homesloc/controller/search/search_hotel_controller.dart';
import 'package:get/get.dart';

class SearchForm extends StatelessWidget {
  SearchForm({super.key});

  final SearchHotelController searchHotelController =
      Get.find<SearchHotelController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 334.w,
      child: Autocomplete<String>(
        initialValue:
            TextEditingValue(text: searchHotelController.location.value),
        optionsBuilder: (TextEditingValue textEditingValue) async {
          if (textEditingValue.text.length < 2) {
            return const Iterable<String>.empty();
          }
          searchHotelController.location.value =
              textEditingValue.text; // Update as they type
          return await searchHotelController
              .fetchLocationSuggestions(textEditingValue.text);
        },
        onSelected: (String selection) {
          searchHotelController.location.value = selection;
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted) {
          // Connect the internal Autocomplete controller to our global list
          // so we can clear all of them remotely from searchHotels()
          searchHotelController
              .registerLocationController(fieldTextEditingController);

          return TextFormField(
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: white,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: white,
              ),
              hintText: 'search property or location ...',
              hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: poppinsFont,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w100),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: gblue),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: gblue),
                borderRadius: BorderRadius.circular(10.sp),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: gblue),
              ),
              fillColor: gblue,
              filled: true,
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              color: const Color(0xffa8d1e0), // Color from the web UI reference
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.sp),
                bottomRight: Radius.circular(8.sp),
              ),
              child: SizedBox(
                width: 334.w,
                height: options.length > 4 ? 200.h : (options.length * 50.h),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return InkWell(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        child: Text(
                          option,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black87,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
