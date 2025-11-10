import 'dart:typed_data';

import 'package:eassist_tools_app/models/image/downloadfileinfo64.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/gen_regmv/regmv4form_api.dart';

class Regmv4FormRepository {

	Regmv4FormAPI api = Regmv4FormAPI();

  Future<ReturnDataAPI> uploadFileFotoSTNK(String regmv4Id, String filePath) async {
    return await api.uploadFileFotoSTNK(regmv4Id, filePath);
  }

  Future<ReturnDataAPI> uploadBinaryFotoSTNK(String regmv4Id, String fileName, Uint8List bytes) async {
    return await api.uploadBinaryFotoSTNK(regmv4Id, fileName, bytes);
  }

  Future<DownloadFileInfo64Model?> downloadFotoStnkAPI(String regmv4Id) async {
    return await api.downloadFotoStnkAPI(regmv4Id);
  }
	
	Future<bool> regmv4FormHapus(String regmv4Id) async {
		return await api.regmv4FormHapusAPI(regmv4Id);
	}
}
