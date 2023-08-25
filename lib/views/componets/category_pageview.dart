// ignore_for_file: camel_case_types, must_be_immutable

import 'package:budget_tracker_app/controllers/category_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class category_pageView extends StatefulWidget {
  category_pageView({super.key});

  @override
  State<category_pageView> createState() => _category_pageViewState();
}

class _category_pageViewState extends State<category_pageView>
    with TickerProviderStateMixin {
  CategoryController categoryController = Get.put(
    CategoryController(),
  );

  late AnimationController controller;
  late AnimationController centerController;

  late Animation<Alignment> stopPosition;

  late Animation<Alignment> position;
  late Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    centerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    stopPosition = Tween(
      begin: const Alignment(0, 180),
      end: Alignment.center,
    ).animate(centerController);

    position = Tween<Alignment>(
      begin: const Alignment(-3, -2),
      end: const Alignment(-2, -1.2),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.1, 0.4),
      ),
    );

    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.4, 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, value) {
            return Stack(
              children: [
                AlignTransition(
                  alignment: position,
                  child: AnimatedContainer(
                    height: 180,
                    width: 200,
                    curve: Curves.easeInOutQuad,
                    duration: const Duration(seconds: 1),
                    decoration: BoxDecoration(
                      color: Colors.green.shade200,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.6, 1),
                          spreadRadius: 4,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(260, 700),
                  child: FadeTransition(
                    opacity: opacity,
                    child: AnimatedContainer(
                      height: 180,
                      width: 200,
                      curve: Curves.easeInOutQuad,
                      duration: const Duration(seconds: 1),
                      decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.shade100,
                            offset: const Offset(0.6, 1),
                            spreadRadius: 4,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AlignTransition(
                  alignment: stopPosition,
                  child: Form(
                    child: SizedBox(
                      height: 720,
                      child: ListView(
                        children: [
                          Text(
                            "Remark",
                            style: GoogleFonts.modernAntiqua(fontSize: 18),
                          ),
                          const TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Title",
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Amount",
                            style: GoogleFonts.modernAntiqua(fontSize: 18),
                          ),
                          const TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Amount",
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Type",
                            style: GoogleFonts.modernAntiqua(fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => CupertinoSlidingSegmentedControl(
                              groupValue: categoryController.currentType.value,
                              children: {
                                "INCOME": Text(
                                  "INCOME",
                                  style: GoogleFonts.modernAntiqua(
                                    textStyle: TextStyle(
                                      fontWeight: categoryController
                                                  .currentType.value ==
                                              "INCOME"
                                          ? FontWeight.w900
                                          : FontWeight.w200,
                                    ),
                                  ),
                                ),
                                "EXPANSE": Text(
                                  "EXPANSE",
                                  style: GoogleFonts.modernAntiqua(
                                    textStyle: TextStyle(
                                      fontWeight: categoryController
                                                  .currentType.value ==
                                              "INCOME"
                                          ? FontWeight.w200
                                          : FontWeight.w900,
                                    ),
                                  ),
                                ),
                              },
                              onValueChanged: (value) {
                                categoryController.changType(type: value!);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
