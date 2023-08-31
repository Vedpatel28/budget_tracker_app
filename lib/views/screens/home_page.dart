// ignore_for_file: must_be_immutable, camel_case_types

import 'dart:developer';

import 'package:budget_tracker_app/controllers/page_controller.dart';
import 'package:budget_tracker_app/modals/Transaction_modal.dart';
import 'package:budget_tracker_app/views/componets/setting_pageviews.dart';
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
          const Setting_PageView(),
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
                icon: Icon(Icons.account_balance_wallet), label: "Wallet"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }
}
