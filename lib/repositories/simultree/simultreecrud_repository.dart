import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/simultree/simultreecrud_api.dart';
import 'package:eassist_tools_app/models/simultree/simultreecrud_model.dart';

class SimultreeCrudRepository {

	SimultreeCrudAPI api = SimultreeCrudAPI();

	Future<ReturnDataAPI> simultreeCrudTambah(SimultreeCrudModel record) async {
		return await api.simultreeCrudTambahAPI(record);
	}
	Future<bool> simultreeCrudUbah(SimultreeCrudModel record) async {
		return await api.simultreeCrudUbahAPI(record);
	}
	Future<bool> simultreeCrudHapus(String simultreeId) async {
		return await api.simultreeCrudHapusAPI(simultreeId);
	}
	Future<SimultreeCrudModel> simultreeCrudLihat(String simultreeId) async {
		return await api.simultreeCrudLihatAPI(simultreeId);
	}
	
	Future<SimultreeCrudModel> simultreeCrudInitValue() async {
		return await api.simultreeCrudInitValueAPI();
	}

	Future<ReturnDataAPI> simultreeCrudCalcPremi(SimultreeCrudModel record) async {
		return await api.simultreeCrudCalcPremiAPI(record);
	}
}
