import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/gen_calmv/calmv2form_api.dart';
import 'package:eassist_tools_app/models/gen_calmv/calmv2form_model.dart';

class Calmv2FormRepository {

	Calmv2FormAPI api = Calmv2FormAPI();

	Future<ReturnDataAPI> calmv2FormTambah(Calmv2FormModel record) async {
		return await api.calmv2FormTambahAPI(record);
	}
	Future<bool> calmv2FormUbah(Calmv2FormModel record) async {
		return await api.calmv2FormUbahAPI(record);
	}
	Future<bool> calmv2FormHapus(String calmv2Id) async {
		return await api.calmv2FormHapusAPI(calmv2Id);
	}
	Future<Calmv2FormModel> calmv2FormLihat(String calmv1Id) async {
		return await api.calmv2FormLihatAPI(calmv1Id);
	}
}
