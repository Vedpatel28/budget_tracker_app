// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:developer';

import 'package:budget_tracker_app/modals/Category_modal.dart';
import 'package:budget_tracker_app/modals/Transaction_modal.dart';
import 'package:budget_tracker_app/modals/balance_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbHelper {
  dbHelper._();

  static final dbHelper dbhelper = dbHelper._();

  late Database database;

  String balanceTable = "BalanceTable";
  String transactionTable = "TransactionTable";
  String categoryTable = "CategoryTable";
  String BalanceTable = "BalanceTable";

  String blId = "Id";
  String blAmo = "Amount";

  String baId = "Id";
  String baAmo = "Balance";

  String trId = "Id";
  String trRem = "Remark";
  String trType = "Type";
  String trCat = "Category";
  String trAmo = "Amount";
  String trDate = "Date";
  String trTime = "Time";

  String ctId = "Id";
  String ctTitle = "Title";
  String ctImage = "Image";

  initDB() async {
    String dbPath = await getDatabasesPath();
    String dbName = "BTT5.db";

    String path = join(dbPath, dbName);

    database = await openDatabase(
      path,
      onCreate: (db, version) {
        // Balance Creating Query
        db
            .execute(
                ' CREATE TABLE $balanceTable( $blId INTEGER , $blAmo INTEGER ) ')
            .then(
              (value) => log("Table are Created"),
            );
        db.rawInsert("INSERT INTO $balanceTable VALUES (101,0)");

        // Transaction Creating Query
        db
            .execute(
              'CREATE TABLE $transactionTable( $trId INTEGER PRIMARY KEY AUTOINCREMENT, $trRem TEXT , $trAmo INTEGER NOT NULL, '
              '$trType TEXT CHECK($trType IN("INCOME","EXPANSE")), $trCat TEXT , $trDate TEXT ,$trTime TEXT)',
            )
            .then(
              (value) => log("Transaction Table are Created"),
            );

        // Balance Creating Query

        db.execute(
            'CREATE TABLE $BalanceTable ( $baId INTEGER PRIMARY KEY AUTOINCREMENT , $blAmo INTEGER )');

        // BalanceInsert();

        // Category Creating Query
        db.execute(
            ' CREATE TABLE $categoryTable( $ctId INTEGER PRIMARY KEY AUTOINCREMENT, $ctTitle TEXT , $ctImage BLOB )');
      },
      version: 1,
    );
  }

  setBalance({
    required int amount,
  }) {
    database.rawUpdate(
        ' UPDATE TABLE $balanceTable SET $blAmo = $amount WHERE $blId = 101 ');
  }

  InsertInTransaction({required TransactionModal transaction}) async {
    String query =
        "INSERT INTO $transactionTable( $trRem , $trAmo , $trType , $trCat , $trDate , $trTime) VALUES( ? , ? , ? , ? , ? , ? ) ";

    List getArgs = [
      transaction.remark,
      transaction.amount,
      transaction.type,
      transaction.category,
      transaction.date,
      transaction.time,
    ];

    database.rawInsert(query, getArgs);

    int balance = await DisplayBalance();

    if (transaction.type == "INCOME") {
      balance += int.parse(transaction.amount);

      log(" Balance = $balance");

      updateBalance(balance: balance);
      DisplayBalance();
    } else {
      balance -= int.parse(transaction.amount);
      log(" Balance = $balance");
      updateBalance(balance: balance);
      DisplayBalance();
    }
  }

  InsertInCategory(
    String title,
    String image,
  ) async {
    String query =
        "INSERT INTO $categoryTable($ctTitle,$ctImage) VALUES( ? , ? )";

    List getArgs = [title, image];

    int response = await database.rawInsert(query, getArgs);

    return response;
  }

  Future<List<CategoryModal>> DisplayCategory() async {
    List response = await database.rawQuery("SELECT * FROM $transactionTable");

    List<CategoryModal> allCategory = response
        .map(
          (e) => CategoryModal.fromMap(data: e),
        )
        .toList();

    return allCategory;
  }

  Future<List<TransactionModal>> DisplayTransaction() async {
    String query = "SELECT * FROM $transactionTable";

    List allData = await database.rawQuery(query);
    log("$allData");

    List<TransactionModal> allTransaction =
        allData.map((e) => TransactionModal.fromMap(data: e)).toList();

    return allTransaction;
  }

  DeleteTransaction() async {
    String query = " DELETE FROM $transactionTable WHERE Id = $trId ";

    return await database.rawDelete(query);
  }

  Future<List<TransactionModal>> SearchTransaction(
      {required String remarks}) async {
    String query =
        'SELECT * FROM $transactionTable WHERE $trRem LIKE "%$remarks%"';

    List search = await database.rawQuery(query);

    log("$search");

    List<TransactionModal> allSearch =
        search.map((e) => TransactionModal.fromMap(data: e)).toList();

    return allSearch;
  }

  //
  // UpdateTransaction({required int id, required String remark, required}) {
  //   String query = "UPDATE $transactionTable WHERE $trId = $id , $trRem = ? , $trAmo = ? , $trType = ?";
  //   List Args = [];
  //
  //   database.rawUpdate(query, Args);
  // }

  BalanceInsert() async {
    String query = "INSERT INTO $BalanceTable($blId,$blAmo) VALUES( 101 , 0 )";

    int response = await database.rawInsert(query);

    return response;
  }

  Future<int> DisplayBalance() async {
    String query = "SELECT * FROM $balanceTable";

    List balance = await database.rawQuery(query);

    List<BalanceModal> Balance =
        balance.map((e) => BalanceModal.fromMap(data: e)).toList();

    if (balance.isEmpty) {
      BalanceInsert();
      DisplayBalance();
    }

    int balance2 = Balance[0].amount;

    return balance2;
  }

  updateBalance({required int balance}) {
    String query =
        "UPDATE $balanceTable SET $blAmo = $balance WHERE $blId = 101";

    database.rawUpdate(query);
  }
}
