import 'package:eassist_tools_app/apis/regrenewal/regrenewcari_api.dart';
import 'package:eassist_tools_app/models/regrenewal/regrenewcari_model.dart';

class RegrenewCariRepository {

	Future<List<RegrenewCariModel>> getRegrenewCari(String searchText, int hal) async {
		RegrenewCariAPI api = RegrenewCariAPI();
		return await api.getRegrenewCariAPI(searchText, hal);
	}
}
