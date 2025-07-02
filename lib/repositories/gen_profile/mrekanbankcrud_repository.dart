import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/gen_profile/mrekanbankcrud_api.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekanbankcrud_model.dart';
import 'package:flutter/cupertino.dart';

class MRekanBankCrudRepository {

	MRekanBankCrudAPI api = MRekanBankCrudAPI();

	Future<ReturnDataAPI> mRekanBankCrudTambah(MRekanBankCrudModel record) async {
		return await api.mRekanBankCrudTambahAPI(record);
	}
	Future<bool> mRekanBankCrudUbah(MRekanBankCrudModel record) async {
		return await api.mRekanBankCrudUbahAPI(record);
	}
	Future<bool> mRekanBankCrudHapus(String mrekanbankId) async {
		return await api.mRekanBankCrudHapusAPI(mrekanbankId);
	}
	Future<MRekanBankCrudModel> mRekanBankCrudLihat(String mrekanbankId) async {
		debugPrint("📥 [mRekanBankCrudLihat] Dipanggil dengan ID: $mrekanbankId");

		final result = await api.mRekanBankCrudLihatAPI(mrekanbankId);

		debugPrint("📦 [mRekanBankCrudLihat] Data diterima: ${result.toJson()}");

		return result;
	}

}
