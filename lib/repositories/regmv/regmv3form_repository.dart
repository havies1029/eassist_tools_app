import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/regmv/regmv3form_api.dart';
import 'package:eassist_tools_app/models/regmv/regmv3form_model.dart';

class Regmv3FormRepository {

	Regmv3FormAPI api = Regmv3FormAPI();

	Future<ReturnDataAPI> regmv3FormTambah(Regmv3FormModel record) async {
		return await api.regmv3FormTambahAPI(record);
	}
	Future<bool> regmv3FormUbah(Regmv3FormModel record) async {
		return await api.regmv3FormUbahAPI(record);
	}
	Future<bool> regmv3FormHapus(String regmv3Id) async {
		return await api.regmv3FormHapusAPI(regmv3Id);
	}
	Future<Regmv3FormModel> regmv3FormLihat(String regmv3Id) async {
		return await api.regmv3FormLihatAPI(regmv3Id);
	}
}
