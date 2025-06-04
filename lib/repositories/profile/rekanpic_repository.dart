import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/profile/rekanpic_api.dart';
import 'package:eassist_tools_app/models/profile/rekanpic_model.dart';

class RekanPicRepository {

	RekanPicAPI api = RekanPicAPI();

	Future<ReturnDataAPI> rekanPicTambah(RekanPicModel record) async {
		return await api.rekanPicTambahAPI(record);
	}
	Future<bool> rekanPicUbah(RekanPicModel record) async {
		return await api.rekanPicUbahAPI(record);
	}
	Future<bool> rekanPicHapus(String mrekanpicId) async {
		return await api.rekanPicHapusAPI(mrekanpicId);
	}
	Future<RekanPicModel> rekanPicLihat(String mrekanpicId) async {
		return await api.rekanPicLihatAPI(mrekanpicId);
	}
}
