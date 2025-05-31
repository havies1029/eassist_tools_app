import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/profile/rekangeneral_api.dart';
import 'package:eassist_tools_app/models/profile/rekangeneral_model.dart';

class RekanGeneralRepository {

	RekanGeneralAPI api = RekanGeneralAPI();

	Future<ReturnDataAPI> rekanGeneralTambah(RekanGeneralModel record) async {
		return await api.rekanGeneralTambahAPI(record);
	}
	Future<bool> rekanGeneralUbah(RekanGeneralModel record) async {
		return await api.rekanGeneralUbahAPI(record);
	}
	Future<bool> rekanGeneralHapus(String mrekan1Id) async {
		return await api.rekanGeneralHapusAPI(mrekan1Id);
	}
	Future<RekanGeneralModel> rekanGeneralLihat(String mrekan1Id) async {
		return await api.rekanGeneralLihatAPI(mrekan1Id);
	}
}
