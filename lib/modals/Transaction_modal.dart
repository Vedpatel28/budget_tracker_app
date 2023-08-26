import 'dart:developer';

class TransactionModal {
  late String remark;
  late String type;
  late String category;
  late String amount;
  late String date;
  late String time;

  TransactionModal(
    this.remark,
    this.type,
    this.category,
    this.amount,
    this.date,
    this.time,
  );

  TransactionModal.init() {
    log("Empty transaction initialized...");
  }

  factory TransactionModal.fromMap({required Map data}) {
    return TransactionModal(
      data["Remark"],
      data["Type"],
      data["Category"],
      data["Amount"],
      data["Date"],
      data["Time"],
    );
  }
}
