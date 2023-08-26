// ignore_for_file: camel_case_types, must_be_immutable

import 'package:budget_tracker_app/controllers/category_controller.dart';
import 'package:budget_tracker_app/controllers/date_time_controller.dart';
import 'package:budget_tracker_app/utils/category_images_utils.dart';
import 'package:budget_tracker_app/utils/gif_images_utils.dart';
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTimeController dateTimeController = Get.put(DateTimeController());

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
      duration: const Duration(milliseconds: 1200),
    )..forward();

    centerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    stopPosition = Tween(
      begin: const Alignment(0, 180),
      end: Alignment.center,
    ).animate(centerController);

    position = Tween<Alignment>(
      begin: const Alignment(-3, -2),
      end: const Alignment(-1.8, -1.1),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.1, 0.4),
      ),
    );

    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1),
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
                    // color: const Color(0xFF414C6B),
                    image: DecorationImage(
                      image: AssetImage("${gifImages}wlet.gif"),
                      fit: BoxFit.contain,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(250, 670),
                child: FadeTransition(
                  opacity: opacity,
                  child: AnimatedContainer(
                    height: 180,
                    width: 200,
                    curve: Curves.easeInOutQuad,
                    duration: const Duration(seconds: 1),
                    decoration: BoxDecoration(
                      // color: const Color(0xFFE4979E),
                      image: DecorationImage(
                        image: AssetImage("${gifImages}budgetfriendly.gif"),
                        fit: BoxFit.contain,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              AlignTransition(
                alignment: stopPosition,
                child: Form(
                  key: formKey,
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
                        const SizedBox(height: 10),
                        Obx(
                          () => CupertinoSlidingSegmentedControl(
                            groupValue: categoryController.currentType.value,
                            children: {
                              "INCOME": Text(
                                "INCOME",
                                style: GoogleFonts.modernAntiqua(
                                  textStyle: TextStyle(
                                    fontWeight:
                                        categoryController.currentType.value ==
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
                                    fontWeight:
                                        categoryController.currentType.value ==
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
                        const SizedBox(height: 20),
                        Text(
                          "Date & Time",
                          style: GoogleFonts.modernAntiqua(fontSize: 18),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: dateTimeController.dateTime,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2030),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.date_range,
                                  ),
                                ),
                                Text(
                                  "Pick a Date",
                                  style: GoogleFonts.modernAntiqua(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: dateTimeController.time,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.access_time_rounded,
                                  ),
                                ),
                                Text(
                                  "Pick a Time",
                                  style: GoogleFonts.modernAntiqua(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF414C6B),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: GestureDetector(
                            child: Row(
                              children: [
                                const Spacer(flex: 2),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.category_outlined,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "Select Category",
                                  style: GoogleFonts.modernAntiqua(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(flex: 2),
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: SizedBox(
                                    height: 600,
                                    width: 400,
                                    child: GridView.builder(
                                      itemCount: allCategoryImages.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1 / 1,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 5,
                                      ),
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Card(
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  height: 300,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        allCategoryImages[index]
                                                            ["image"],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  allCategoryImages[index]
                                                      ['name'],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
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
        },
      ),
    );
  }
}
