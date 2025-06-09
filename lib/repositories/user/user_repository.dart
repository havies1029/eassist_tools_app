import 'dart:async';
import 'dart:io';
import 'package:eassist_tools_app/apis/profile/profile_api.dart';
import 'package:eassist_tools_app/apis/profile/userfoto_api.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/models/user/user_model.dart';
import 'package:eassist_tools_app/models/authentication/auth_model.dart';
import 'package:eassist_tools_app/apis/login/login_api.dart';
import 'package:eassist_tools_app/dao/user/user_dao.dart';
import 'package:eassist_tools_app/models/user/user_token_model.dart';
import 'package:flutter/material.dart';

class UserRepository {
  final userDao = UserDao();

  Future<User> authenticate({
    String? username,
    String? password,
  }) async {
    UserLogin userLogin = UserLogin(username: username, password: password);    
    LoginApi loginApi = LoginApi();
    User user = await loginApi.validateUserLoginAPI(userLogin);

    return user;
  }

  Future<void> persistToken({required UserToken userToken}) async {
    // write token with the user to the database

    debugPrint("-- persistToken --");

    await userDao.createUser(userToken);

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

  Future<String> getToken() async {
    String token = await userDao.getUserToken(0);
    return token;
  }



  Future<bool?> createUser(UserToken user) async {
    int? id = await userDao.createUser(user);
    return id != -1;
  }

  Future<bool> updateUser(User user) async {
    //debugPrint("user_repository : updateUser #10");

    bool isValid = await updateUserProfile(user);
    if (!AppData.kIsWeb) {
      if (isValid) {
        //await userDao.updateUser(user);
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
    await uploadImage2API(fileFoto.path);
  }

  Future<User> getUserByToken(String token) async {
    debugPrint("getUserByToken : $token");
    LoginApi loginApi = LoginApi();
    User user = await loginApi.getUserByTokenAPI(token);
    return user;
  } 
}
