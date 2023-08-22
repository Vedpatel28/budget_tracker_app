import 'dart:developer';

import 'package:budget_tracker_app/controllers/db_helper/db_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbHelper {
  dbHelper._();

  static final dbHelper dbhelper = dbHelper._();

  late Database database;

  String tableName = "Student";
  String idCol = "Id";
  String nameCol = "Name";

  init() async {
    String dbpath = await getDatabasesPath();
    String dbName = "budget.db";

    String path = join(dbpath, dbName);

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db
            .execute(
                "CREATE TABLE $tableName ( $idCol INTEGER PRIMARY KEY AUTOINCREMENT , $nameCol TEXT NOT NULL)")
            .then((value) {
          log("Created Table");
        }).onError((error, stackTrace) {
          log("Error : $error");
        });
      },
    );
  }
  Future<int> insertData({required String name}) async {
    return await database
        .rawInsert('INSERT INTO $tableName($nameCol) VALUES("$name")');
  }

  Future<List<student>?> getAllRecord() async {
    List allData = await database.rawQuery('SELECT * FROM $tableName');

    List<student> allStudent =
    allData.map((e) => student.fromMap(data: e)).toList();

    return allStudent;
  }
}
