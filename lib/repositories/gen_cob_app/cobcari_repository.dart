import 'package:eassist_tools_app/apis/gen_cob_app/cobcari_api.dart';
import 'package:eassist_tools_app/models/gen_cob_app/cobcari_model.dart';

class CobCariRepository {

	Future<List<CobCariModel>> getCobCari() async {
		CobCariAPI api = CobCariAPI();
		return await api.getCobCariAPI();
	}

  Future<List<CobCariModel>> getCobManPolCari() async {
		CobCariAPI api = CobCariAPI();
		return await api.getCobManPolCariAPI();
	}
}
