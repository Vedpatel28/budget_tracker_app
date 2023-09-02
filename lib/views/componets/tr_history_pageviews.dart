// ignore_for_file: camel_case_types, invalid_use_of_protected_member, must_be_immutable, unrelated_type_equality_checks

import 'package:budget_tracker_app/controllers/category_controller.dart';
import 'package:budget_tracker_app/controllers/transaction_controller.dart';
import 'package:budget_tracker_app/modals/Transaction_modal.dart';
import 'package:budget_tracker_app/utils/category_images_utils.dart';
import 'package:budget_tracker_app/utils/gif_images_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Tr_History_PageViews extends StatelessWidget {
  Tr_History_PageViews({super.key});

  final TransactionController _transactionController =
      Get.put(TransactionController());
  CategoryController categoryController = Get.put(
    CategoryController(),
  );

  String? _title;
  String? _amount;
  String? _type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "Transaction",
            style: GoogleFonts.modernAntiqua(fontSize: 24),
          ),
          const SizedBox(height: 20),
          Text(
            "₹ ${_transactionController.balance.value}",
            style: GoogleFonts.modernAntiqua(
              fontSize: 22,
            ),
          ),
          _transactionController.getAllTransaction.value.isNotEmpty
              ? SingleChildScrollView(
                  child: Container(
                    height: 600,
                    child: ListView.builder(
                      itemCount:
                          _transactionController.getAllTransaction.length,
                      itemBuilder: (context, index) {
                        TransactionModal transactionModal =
                            _transactionController.getAllTransaction[index];
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: SingleChildScrollView(
                                  child: Container(
                                    height: 300,
                                    child: Form(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          TextFormField(
                                            onSaved: (newValue) {
                                              _title = newValue!;
                                            },
                                            initialValue:
                                                transactionModal.remark,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter Title";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          TextFormField(
                                            onSaved: (newValue) {
                                              _amount = newValue!;
                                            },
                                            initialValue:
                                                transactionModal.amount,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter Title";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Obx(
                                            () =>
                                                CupertinoSlidingSegmentedControl(
                                              groupValue: categoryController
                                                  .currentType.value,
                                              children: {
                                                "INCOME": Text(
                                                  "INCOME",
                                                  style:
                                                      GoogleFonts.modernAntiqua(
                                                    textStyle: TextStyle(
                                                      fontWeight:
                                                          categoryController
                                                                      .currentType
                                                                      .value ==
                                                                  "INCOME"
                                                              ? FontWeight.w900
                                                              : FontWeight.w200,
                                                    ),
                                                  ),
                                                ),
                                                "EXPANSE": Text(
                                                  "EXPANSE",
                                                  style:
                                                      GoogleFonts.modernAntiqua(
                                                    textStyle: TextStyle(
                                                      fontWeight:
                                                          categoryController
                                                                      .currentType
                                                                      .value ==
                                                                  "INCOME"
                                                              ? FontWeight.w200
                                                              : FontWeight.w900,
                                                    ),
                                                  ),
                                                ),
                                              },
                                              onValueChanged: (value) {
                                                _type = value!;
                                                categoryController.changType(
                                                    type: value);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _transactionController.UpdateTransaction(
                                        id: transactionModal.id,
                                        remark: _title!,
                                        amount: _amount as int,
                                        type: _type,
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Edite",
                                      style: GoogleFonts.modernAntiqua(),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "BACK",
                                      style: GoogleFonts.modernAntiqua(),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                foregroundImage: AssetImage(
                                  "$categoryImages${transactionModal.category}.png",
                                ),
                              ),
                              title: Text(
                                transactionModal.remark,
                                style: GoogleFonts.modernAntiqua(),
                              ),
                              subtitle: Text(
                                transactionModal.type,
                                style: GoogleFonts.modernAntiqua(),
                              ),
                              trailing: Text(
                                "₹ ${transactionModal.amount}",
                                style: GoogleFonts.modernAntiqua(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: transactionModal.type == "INCOME"
                                      ? Colors.greenAccent.shade400
                                      : Colors.redAccent.shade400,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 200),
                    Container(
                      height: 180,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("${gifImages}sopping.gif"),
                          fit: BoxFit.contain,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      "Can't found any Transaction",
                      style: GoogleFonts.modernAntiqua(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
