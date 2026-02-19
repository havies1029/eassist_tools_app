//generate from : usp_flutter_crud_repository

import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/klaimlacak/klaimnilaicrud_api.dart';
import 'package:eassist_tools_app/models/klaimlacak/klaimnilaicrud_model.dart';

class KlaimnilaicrudRepository {

	KlaimnilaicrudAPI api = KlaimnilaicrudAPI();

	Future<ReturnDataAPI> klaimnilaicrudTambah(KlaimnilaicrudModel record) async {
		return await api.klaimnilaicrudTambahAPI(record);
	}
	Future<bool> klaimnilaicrudUbah(KlaimnilaicrudModel record) async {
		return await api.klaimnilaicrudUbahAPI(record);
	}
	Future<bool> klaimnilaicrudHapus(String klaimnilaiId) async {
		return await api.klaimnilaicrudHapusAPI(klaimnilaiId);
	}
	Future<KlaimnilaicrudModel?> klaimnilaicrudLihat(String klaimnilaiId) async {
		return await api.klaimnilaicrudLihatAPI(klaimnilaiId);
	}
}
