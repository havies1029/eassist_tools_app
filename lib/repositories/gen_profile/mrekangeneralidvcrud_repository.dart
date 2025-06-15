import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/gen_profile/mrekangeneralidvcrud_api.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekangeneralidvcrud_model.dart';

class MRekanGeneralIdvCrudRepository {

	MRekanGeneralIdvCrudAPI api = MRekanGeneralIdvCrudAPI();

	Future<ReturnDataAPI> mRekanGeneralIdvCrudTambah(MRekanGeneralIdvCrudModel record) async {
		return await api.mRekanGeneralIdvCrudTambahAPI(record);
	}
	Future<bool> mRekanGeneralIdvCrudUbah(MRekanGeneralIdvCrudModel record) async {
		return await api.mRekanGeneralIdvCrudUbahAPI(record);
	}
	Future<bool> mRekanGeneralIdvCrudHapus(String mrekan1Id) async {
		return await api.mRekanGeneralIdvCrudHapusAPI(mrekan1Id);
	}
	Future<MRekanGeneralIdvCrudModel> mRekanGeneralIdvCrudLihat(String mrekan1Id) async {
		return await api.mRekanGeneralIdvCrudLihatAPI(mrekan1Id);
	}
}
