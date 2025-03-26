import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';
import 'package:http_parser/http_parser.dart';

final _base = AppData.apiDomain;
const _uploadFotoEndpoint = "api/userprofile/uploadfoto";
final _uploadFotoURL = _base + _uploadFotoEndpoint;

Future<void> uploadImage2API(filepath) async {
  //debugPrint("uploadImage2API #10");

  UserRepository userRepo = UserRepository();
  String token = await userRepo.getUserToken();

  var request = http.MultipartRequest('POST', Uri.parse(_uploadFotoURL));

  Map<String, String> headers = <String, String>{
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token'
  };


  request.headers.addAll(headers);

  request.files.add(await http.MultipartFile.fromPath('image_file', filepath));
  await request.send();
}


Future<void> postImage(File image) async {
  UserRepository userRepo = UserRepository();
  String token = await userRepo.getUserToken();

  String fileName = image.path.split('/').last;

  //debugPrint(fileName);

  try {
    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
        contentType: MediaType("image", "jpeg"),
      )
    });

    Map<String, String> headers = <String, String>{
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token'
    };

    dio.options.headers = headers;

    await dio.post(_uploadFotoURL, data: formData);
    
    /*
    if (response.statusCode == 200) {
      debugPrint("Uploaded");
    } else {
      debugPrint(response.data);
    }
    debugPrint('Out');
    */
    
  } catch (e) {
    //debugPrint(e.toString());
  }
}

