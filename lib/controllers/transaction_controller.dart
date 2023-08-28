// ignore_for_file: non_constant_identifier_names

import 'package:budget_tracker_app/controllers/db_helper/db_helper.dart';
import 'package:budget_tracker_app/modals/Transaction_modal.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final RxList<TransactionModal> _allTransaction = <TransactionModal>[].obs;
  TrackingScrollController() {
    init();
  }

  init() async {
    _allTransaction(await dbHelper.dbhelper.DisplayTransaction());
  }

  addTransaction({required TransactionModal transactionModal}) async {
    return dbHelper.dbhelper.InsertInTransaction(transaction: transactionModal);
  }

  RxList<TransactionModal> get getAllTransaction {
    return _allTransaction;
  }
}
