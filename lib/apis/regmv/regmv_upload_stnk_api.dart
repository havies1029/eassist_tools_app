
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:dio/dio.dart';
import 'dart:typed_data';

class RegmvUploadStnkApi {
  final _base = AppData.apiDomain;
  final Dio _dio = Dio();

  Future<bool> uploadStnk(String regmv1Id, String caption, Uint8List imageBytes, String filename) async {
    String uploadStnkEndpoint = "api/regmv/regmv4form/uploadbinaryfotostnk";
    String uploadStnkURL = _base + uploadStnkEndpoint;

    Map<String, String> headers = <String, String>{
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${AppData.userToken}'
    };

    _dio.options.headers = headers;

    try {
      // Step 1: Upload file
      final uploadResponse = await _dio.post(
        uploadStnkURL,
        data: FormData.fromMap({
          'regmv1Id': regmv1Id,
          'caption': caption,
          'filename': filename,
          'file': MultipartFile.fromBytes(imageBytes, filename: filename),
        }),
      );

      if (uploadResponse.statusCode == 200) {
        return true;
      } else {
        return false;
      }
      } catch (e) {
        throw Exception('Gagal mengambil gambar: ${e.toString()}');
      }
    }
  }