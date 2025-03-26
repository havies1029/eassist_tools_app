import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:eassist_tools_app/apis/profile/profile_api.dart';
import 'package:eassist_tools_app/apis/profile/userfoto_api.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/models/user/user_model.dart';
import 'package:eassist_tools_app/models/authentication/auth_model.dart';
import 'package:eassist_tools_app/apis/login/login_api.dart';
import 'package:eassist_tools_app/dao/user/user_dao.dart';
import 'package:eassist_tools_app/common/img.dart';
import 'package:flutter/material.dart';

class UserRepository {
  final userDao = UserDao();

  Future<User> authenticate({
    String? username,
    String? password,
  }) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    User user = await validateUserLogin(userLogin);

    return user;
  }

  Future<void> persistToken({required User user}) async {
    // write token with the user to the database

    debugPrint("-- persistToken --");

    await userDao.createUser(user);

    debugPrint("-- persistToken hasil --");
  }

  Future<void> deleteToken({required int id}) async {
    await userDao.deleteUser(id);
  }

  Future<void> dropTableUser() async {
    await userDao.dropTableUser();
  }

  Future<bool> hasToken() async {
    debugPrint("func hasToken() a");
    bool result = await userDao.checkUser(0);

    debugPrint("func hasToken() b");
    return result;
  }

  Future<String> getUserToken() async {
    String token = await userDao.getUserToken(0);
    return token;
  }

  Future<User> getUserById(int id) async {
    User user = await userDao.getUser(id);

    return user;
  }

  Future<bool?> createUser(User user) async {
    int? id = await userDao.createUser(user);
    return id != -1;
  }

  Future<bool> updateUser(User user) async {
    //debugPrint("user_repository : updateUser #10");

    bool isValid = await updateUserProfile(user);
    if (!AppData.kIsWeb) {
      if (isValid) {
        await userDao.updateUser(user);
      }
    } else {
      AppData.user = user;
    }

    return isValid;
  }

  Future<bool> deleteUser(int id) async {
    return (await userDao.deleteUser(id) != 0);
  }

  Future<void> uploadFotoProfile(File fileFoto) async {
    //debugPrint("user_repository : uploadFotoProfile #10");

    //debugPrint(fileFoto.path);

    //upload ke API
    await uploadImage2API(fileFoto.path);

    //fungsi ini sama dg diatas dan dipertahankan sbg contoh
    //penggunaan dio u upload file
    //await postImage(fileFoto);

    //debugPrint("user_repository : uploadFotoProfile #20");

    //save ke Sqflite
    User user = await getUserById(0);

    //debugPrint("user_repository : uploadFotoProfile #30");

    Img img = Img();
    Uint8List? fileBytes = await img.readFileByte(fileFoto.path);

    //debugPrint("user_repository : uploadFotoProfile #31");

    user.foto = fileBytes;

    //print(fileBytes.toString());

    //debugPrint("user_repository : uploadFotoProfile #32");

    //print(_user.foto.toString());

    UserDao dao = UserDao();
    dao.updateFoto(user);

    //debugPrint("user_repository : uploadFotoProfile #35 -> update foto");

    //Uint8List bytesfoto = await dao.getUserFoto(0);

    //debugPrint("user_repository : uploadFotoProfile #37 -> get foto from db");

    //print(bytesfoto.toString());

    //debugPrint("user_repository : uploadFotoProfile #40");
  }
}
