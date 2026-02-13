//generate from : usp_flutter_crud_repository

import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/perbaruiklaimmv/klaimmvdoccrud_api.dart';
import 'package:eassist_tools_app/models/perbaruiklaimmv/klaimmvdoccrud_model.dart';

class KlaimmvdoccrudRepository {

	KlaimmvdoccrudAPI api = KlaimmvdoccrudAPI();

	Future<ReturnDataAPI> klaimmvdoccrudTambah(KlaimmvdoccrudModel record) async {
		return await api.klaimmvdoccrudTambahAPI(record);
	}
	Future<bool> klaimmvdoccrudUbah(KlaimmvdoccrudModel record) async {
		return await api.klaimmvdoccrudUbahAPI(record);
	}
	Future<bool> klaimmvdoccrudHapus(String klaim5Id) async {
		return await api.klaimmvdoccrudHapusAPI(klaim5Id);
	}
	Future<KlaimmvdoccrudModel?> klaimmvdoccrudLihat(String klaim5Id) async {
		return await api.klaimmvdoccrudLihatAPI(klaim5Id);
	}
}
