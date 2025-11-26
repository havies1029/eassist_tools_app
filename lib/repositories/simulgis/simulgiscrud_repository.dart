import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/simulgis/simulgiscrud_api.dart';
import 'package:eassist_tools_app/models/simulgis/simulgiscrud_model.dart';

class SimulgisCrudRepository {

	SimulgisCrudAPI api = SimulgisCrudAPI();

	Future<ReturnDataAPI> simulgisCrudTambah(SimulgisCrudModel record) async {
		return await api.simulgisCrudTambahAPI(record);
	}
	Future<bool> simulgisCrudUbah(SimulgisCrudModel record) async {
		return await api.simulgisCrudUbahAPI(record);
	}
	Future<bool> simulgisCrudHapus(String simulgisId) async {
		return await api.simulgisCrudHapusAPI(simulgisId);
	}
	Future<SimulgisCrudModel> simulgisCrudLihat(String simulgisId) async {
		return await api.simulgisCrudLihatAPI(simulgisId);
	}

  Future<SimulgisCrudModel> simulGisCrudInitValue() async {
		return await api.simulGisCrudInitValueAPI();
	}

  Future<ReturnDataAPI> simulGisCrudCalcPremi(SimulgisCrudModel record) async {
		return await api.simulGisCrudCalcPremiAPI(record);
	}
}
