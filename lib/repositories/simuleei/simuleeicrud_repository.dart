import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/simuleei/simuleeicrud_api.dart';
import 'package:eassist_tools_app/models/simuleei/simuleeicrud_model.dart';

class SimuleeiCrudRepository {

	SimuleeiCrudAPI api = SimuleeiCrudAPI();

	Future<ReturnDataAPI> simuleeiCrudTambah(SimuleeiCrudModel record) async {
		return await api.simuleeiCrudTambahAPI(record);
	}
	Future<bool> simuleeiCrudUbah(SimuleeiCrudModel record) async {
		return await api.simuleeiCrudUbahAPI(record);
	}
	Future<bool> simuleeiCrudHapus(String simuleei1Id) async {
		return await api.simuleeiCrudHapusAPI(simuleei1Id);
	}
	Future<SimuleeiCrudModel> simuleeiCrudLihat(String simuleei1Id) async {
		return await api.simuleeiCrudLihatAPI(simuleei1Id);
	}

  Future<SimuleeiCrudModel> simulEEICrudInitValue() async {
		return await api.simulEEICrudInitValueAPI();
	}

  Future<ReturnDataAPI> simuleeiCrudCalcPremi(SimuleeiCrudModel record) async {
		return await api.simuleeiCrudCalcPremiAPI(record);
	}
}
