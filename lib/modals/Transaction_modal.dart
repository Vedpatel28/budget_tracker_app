class TransactionModal {
  late String remark;
  late String type;
  late String category;
  late int amount;
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

  factory TransactionModal.fromMap({required Map data}) {
    return TransactionModal(
      data["remark"],
      data["type"],
      data["category"],
      data["amount"],
      data["date"],
      data["time"],
    );
  }
}
