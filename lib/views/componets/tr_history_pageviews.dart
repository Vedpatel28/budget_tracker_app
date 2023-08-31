// ignore_for_file: camel_case_types, invalid_use_of_protected_member, must_be_immutable

import 'dart:developer';

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
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: (value) {},
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Search And Find Transaction",
            ),
          ),
          _transactionController.getAllTransaction.value.isNotEmpty
              ? ListView.builder(
            itemCount: _transactionController.getAllTransaction.length,
            itemBuilder: (context, index) {
              TransactionModal transactionModal =
              _transactionController.getAllTransaction[index];
              log(" Images : ${transactionModal.remark}");
              log(" Images : ${transactionModal.amount}");
              log(" Images : ${transactionModal.time}");

              var image = allCategoryImages.where((element) =>
              element['Name'] == transactionModal.category);

              String images = image.toList()[0]['image'];

              log(" Images : $images");

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    foregroundImage: AssetImage(images),
                  ),
                ),
              );
            },
          )
              : Container(
            height: 400,
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                const Spacer(),
                Container(
                  height: 180,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("${gifImages}sopingman.gif"),
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
          ),
        ],
      ),
    );
  }
}