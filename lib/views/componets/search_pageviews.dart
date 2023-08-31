// ignore_for_file: camel_case_types, must_be_immutable, invalid_use_of_protected_member

import 'dart:developer';

import 'package:budget_tracker_app/controllers/search_controller.dart';
import 'package:budget_tracker_app/modals/Transaction_modal.dart';
import 'package:budget_tracker_app/utils/category_images_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Setting_PageView extends StatelessWidget {
  Setting_PageView({super.key});

  searchController _searchController = Get.put(searchController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "Find Transaction",
            style: GoogleFonts.modernAntiqua(fontSize: 24),
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: (value) {
              _searchController.isSearch(search: value);
              log("${_searchController.Search.value}");
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Search Your Transaction",
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: _searchController.Search.value.length,
                itemBuilder: (context, index) {
                  TransactionModal transaction =
                      _searchController.Search[index];
                  return _searchController.Search.isNotEmpty
                      ? ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            foregroundImage: AssetImage(
                                "$categoryImages${transaction.category}.png"),
                          ),
                          title: Text(transaction.remark,
                              style: GoogleFonts.modernAntiqua()),
                          subtitle: Text(transaction.type,
                              style: GoogleFonts.modernAntiqua()),
                          trailing: Text("₹ ${transaction.amount}",
                              style: GoogleFonts.modernAntiqua()),
                        )
                      : Text(
                          "Not Fund Data",
                          style: GoogleFonts.modernAntiqua(fontSize: 22),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
