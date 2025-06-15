import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/gen_profile/mrekan1crud_api.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekan1crud_model.dart';

class MRekan1CrudRepository {

	MRekan1CrudAPI api = MRekan1CrudAPI();

	Future<ReturnDataAPI> mRekan1CrudTambah(MRekan1CrudModel record) async {
		return await api.mRekan1CrudTambahAPI(record);
	}
	Future<bool> mRekan1CrudUbah(MRekan1CrudModel record) async {
		return await api.mRekan1CrudUbahAPI(record);
	}
	Future<bool> mRekan1CrudHapus(String mrekan1Id) async {
		return await api.mRekan1CrudHapusAPI(mrekan1Id);
	}
	Future<MRekan1CrudModel> mRekan1CrudLihat(String mrekan1Id) async {
		return await api.mRekan1CrudLihatAPI(mrekan1Id);
	}
}
