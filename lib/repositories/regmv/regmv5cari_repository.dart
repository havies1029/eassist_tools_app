import 'package:eassist_tools_app/apis/regmv/regmv5cari_api.dart';
import 'package:eassist_tools_app/models/regmv/regmv5cari_model.dart';

class Regmv5CariRepository {

	Future<List<Regmv5CariModel>> getRegmv5Cari(String regmv1Id) async {
		Regmv5CariAPI api = Regmv5CariAPI();
		return await api.getRegmv5CariAPI(regmv1Id);
	}
}
