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
        displayStringForOption: (String option) => option,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }
          searchHotelController.location.value = textEditingValue.text;

          final suggestions = await searchHotelController
              .fetchLocationSuggestions(textEditingValue.text);

          return suggestions.where((String option) => true);
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
              color: white, // White background for clean look like web
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.sp),
                bottomRight: Radius.circular(8.sp),
              ),
              child: SizedBox(
                width: 334.w,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 250.h),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true, // Wrap to content
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return InkWell(
                        onTap: () {
                          onSelected(option);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: grey.withOpacity(0.2),
                                width: 0.5,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined,
                                  size: 16.sp, color: grey),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black87,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
