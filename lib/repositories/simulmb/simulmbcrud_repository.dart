import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/simulmb/simulmbcrud_api.dart';
import 'package:eassist_tools_app/models/simulmb/simulmbcrud_model.dart';

class SimulmbCrudRepository {

	SimulmbCrudAPI api = SimulmbCrudAPI();

	Future<ReturnDataAPI> simulmbCrudTambah(SimulmbCrudModel record) async {
		return await api.simulmbCrudTambahAPI(record);
	}
	Future<bool> simulmbCrudUbah(SimulmbCrudModel record) async {
		return await api.simulmbCrudUbahAPI(record);
	}
	Future<bool> simulmbCrudHapus(String simulmbId) async {
		return await api.simulmbCrudHapusAPI(simulmbId);
	}
	Future<SimulmbCrudModel> simulmbCrudLihat(String simulmbId) async {
		return await api.simulmbCrudLihatAPI(simulmbId);
	}

	Future<SimulmbCrudModel> simulMbCrudInitValue() async {
		return await api.simulmbCrudInitValueAPI();
	}

	Future<ReturnDataAPI> simulMbCrudCalcPremi(SimulmbCrudModel record) async {
		return await api.simulMbCrudCalcPremiAPI(record);
	}
}
