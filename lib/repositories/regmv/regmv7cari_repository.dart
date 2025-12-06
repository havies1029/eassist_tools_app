import 'package:eassist_tools_app/apis/regmv/regmv7cari_api.dart';
import 'package:eassist_tools_app/models/regmv/regmv7cari_model.dart';

class Regmv7CariRepository {

	Future<List<Regmv7CariModel>> getRegmv7Cari(String regmv1Id) async {
		Regmv7CariAPI api = Regmv7CariAPI();
		return await api.getRegmv7CariAPI(regmv1Id);
	}
}
