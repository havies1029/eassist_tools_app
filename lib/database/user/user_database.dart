import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  String userTable = 'userProfile';

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();

    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentsDirectory.path, "eassisttools.db");

    debugPrint("SQLite Path : $path");

    var database = await openDatabase(path);

    await _createDb(database);

    return database;
  }

  void dropTableUser(Database? db) async {
    await db?.execute("drop table if exists $userTable");
  }
  
  Future<void> _createDb(Database db) async {
    await db.execute("drop table if exists $userTable");

    //debugPrint("_createDb -> userTable :$userTable");

    await db.execute('''
      create table if not exists $userTable (
        id integer primary key,
        username text not null,
        nama text not null,
        personId text not null,
        hp text,
        email text,
        alamat1 text,
        alamat2 text,
        propinsiId text,
        propinsiDesc text,
        jnskel text,
        userCabang text, 
        hasDownline integer,
        token text not null,
        foto blob
      )''');
  }
}
