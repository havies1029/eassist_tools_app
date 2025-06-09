import 'package:eassist_tools_app/models/user/user_token_model.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/database/user/user_database.dart';
import 'package:flutter/material.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;
  String userTable = 'userToken';

  Future<int?> createUser(UserToken userToken) async {
    debugPrint("UserDao -> createUser");
    final db = await dbProvider.database;


    if (db == null) {
      debugPrint("createUser db is null");
    } else {
      debugPrint("createUser db is not null");
    }
  

    Future<int>? result;
    try {
      result = db?.insert(userTable, userToken.toDatabaseJson());
      debugPrint("user. : ${userToken.toDatabaseJson().toString()}");
    } catch (e) {
      debugPrint("error ==>> db?.insert(userTable, user.toDatabaseJson());");
      debugPrint("createUser error : ${e.toString()}");
    }
    //jangan lupa matikan script ini jika sudah selesai testing
    bool hasUser = await checkUser(0);
    debugPrint("hasUser? : $hasUser");
    
    return result;
  }

  Future<int?> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db?.delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<void> dropTableUser() async {
    final db = await dbProvider.database;
    dbProvider.dropTableUser(db);
  }

  Future<String> getUserToken(int id) async {
    final db = await dbProvider.database;
    String token = "";
    List<Map> users =
        await db!.query(userTable, where: 'id = ?', whereArgs: [id]);
    if (users.isNotEmpty) {
      token = users[0]["token"];
      AppData.userToken = token;
      AppData.httpHeaders = <String, String>{
        'Content-Type': 'application/json; odata=verbos',
        'Accept': 'application/json; odata=verbos',
        'Authorization': 'Bearer ${AppData.userToken}'
      };
    }

    return token;
  }

  Future<bool> checkUser(int id) async {
    //debugPrint("func checkUser");
    final db = await dbProvider.database;

    //debugPrint("func checkUser -> get db");

    try {
      //debugPrint("func checkUser -> start -> cek users id : $id");

      List<Map> users =
          await db!.query(userTable, where: 'id = ?', whereArgs: [id]);

      if (users.isNotEmpty) {
        //debugPrint("func checkUser -> has user #10");

        AppData.userToken = users[0]["token"];
        AppData.httpHeaders = <String, String>{
          'Content-Type': 'application/json; odata=verbos',
          'Accept': 'application/json; odata=verbos',
          'Authorization': 'Bearer ${AppData.userToken}'
        };

        //debugPrint("func checkUser -> has user #20");

        return true;
      } else {
        //debugPrint("func checkUser -> no user");

        return false;
      }
    } catch (error) {
      //debugPrint("error func checkUser : $error");
      return false;
    }
  }

  Future<bool> updateUser(UserToken user) async {
    //debugPrint("user_dao -> updateUser #10");

    final db = await dbProvider.database;
    try {
      await db!.update(
        userTable,
        user.toDatabaseJson(),
        where: "id = ?",
        whereArgs: [user.id],
      );
    } catch (error) {
      return false;
    }
    return true;
  }

  

  Future<UserToken> getUser(int id) async {
    final db = await dbProvider.database;

    UserToken user;

    List<Map> users =
        await db!.query(userTable, where: 'id = ?', whereArgs: [id]);

    user = UserToken(
        id: users[0]["id"],
        token: users[0]["token"],
        custType: users[0]["custType"]);

    return user;
  }

}
