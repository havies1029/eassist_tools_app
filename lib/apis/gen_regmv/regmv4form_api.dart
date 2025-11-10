import 'dart:convert';
import 'dart:typed_data';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/models/image/downloadfileinfo64.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';

class Regmv4FormAPI {

	Future<ReturnDataAPI> uploadFileFotoSTNK(
      String regmv4Id, String filePath) async {
    String base = AppData.apiDomain;
    String uploadFotoEndpoint = "api/regmv/regmv4form/uploadfilestnk";
    String uploadFotoURL = base + uploadFotoEndpoint;

    ReturnDataAPI returnData =
        ReturnDataAPI(success: false, data: "", rowcount: 0);

    var request = http.MultipartRequest('POST', Uri.parse(uploadFotoURL));
    request.headers.addAll(AppData.httpHeaders);
    request.fields['regmv4Id'] = regmv4Id;

    request.files
        .add(await http.MultipartFile.fromPath('image_file', filePath));
    await request.send().then((response) {
      if (response.statusCode == 200) {
        debugPrint("Success send Image");
        returnData.success = true;

        response.stream.transform(utf8.decoder).listen((value) {
          debugPrint(value);
        });
        //returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.));
      } else {
        debugPrint("Error send Image");
      }
    });
    return returnData;
  }

  Future<ReturnDataAPI> uploadBinaryFotoSTNK(
      String regmv4Id, String fileName, Uint8List bytes) async {
    String base = AppData.apiDomain;
    String uploadFotoEndpoint = "api/regmv/regmv4form/uploadbinarystnk";
    String uploadFotoURL = base + uploadFotoEndpoint;

    ReturnDataAPI returnData =
        ReturnDataAPI(success: false, data: "", rowcount: 0);

    var request = http.MultipartRequest('POST', Uri.parse(uploadFotoURL));
    request.headers.addAll(AppData.httpHeaders);
    request.fields['regmv4Id'] = regmv4Id;
    request.fields['filename'] = fileName;

    request.files.add(
        http.MultipartFile.fromBytes('image_file', bytes, filename: fileName));
    await request.send().then((response) {
      if (response.statusCode == 200) {
        debugPrint("Success send Image");
        returnData.success = true;

        response.stream.transform(utf8.decoder).listen((value) {
          debugPrint("response.stream.transform(utf8.decoder).listen((value)");
          debugPrint(value);
        });
        //returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.));
      } else {
        debugPrint("Error send Image");
        returnData.success = false;
      }
    });
    return returnData;
  }

  Future<DownloadFileInfo64Model?> downloadFotoStnkAPI(
      String regmv4Id) async {
    DownloadFileInfo64Model? fileInfo;

    String urlGetFileEndPoint =
        "${AppData.prefixEndPoint}/api/regmv/regmv4form/getfotostnk";

    Map<String, String> queryParams = {
      "regmv4Id": regmv4Id,
    };

    debugPrint("downloadFotoStnkAPI #10");

    var uri =
        AppData.uriHtpp(AppData.httpAuthority, urlGetFileEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: AppData.httpHeaders);

    //debugPrint("downloadFotoJobRealAPI #20");

    //debugPrint("downloadFotoJobRealAPI response.statusCode : ${response.statusCode}");

    if (response.statusCode == 200) {
      //debugPrint("downloadFotoJobRealAPI -> response.body #30: ${response.body}");

      fileInfo = DownloadFileInfo64Model.fromJson(jsonDecode(response.body));

      //debugPrint("fileInfo.namafile : ${fileInfo.namafile}");
    }
    return fileInfo;
  }

	Future<bool> regmv4FormHapusAPI(String regmv4Id) async {
		String hapusEndpoint = "${AppData.prefixEndPoint}/api/regmv/regmv4form/delete";
		Map<String, String> queryParams = {
			'regmv4Id': regmv4Id,
			'modul_id': 'regmv4FormHapusAPI'};
		var uri = AppData.uriHtpp(AppData.httpAuthority, hapusEndpoint, queryParams);
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

}
