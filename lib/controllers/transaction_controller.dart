// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:budget_tracker_app/controllers/db_helper/db_helper.dart';
import 'package:budget_tracker_app/modals/Transaction_modal.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  RxInt balance = 0.obs;

  getBalance() async {
    balance(await dbHelper.dbhelper.DisplayBalance());
  }

  final RxList<TransactionModal> _allTransaction = <TransactionModal>[].obs;

  TrackingScrollController() {
    init();
  }

  init() async {
    _allTransaction(await dbHelper.dbhelper.DisplayTransaction());
    getBalance();
    log(" Images : $TransactionModal");
  }

  addTransaction({required TransactionModal transactionModal}) async {
    return dbHelper.dbhelper.InsertInTransaction(transaction: transactionModal);
  }

  RxList<TransactionModal> get getAllTransaction {
    return _allTransaction;
  }

  UpdateTransaction({
    required int id,
    required String remark,
    required int amount,
    required type,
  }) {
    dbHelper.dbhelper.UpdateTransaction(
      id: id,
      remark: remark,
      amount: amount,
      type: type,
    );
  }
}
