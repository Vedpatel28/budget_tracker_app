// ignore_for_file: must_be_immutable, camel_case_types

import 'package:budget_tracker_app/controllers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home_page extends StatelessWidget {
  Home_page({super.key});

  isPageController controller = Get.put(
    isPageController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        onPageChanged: (index) {
          controller.changeIndex(index: index);
        },
        controller: controller.pageController,
        children: [
          Container(
            color: Colors.blue,
            child: Column(
              children: [],
            ),
          ),
          Container(
            color: Colors.cyanAccent,
          ),
          Container(
            color: Colors.green,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.changeIndex(index: index);
          },
          currentIndex: controller.getIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "setting"),
            BottomNavigationBarItem(icon: Icon(Icons.call), label: "call"),
          ],
        ),
      ),
    );
  }
}
