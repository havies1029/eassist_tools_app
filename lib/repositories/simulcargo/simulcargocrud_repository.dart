import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/simulcargo/simulcargocrud_api.dart';
import 'package:eassist_tools_app/models/simulcargo/simulcargocrud_model.dart';

class SimulcargoCrudRepository {

	SimulcargoCrudAPI api = SimulcargoCrudAPI();

	Future<ReturnDataAPI> simulcargoCrudTambah(SimulcargoCrudModel record) async {
		return await api.simulcargoCrudTambahAPI(record);
	}
	Future<bool> simulcargoCrudUbah(SimulcargoCrudModel record) async {
		return await api.simulcargoCrudUbahAPI(record);
	}
	Future<bool> simulcargoCrudHapus(String simulcargoId) async {
		return await api.simulcargoCrudHapusAPI(simulcargoId);
	}
	Future<SimulcargoCrudModel> simulcargoCrudLihat(String simulcargoId) async {
		return await api.simulcargoCrudLihatAPI(simulcargoId);
	}
}
