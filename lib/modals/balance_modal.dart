class BalanceModal {
  int id = 0;
  int amount = 0;

  BalanceModal(
    this.id,
    this.amount,
  );

  factory BalanceModal.fromMap({required Map data}) {
    return BalanceModal(
      data["Id"],
      data["Amount"],
    );
  }
}
