// ignore_for_file: camel_case_types, must_be_immutable

import 'dart:developer';
import 'package:budget_tracker_app/controllers/category_controller.dart';
import 'package:budget_tracker_app/controllers/date_time_controller.dart';
import 'package:budget_tracker_app/modals/Transaction_modal.dart';
import 'package:budget_tracker_app/utils/category_images_utils.dart';
import 'package:budget_tracker_app/utils/gif_images_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/transaction_controller.dart';

class Transaction_PageView extends StatefulWidget {
  const Transaction_PageView({super.key});

  @override
  State<Transaction_PageView> createState() => _Transaction_PageViewState();
}

class _Transaction_PageViewState extends State<Transaction_PageView>
    with TickerProviderStateMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController datePicker = TextEditingController();
  TextEditingController timePicker = TextEditingController();

  DateTimeController dateTimeController = Get.put(DateTimeController());

  final TransactionModal _transactionModal = TransactionModal.init();

  final TransactionController _transactionController = Get.find();

  CategoryController categoryController = Get.put(
    CategoryController(),
  );

  String? _title;
  String? _amount;
  String? _category;
  String? _type;
  String? _date;
  String? _time;

  late AnimationController controller;
  late AnimationController centerController;

  late Animation<Alignment> stopPosition;

  late Animation<Alignment> position;
  late Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    dateTimeController.init();

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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: SizedBox(
                    height: 720,
                    child: ListView(
                      children: [
                        Text(
                          "Remark",
                          style: GoogleFonts.modernAntiqua(fontSize: 18),
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Title";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            _title = newValue!;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Title",
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Amount",
                          style: GoogleFonts.modernAntiqua(fontSize: 18),
                        ),
                        TextFormField(
                          initialValue: _amount,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Amount";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            _amount = newValue;
                          },
                          decoration: const InputDecoration(
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
                              _type = value!;
                              categoryController.changType(type: value);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Date & Time",
                          style: GoogleFonts.modernAntiqua(fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(
                              width: 360,
                              child: TextField(
                                onSubmitted: (value) {
                                  _date = value;
                                  _date = dateTimeController.date as String?;
                                },
                                controller: dateTimeController.datePicker,
                                onTap: () async {
                                  dateTimeController.date =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(3000),
                                  );
                                  if (dateTimeController.date != null) {
                                    dateTimeController.setDate();
                                    log(" Date : ${dateTimeController.date} ");
                                  } else {
                                    Get.snackbar(
                                      "Error",
                                      "Can't Picked Date",
                                      overlayColor: Colors.red,
                                    );
                                  }
                                },
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Pick a Date",
                                  icon: Icon(
                                    Icons.calendar_month,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(
                              width: 360,
                              child: TextField(
                                onSubmitted: (value) {
                                  _time = value;
                                  _time = dateTimeController.time as String;
                                  log(_time!);
                                },
                                controller: dateTimeController.timePicker,
                                onTap: () async {
                                  dateTimeController.time =
                                      await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );

                                  if (dateTimeController.time != null) {
                                    dateTimeController.setTime();
                                    log(" Time : ${dateTimeController.time} ");
                                  } else {
                                    Get.snackbar(
                                      "Error",
                                      "Can't Picked Time",
                                      overlayColor: Colors.red,
                                    );
                                  }
                                },
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: "Pick a Time",
                                  hintText: "${dateTimeController.time}",
                                  icon: const Icon(
                                    Icons.watch_later_outlined,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 50,
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
                                const Icon(
                                  Icons.category_outlined,
                                  size: 30,
                                  color: Colors.white,
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
                                          _category =
                                              allCategoryImages[index]['name'];
                                          log("$_category");
                                          // _category = index.toString();
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
                                                  style: GoogleFonts
                                                      .modernAntiqua(),
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
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              _transactionModal.remark = _title!;
                              _transactionModal.amount = _amount!;
                              _transactionModal.type = _type!;
                              _transactionModal.date =
                                  _date ?? "${dateTimeController.date}";
                              _transactionModal.category = _category!;
                              _transactionModal.time =
                                  _time ?? "${dateTimeController.time}";

                              _transactionController.addTransaction(
                                transactionModal: TransactionModal(
                                  _title!,
                                  _type!,
                                  _category!,
                                  _amount!,
                                  _date ?? "${dateTimeController.date}",
                                  _time ?? "${dateTimeController.date}",
                                ),
                              );

                              _transactionController.init();

                              Get.snackbar(
                                "Successful",
                                "All Transaction Added",
                              );

                              log(_transactionModal.remark);

                              _transactionController.getBalance();

                            } else {
                              Get.snackbar(
                                  " Error !!! ", " Something Error Found ");
                            }
                          },
                          child: Text(
                            "Transaction",
                            style: GoogleFonts.modernAntiqua(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF414C6B),
                              fontSize: 20,
                            ),
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
