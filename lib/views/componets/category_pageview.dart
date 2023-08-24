// ignore_for_file: camel_case_types

import 'package:budget_tracker_app/utils/category_images_utils.dart';
import 'package:flutter/material.dart';

class category_pageView extends StatelessWidget {
  const category_pageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 370,
                height: 300,
                child: GridView.builder(
                  itemCount: allCategoryImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 2/1,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          height: 100,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                allCategoryImages[index]['image'],
                              ),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        Text(
                          "${allCategoryImages[index]['name']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
