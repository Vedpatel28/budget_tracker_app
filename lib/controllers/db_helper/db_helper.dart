// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:developer';

import 'package:budget_tracker_app/modals/Category_modal.dart';
import 'package:budget_tracker_app/modals/Transaction_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbHelper {
  dbHelper._();

  static final dbHelper dbhelper = dbHelper._();

  late Database database;

  String balanceTable = "BalanceTable";
  String transactionTable = "TransactionTable";
  String categoryTable = "CategoryTable";

  String blId = "Id";
  String blAmo = "Amount";

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
    String dbName = "BTT1.db";

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
              'CREATE TABLE $transactionTable( $trId INTEGER PRIMARY KEY AUTOINCREMENT, $trRem TEXT , $trAmo INTEGER NOT NULL, $trType TEXT CHECK($trType IN("INCOME","EXPANSE")), $trCat TEXT , $trDate TEXT ,$trTime TEXT)',
            )
            .then(
              (value) => log("Transaction Table are Created"),
            );

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

  InsertInTransaction({required TransactionModal transaction}) {
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
    List response = await database.rawQuery("SELECT * FROM $categoryTable");

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

    List<TransactionModal> allTransaction =
        allData.map((e) => TransactionModal.fromMap(data: e)).toList();

    return allTransaction;
  }

  DeleteTransaction() async {
    String query = " DELETE FROM $transactionTable WHERE Id = $trId ";

    return await database.rawDelete(query);
  }

  SearchTransaction({required String remarks}) async {
    String query =
        'SELECT * FROM $transactionTable WHERE $trRem LIKE "$remarks"';

    List search = await database.rawQuery(query);

    List<TransactionModal> allSearch = search.map((e) => TransactionModal.fromMap(data: e)).toList();

    return allSearch;
  }
}
