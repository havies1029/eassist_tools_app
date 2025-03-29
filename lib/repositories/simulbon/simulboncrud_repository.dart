import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/simulbon/simulboncrud_api.dart';
import 'package:eassist_tools_app/models/simulbon/simulboncrud_model.dart';

class SimulbonCrudRepository {

	SimulbonCrudAPI api = SimulbonCrudAPI();

	Future<ReturnDataAPI> simulbonCrudTambah(SimulbonCrudModel record) async {
		return await api.simulbonCrudTambahAPI(record);
	}
	Future<bool> simulbonCrudUbah(SimulbonCrudModel record) async {
		return await api.simulbonCrudUbahAPI(record);
	}
	Future<bool> simulbonCrudHapus(String simulbon1Id) async {
		return await api.simulbonCrudHapusAPI(simulbon1Id);
	}
	Future<SimulbonCrudModel> simulbonCrudLihat(String simulbon1Id) async {
		return await api.simulbonCrudLihatAPI(simulbon1Id);
	}

  Future<SimulbonCrudModel> simulBonCrudInitValue() async {
		return await api.simulBonCrudInitValueAPI();
	}

  Future<ReturnDataAPI> simulBonCrudCalcPremi(SimulbonCrudModel record) async {
		return await api.simulBonCrudCalcPremiAPI(record);
	}
}
