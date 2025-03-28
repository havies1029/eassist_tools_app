import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/simulgit/simulgitcrud_api.dart';
import 'package:eassist_tools_app/models/simulgit/simulgitcrud_model.dart';

class SimulgitCrudRepository {

	SimulgitCrudAPI api = SimulgitCrudAPI();

	Future<ReturnDataAPI> simulgitCrudTambah(SimulgitCrudModel record) async {
		return await api.simulgitCrudTambahAPI(record);
	}
	Future<bool> simulgitCrudUbah(SimulgitCrudModel record) async {
		return await api.simulgitCrudUbahAPI(record);
	}
	Future<bool> simulgitCrudHapus(String simulgitId) async {
		return await api.simulgitCrudHapusAPI(simulgitId);
	}
	Future<SimulgitCrudModel> simulgitCrudLihat(String simulgitId) async {
		return await api.simulgitCrudLihatAPI(simulgitId);
	}
}
