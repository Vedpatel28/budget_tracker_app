// ignore_for_file: must_be_immutable, camel_case_types

import 'package:budget_tracker_app/controllers/db_helper/db_helper.dart';
import 'package:budget_tracker_app/controllers/db_helper/db_modal.dart';
import 'package:budget_tracker_app/controllers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
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
              children: [
                FutureBuilder(
                  future: dbHelper.dbhelper.getAllRecord(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<student> info = snapshot.data!;
                      return ListView.builder(
                        itemCount: info.length,
                        itemBuilder: (context, index) {
                          return GlassmorphicContainer(
                            width: 200,
                            height: 120,
                            borderRadius: 12,
                            linearGradient: const LinearGradient(
                              colors: [
                                Colors.white10,
                                Colors.white24,
                              ],
                            ),
                            border: 2,
                            blur: 6,
                            borderGradient: const LinearGradient(
                              colors: [
                                Colors.black12,
                                Colors.white10,
                              ],
                            ),
                            child: Text("${info[index].name}"),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
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
        onPressed: () async {
          int id = await dbHelper.dbhelper.insertData(name: "Patel");
          Get.snackbar("Add Successful", "$id Was add In TO Data Base");
        },
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
