import 'package:flutter/services.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/database/user/user_database.dart';
import 'package:eassist_tools_app/models/user/user_model.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;
  String userTable = 'userProfile';

  Future<int?> createUser(User user) async {
    //debugPrint("UserDao -> createUser");
    final db = await dbProvider.database;

/*
    if (db == null) {
      debugPrint("createUser db is null");
    } else {
      debugPrint("createUser db is not null");
    }
  */

    Future<int>? result;
    try {
      result = db?.insert(userTable, user.toDatabaseJson());
      //debugPrint("user. : ${user.toDatabaseJson().toString()}");
    } catch (e) {
      //debugPrint("error ==>> db?.insert(userTable, user.toDatabaseJson());");
      //debugPrint("createUser error : ${e.toString()}");
    }
    //bool hasUser = await checkUser(0);
    //debugPrint("hasUser? : $hasUser");
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
        AppData.userid = users[0]["username"];
        AppData.personId = users[0]["personId"];
        AppData.personName = users[0]["nama"] ?? "";
        AppData.userCabang = users[0]["userCabang"] ?? "";
        AppData.hasDownline = users[0]["hasDownline"] == 1;
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

  Future<bool> updateUser(User user) async {
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

  Future<bool> updateFoto(User user) async {
    //debugPrint("user_dao -> updateFoto #10");

    //debugPrint(user.id.toString());

    //debugPrint("user_dao -> updateFoto #20");

    //debugPrint(user.foto.toString());

    //debugPrint("user_dao -> updateFoto #30");

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

    //debugPrint("user_dao -> updateFoto #40");

    return true;
  }

  Future<User> getUser(int id) async {
    final db = await dbProvider.database;

    User user;

    List<Map> users =
        await db!.query(userTable, where: 'id = ?', whereArgs: [id]);

    user = User(
        id: users[0]["id"],
        username: users[0]["username"],
        nama: users[0]["nama"],
        personId: users[0]["personId"],
        hp: users[0]["hp"],
        email: users[0]["email"],
        alamat1: users[0]["alamat1"],
        alamat2: users[0]["alamat2"],
        propinsiId: users[0]["propinsiId"],
        propinsiDesc: users[0]["propinsiDesc"],
        jnskel: users[0]["jnskel"],
        userCabang: users[0]["userCabang"],
        hasDownline: users[0]["hasDownline"],
        token: users[0]["token"],
        foto: users[0]["foto"]);

    return user;
  }

  Future<Uint8List> getUserFoto(int id) async {
    //debugPrint("user_dao -> getUserFoto #10");

    Uint8List foto;

    User user = await getUser(0);

    //debugPrint(user.nama);
    //debugPrint("user_dao -> getUserFoto #20");

    //debugPrint(user.toDatabaseJson().toString());

    //debugPrint("user_dao -> getUserFoto #30");

    if ((user.foto != null) && (user.foto!.isNotEmpty)) {
      //debugPrint("getUserFoto -> FOTO -> not NULL #32");
      foto = user.foto!;
      //debugPrint("getUserFoto -> FOTO -> not NULL #33");
      //debugPrint(foto.toString());
      //debugPrint("getUserFoto -> FOTO -> not NULL #34");
      //debugPrint(foto.lengthInBytes.toString());
    } else {
      ByteData bytes =
          await rootBundle.load("assets/images/icon-user-default.png");
      foto = bytes.buffer.asUint8List();
      //debugPrint("getUserFoto -> FOTO -> NULL #36");
    }

    //debugPrint("user_dao -> getUserFoto #40");

    return foto;
  }
}
