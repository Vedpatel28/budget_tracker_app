// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbHelper {
  dbHelper._();

  static final dbHelper dbhelper = dbHelper._();

  late Database database;

  String balanceTable = "Balance";
  String transactionTable = "Transaction";
  String categoryTable = "Category";

  String blId = "Id";
  String blAmo = "Amount";

  String trId = "Id";
  String trRem = "Remark";
  String trType = "Type";
  String trCat = "Category";
  String trAmo = "Amount";
  String trDate = "Date";

  String ctId = "Id";
  String ctTitle = "Title";
  String ctImage = "Image";

  initDB() async {
    String dbPath = await getDatabasesPath();
    String dbName = "BT.db";

    String path = join(dbPath, dbName);

    database = await openDatabase(
      path,
      onCreate: (db, version) {
        // Balance Creating Query
        db.execute(
            ' CREATE TABLE $balanceTable( $blId INTEGER , $blAmo INTEGER ) ');
        db.rawInsert("INSERT INTO $balanceTable VALUES (101,0)");

        // Transaction Creating Query
        db.execute(
            'CREATE TABLE $transactionTable( $trId INTEGER AUTOINCREMENT, $trRem TEXT , $trAmo INTEGER NOT NULL, $trType TEXT CHECK($trType IN("INCOME","EXPANSE")), $trCat TEXT , $trDate TEXT )');

        // Category Creating Query
        db.execute(
            ' CREATE TABLE $categoryTable( $ctId INTEGER AUTOINCREMENT, $ctTitle TEXT , $ctImage BLOB )');
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

  InsertInTransaction(
    String remarks,
    String category,
    String date, {
    required int Amount,
    required String type,
  }) {
    database.rawInsert(
        'INSERT INTO $transactionTable( $trId , $trRem , $trAmo , $trType , $trCat , $trDate ) VALUES( "101" , " $remarks " , " $Amount " , " $type " , " $category " , " $date " ) ');
  }

  InsertInCategory(
    String title,
    String image,
  ) {
    database.rawInsert('INSERT INTO $categoryTable( "101" , " $title " , " $image " )');
  }
}
