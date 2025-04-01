import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/simulcar/simulcarcrud_api.dart';
import 'package:eassist_tools_app/models/simulcar/simulcarcrud_model.dart';

class SimulcarCrudRepository {

	SimulcarCrudAPI api = SimulcarCrudAPI();

	Future<ReturnDataAPI> simulcarCrudTambah(SimulcarCrudModel record) async {
		return await api.simulcarCrudTambahAPI(record);
	}
	Future<bool> simulcarCrudUbah(SimulcarCrudModel record) async {
		return await api.simulcarCrudUbahAPI(record);
	}
	Future<bool> simulcarCrudHapus(String simulcarId) async {
		return await api.simulcarCrudHapusAPI(simulcarId);
	}
	Future<SimulcarCrudModel> simulcarCrudLihat(String simulcarId) async {
		return await api.simulcarCrudLihatAPI(simulcarId);
	}
}
