import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeController extends GetxController {
  DateTime? date = DateTime.now();
  TimeOfDay? time = TimeOfDay.now();

  TextEditingController datePicker = TextEditingController();
  TextEditingController timePicker = TextEditingController();

  init() {
    datePicker.text = "";
    timePicker.text = "";
  }

  setDate() {
    String dateFormat = DateFormat("yMMMd").format(date!).toString();
    datePicker.text = dateFormat.toString();
    update();
  }

  setTime() {
    // String timeFormat = DateFormat("j").format(time as DateTime).toString();
    String hour = time!.hour.toString();
    String minute = time!.minute.toString();
    timePicker.text = " $hour : ${minute.toString().padLeft(2, "0")} ";
    update();
  }
}
