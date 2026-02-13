import 'package:eassist_tools_app/apis/perbaruiklaimmv/klaim5upload_api.dart';
import 'package:eassist_tools_app/models/perbaruiklaimmv/klaim5cari_model.dart';

class Klaim5uploadRepository {
  Future<bool> uploadFile(String klaim1Id, Klaim5cariModel item) async {
    Klaim5UploadFileApi api = Klaim5UploadFileApi();
    return await api.uploadFileApi(klaim1Id, item);
  }
}