// ignore_for_file: must_be_immutable, camel_case_types

import 'dart:developer';

import 'package:budget_tracker_app/controllers/page_controller.dart';
import 'package:budget_tracker_app/modals/Transaction_modal.dart';
import 'package:budget_tracker_app/views/componets/search_pageviews.dart';
import 'package:budget_tracker_app/views/componets/tr_history_pageviews.dart';
import 'package:budget_tracker_app/views/componets/transaction_pageview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home_page extends StatelessWidget {
  Home_page({super.key});

  isPageController controller = Get.put(isPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: PageView(
        onPageChanged: (index) {
          controller.changeIndex(index: index);
        },
        controller: controller.pageController,
        children: [
          const Transaction_PageView(),
          Tr_History_PageViews(),
          Setting_PageView(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.changeIndex(index: index);
            index == 1 ? log(" Images : $TransactionModal") : Null;
          },
          currentIndex: controller.getIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.edit_calendar_outlined), label: "Transaction"),
            BottomNavigationBarItem(
                icon: Icon(Icons.content_paste_search_outlined), label: "Search"),
          ],
        ),
      ),
    );
  }
}
