import 'package:eassist_tools_app/apis/gen_profile/mrekanbankcrud_api.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekanbankcrud_model.dart';

class MRekanBankCrudRepository {

	MRekanBankCrudAPI api = MRekanBankCrudAPI();

	Future<bool> mRekanBankCrudUbah(MRekanBankCrudModel record) async {
		return await api.mRekanBankCrudUbahAPI(record);
	}
	Future<MRekanBankCrudModel> mRekanBankCrudLihat() async {
		return await api.mRekanBankCrudLihatAPI();
	}
}
