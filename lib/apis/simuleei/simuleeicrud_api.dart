import 'dart:convert';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/simuleei/simuleeicrud_model.dart';

class SimuleeiCrudAPI {
  Future<ReturnDataAPI> simuleeiCrudTambahAPI(SimuleeiCrudModel record) async {
    String tambahEndpoint =
        "${AppData.prefixEndPoint}/api/simuleei/simuleeicrud/create";
    Map<String, String> queryParams = {"modul_id": "simuleeiCrudTambahAPI"};
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, tambahEndpoint, queryParams);

    ReturnDataAPI returnData;
    final http.Response response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; odata=verbos',
          'Accept': 'application/json; odata=verbos',
          'Authorization': 'Bearer ${AppData.userToken}'
        },
        body: jsonEncode(record.toJson()));

    if (response.statusCode == 200) {
      returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
    } else {
      returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
    }
    return returnData;
  }

  Future<bool> simuleeiCrudUbahAPI(SimuleeiCrudModel record) async {
    String ubahEndpoint =
        "${AppData.prefixEndPoint}/api/simuleei/simuleeicrud/update";
    Map<String, String> queryParams = {"modul_id": "simuleeiCrudUbahAPI"};

    var uri = AppData.uriHtpp(AppData.httpAuthority, ubahEndpoint, queryParams);

    final http.Response response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; odata=verbos',
          'Accept': 'application/json; odata=verbos',
          'Authorization': 'Bearer ${AppData.userToken}'
        },
        body: jsonEncode(record.toJson()));

    ReturnDataAPI returnData;
    if (response.statusCode == 200) {
      returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
    } else {
      returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
    }
    return returnData.success;
  }

  Future<bool> simuleeiCrudHapusAPI(String simuleei1Id) async {
    String hapusEndpoint =
        "${AppData.prefixEndPoint}/api/simuleei/simuleeicrud/delete";
    Map<String, String> queryParams = {
      'simuleei1Id': simuleei1Id,
      'modul_id': 'simuleeiCrudHapusAPI'
    };
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, hapusEndpoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    ReturnDataAPI returnData;
    if (response.statusCode == 200) {
      returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
    } else {
      returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
    }
    return returnData.success;
  }

  Future<SimuleeiCrudModel> simuleeiCrudLihatAPI(String simuleei1Id) async {
    String lihatEndpoint =
        "${AppData.prefixEndPoint}/api/simuleei/simuleeicrud/read";
    Map<String, String> queryParams = {'simuleei1Id': simuleei1Id};
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    if (response.statusCode == 200) {
      var returnData = SimuleeiCrudModel.fromJson(jsonDecode(response.body));
      return returnData;
    } else {
      return throw Exception("Failed to load data");
    }
  }

  Future<SimuleeiCrudModel> simulEEICrudInitValueAPI() async {
    String initValueEndpoint =
        "${AppData.prefixEndPoint}/api/simuleei/simuleeicrud/initvalue";
    var uri = AppData.uriHtpp(AppData.httpAuthority, initValueEndpoint);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    if (response.statusCode == 200) {
      var returnData = SimuleeiCrudModel.fromJson(jsonDecode(response.body));
      return returnData;
    } else {
      return throw Exception("Failed to load data");
    }
  }

  Future<ReturnDataAPI> simuleeiCrudCalcPremiAPI(
      SimuleeiCrudModel record) async {
    String tambahEndpoint =
        "${AppData.prefixEndPoint}/api/simuleei/simuleeicrud/calcpremieei";
    Map<String, String> queryParams = {"modul_id": "simuleeiCrudCalcPremiAPI"};
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, tambahEndpoint, queryParams);

    ReturnDataAPI returnData;
    final http.Response response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; odata=verbos',
          'Accept': 'application/json; odata=verbos',
          'Authorization': 'Bearer ${AppData.userToken}'
        },
        body: jsonEncode(record.toJson()));

    //debugPrint("response.statusCode : ${response.statusCode}");
    //debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
    } else {
      returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
    }
    return returnData;
  }
}
