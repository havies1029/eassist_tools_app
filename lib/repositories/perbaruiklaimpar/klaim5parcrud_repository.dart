//generate from : usp_flutter_crud_repository

import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/perbaruiklaimpar/klaim5parcrud_api.dart';
import 'package:eassist_tools_app/models/perbaruiklaimpar/klaim5parcrud_model.dart';

class Klaim5parCrudRepository {

	Klaim5parCrudAPI api = Klaim5parCrudAPI();

	Future<ReturnDataAPI> klaim5parCrudTambah(Klaim5parCrudModel record) async {
		return await api.klaim5parCrudTambahAPI(record);
	}
	Future<bool> klaim5parCrudUbah(Klaim5parCrudModel record) async {
		return await api.klaim5parCrudUbahAPI(record);
	}
	Future<bool> klaim5parCrudHapus(String klaim5Id) async {
		return await api.klaim5parCrudHapusAPI(klaim5Id);
	}
	Future<Klaim5parCrudModel?> klaim5parCrudLihat(String klaim5Id) async {
		return await api.klaim5parCrudLihatAPI(klaim5Id);
	}
}
