// ignore_for_file: camel_case_types, invalid_use_of_protected_member, must_be_immutable, unrelated_type_equality_checks

import 'package:budget_tracker_app/controllers/transaction_controller.dart';
import 'package:budget_tracker_app/modals/Transaction_modal.dart';
import 'package:budget_tracker_app/utils/category_images_utils.dart';
import 'package:budget_tracker_app/utils/gif_images_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Tr_History_PageViews extends StatelessWidget {
  Tr_History_PageViews({super.key});

  final TransactionController _transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text("All Transaction",style: GoogleFonts.modernAntiqua(fontSize: 24),),
          _transactionController.getAllTransaction.value.isNotEmpty
              ? Container(
            height: 500,
            alignment: Alignment.bottomCenter,
            child: ListView.builder(
              itemCount: _transactionController.getAllTransaction.length,
              itemBuilder: (context, index) {
                TransactionModal transactionModal =
                _transactionController.getAllTransaction[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundImage: AssetImage(
                          "$categoryImages${transactionModal.category}.png"),
                    ),
                    title: Text(transactionModal.remark,
                        style: GoogleFonts.modernAntiqua()),
                    subtitle: Text(transactionModal.type,
                        style: GoogleFonts.modernAntiqua()),
                    trailing: Text("₹ ${transactionModal.amount}",
                        style: GoogleFonts.modernAntiqua()),
                  ),
                );
              },
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
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
