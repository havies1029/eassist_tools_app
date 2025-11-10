import 'dart:typed_data';

import 'package:eassist_tools_app/models/image/downloadfileinfo64.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/gen_regmv/regmv5form_api.dart';

class Regmv5FormRepository {

	Regmv5FormAPI api = Regmv5FormAPI();

	Future<bool> regmv5FormHapus(String regmv5Id) async {
		return await api.regmv5FormHapusAPI(regmv5Id);
	}

  Future<ReturnDataAPI> uploadFileFotoMobil(String regmv5Id, String filePath) async {
    return await api.uploadFileFotoMobil(regmv5Id, filePath);
  }

  Future<ReturnDataAPI> uploadBinaryFotoMobil(String regmv5Id, String fileName, Uint8List bytes) async {
    return await api.uploadBinaryFotoMobil(regmv5Id, fileName, bytes);
  }

  Future<DownloadFileInfo64Model?> downloadFotoMobilAPI(String regmv5Id) async {
    return await api.downloadFotoMobilAPI(regmv5Id);
  }

}
