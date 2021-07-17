import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_app/models/datamodel.dart';

class DB {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'My_db.db'),
      onCreate: (database, version) async {
        await database.execute('''
        CREATE TABLE MYTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        subtitle TEXT
        )
        ''');
      },
      version: 1,
    );
  }

  //------------------------------INSERT DATA-----------------------------------
  Future<bool> insertData(DataModel data) async {
    final Database db = await initDB();
    db.insert("MYTable", data.toMap());
    return true;
  }

//------------------------------Get Data from SQL-------------------------------
  Future<List<DataModel>> getData() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> datas = await db.query("MYTABLE");
    return datas.map((e) => DataModel.fromMap(e)).toList();
  }
  //-------------------------
} // end class
