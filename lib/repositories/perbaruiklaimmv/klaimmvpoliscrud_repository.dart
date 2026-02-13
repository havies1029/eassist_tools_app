import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/perbaruiklaimmv/klaimmvpoliscrud_api.dart';
import 'package:eassist_tools_app/models/perbaruiklaimmv/klaimmvpoliscrud_model.dart';

class KlaimmvpoliscrudRepository {

	KlaimmvpoliscrudAPI api = KlaimmvpoliscrudAPI();

	Future<ReturnDataAPI> klaimmvpoliscrudTambah(KlaimmvpoliscrudModel record) async {
		return await api.klaimmvpoliscrudTambahAPI(record);
	}
	Future<bool> klaimmvpoliscrudUbah(KlaimmvpoliscrudModel record) async {
		return await api.klaimmvpoliscrudUbahAPI(record);
	}
	Future<bool> klaimmvpoliscrudHapus(String klaim1Id) async {
		return await api.klaimmvpoliscrudHapusAPI(klaim1Id);
	}
	Future<KlaimmvpoliscrudModel?> klaimmvpoliscrudLihat(String klaim1Id) async {
		return await api.klaimmvpoliscrudLihatAPI(klaim1Id);
	}
}
