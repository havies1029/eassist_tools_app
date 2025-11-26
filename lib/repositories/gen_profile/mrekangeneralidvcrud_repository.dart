import 'package:eassist_tools_app/apis/gen_profile/mrekangeneralidvcrud_api.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekangeneralidvcrud_model.dart';

class MRekanGeneralIdvCrudRepository {

	MRekanGeneralIdvCrudAPI api = MRekanGeneralIdvCrudAPI();

	Future<bool> mRekanGeneralIdvCrudUbah(MRekanGeneralIdvCrudModel record) async {
		return await api.mRekanGeneralIdvCrudUbahAPI(record);
	}
	Future<MRekanGeneralIdvCrudModel> mRekanGeneralIdvCrudLihat() async {
		return await api.mRekanGeneralIdvCrudLihatAPI();
	}
}
