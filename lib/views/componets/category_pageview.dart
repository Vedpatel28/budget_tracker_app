// ignore_for_file: camel_case_types, must_be_immutable

import 'package:budget_tracker_app/controllers/category_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class category_pageView extends StatelessWidget {
  category_pageView({super.key});

  CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Form(
            child: Container(
              height: 720,
              child: ListView(
                  children: [
                    Text(
                      "Remark",
                      style: GoogleFonts.festive(fontSize: 18),
                    ),
                    TextField(),
                    const SizedBox(height: 10),
                    Text(
                      "Remark",
                      style: GoogleFonts.festive(fontSize: 18),
                    ),
                    TextField(),
                    // ignore: prefer_const_constructors
                    const SizedBox(height: 10),
                    Text(
                      "Type",
                      style: GoogleFonts.festive(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    CupertinoSlidingSegmentedControl(
                      children: const {
                        "INCOME": Text("INCOME"),
                        "EXPANSE": Text("EXPANSE"),
                      },
                      onValueChanged: (value) {
                        categoryController.changType(type: value!);
                      },
                    ),
                  ],
                ),

            ),
          ),
        ],
      ),
    );
  }
}

// GridView.builder(
// itemCount: allCategoryImages.length,
// gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 1,
// childAspectRatio: 2/1,
// ),
// scrollDirection: Axis.horizontal,
// itemBuilder: (BuildContext context, int index) {
// return Column(
// children: [
// Container(
// height: 100,
// width: 120,
// decoration: BoxDecoration(
// image: DecorationImage(
// image: AssetImage(
// allCategoryImages[index]['image'],
// ),
// fit: BoxFit.scaleDown,
// ),
// ),
// ),
// Text(
// "${allCategoryImages[index]['name']}",
// style: const TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 20,
// ),
// ),
// ],
// );
// },
// ),
