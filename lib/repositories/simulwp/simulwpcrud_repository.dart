import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/simulwp/simulwpcrud_api.dart';
import 'package:eassist_tools_app/models/simulwp/simulwpcrud_model.dart';

class SimulwpCrudRepository {

	SimulwpCrudAPI api = SimulwpCrudAPI();

	Future<ReturnDataAPI> simulwpCrudTambah(SimulwpCrudModel record) async {
		return await api.simulwpCrudTambahAPI(record);
	}
	Future<bool> simulwpCrudUbah(SimulwpCrudModel record) async {
		return await api.simulwpCrudUbahAPI(record);
	}
	Future<bool> simulwpCrudHapus(String simulwp1Id) async {
		return await api.simulwpCrudHapusAPI(simulwp1Id);
	}
	Future<SimulwpCrudModel> simulwpCrudLihat(String simulwp1Id) async {
		return await api.simulwpCrudLihatAPI(simulwp1Id);
	}
}
